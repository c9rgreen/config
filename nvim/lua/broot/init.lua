-- broot — explore directories with broot and open what you pick.
--
-- Runs broot in a centered floating terminal, with the preview panel open
-- and following the selection. Enter on a file opens it in the
-- window you came from; ctrl-s, ctrl-v and ctrl-t open it in a split, a
-- vertical split or a new tab (the same keys as mini.pick). Files staged with
-- ctrl-g are all opened together when one of those keys is pressed in the
-- staging panel. After a content search (c/pattern) the cursor lands on the
-- matching line. alt-Enter on a directory makes it Neovim's working
-- directory, like br does for the shell. Everything else is plain broot, with
-- your own broot configuration and skin loaded.
--
-- How it works: broot is started as br starts it, with an --outcmd file, plus
-- an extra config file binding those keys to from_shell verbs. Like br's cd,
-- such a verb makes broot write the finished command line to the file and
-- quit; the line is parsed when the job exits.

local M = {}

-- Key bindings added to broot. `action` is how the file is opened. apply_to
-- file leaves Enter on a directory to broot itself (it focuses the directory).
local VERBS = {
   { key = 'enter', action = 'edit' },
   { key = 'ctrl-s', action = 'split' },
   { key = 'ctrl-v', action = 'vsplit' },
   { key = 'ctrl-t', action = 'tabedit' },
}

-- First word of the command lines the verbs produce; `cd` is broot's own.
local OPEN_CMD = 'nvim_open'

-- {file:space-separated} merges a staged selection into one command, where
-- {file} alone would refuse to run over several files.
local function conf_verbs()
   local verbs = {}
   for _, v in ipairs(VERBS) do
      verbs[#verbs + 1] = {
         invocation = 'nvim_' .. v.action,
         key = v.key,
         apply_to = 'file',
         from_shell = true,
         external = ('%s %s {line} {file:space-separated}'):format(OPEN_CMD, v.action),
      }
   end
   return verbs
end

-- The extra config file for broot. Written as JSON, which hjson accepts; the
-- name still has to end in .hjson or broot refuses it. It is rewritten on
-- every launch: it is tiny, and json.encode's key order is not stable enough
-- to compare against the previous file.
local function nvim_conf()
   local dir = vim.fs.joinpath(vim.fn.stdpath('state'), 'broot')
   local path = vim.fs.joinpath(dir, 'nvim.hjson')
   vim.fn.mkdir(dir, 'p')
   vim.fn.writefile({ vim.json.encode({ verbs = conf_verbs() }) }, path)
   return path
end

-- The user's own broot config file, since --conf replaces the default list
-- instead of adding to it. Its relative imports (verbs, skins) still resolve.
local function user_conf()
   local dirs = {}
   if vim.env.BROOT_CONFIG_DIR then
      dirs[#dirs + 1] = vim.env.BROOT_CONFIG_DIR
   end
   dirs[#dirs + 1] = vim.fs.joinpath(vim.env.XDG_CONFIG_HOME or vim.fn.expand('~/.config'), 'broot')
   if vim.fn.has('mac') == 1 then
      dirs[#dirs + 1] = vim.fn.expand('~/Library/Application Support/org.dystroy.broot')
   end
   for _, dir in ipairs(dirs) do
      for _, name in ipairs({ 'conf.hjson', 'conf.toml' }) do
         local path = vim.fs.joinpath(dir, name)
         if vim.uv.fs_stat(path) then
            return path
         end
      end
   end
end

-- Split a shell command line into words, undoing the quoting broot applies
-- to paths with special characters: 'sub dir/a b.txt', or 'it'"'"'s.txt'
-- for an apostrophe.
local function shell_words(line)
   local words, word, quote, i = {}, nil, nil, 1
   while i <= #line do
      local c = line:sub(i, i)
      if quote then
         if c == quote then
            quote = nil
         elseif c == '\\' and quote == '"' and i < #line then
            i = i + 1
            word = word .. line:sub(i, i)
         else
            word = word .. c
         end
      elseif c == "'" or c == '"' then
         quote = c
         word = word or ''
      elseif c == '\\' and i < #line then
         i = i + 1
         word = (word or '') .. line:sub(i, i)
      elseif c:match('%s') then
         if word then
            words[#words + 1] = word
            word = nil
         end
      else
         word = (word or '') .. c
      end
      i = i + 1
   end
   if word then
      words[#words + 1] = word
   end
   return words
end

local function read_lines(path)
   local f = io.open(path, 'r')
   if not f then
      return {}
   end
   local content = f:read('a')
   f:close()
   return vim.split(content, '\n', { trimempty = true })
end

-- Carry out the command lines broot wrote: `cd <dir>` from alt-Enter on a
-- directory, or `nvim_open <action> <line> <file>...` from the verbs above.
local function run_outcmd(lines)
   for _, line in ipairs(lines) do
      local words = shell_words(line)
      if words[1] == 'cd' and words[2] and vim.fn.isdirectory(words[2]) == 1 then
         vim.cmd.cd(vim.fn.fnameescape(words[2]))
         vim.notify('broot: cd ' .. vim.fn.fnamemodify(words[2], ':~'))
      elseif words[1] == OPEN_CMD and words[2] and vim.fn.exists(':' .. words[2]) == 2 then
         local action, lnum = words[2], tonumber(words[3]) or 0
         for i = 4, #words do
            -- Keep going when one file fails to open (swap prompt aborted,
            -- unreadable, 'nohidden' with a modified buffer).
            local ok, err = pcall(vim.cmd[action], vim.fn.fnameescape(words[i]))
            if not ok then
               vim.notify('broot: ' .. err, vim.log.levels.ERROR)
            elseif lnum > 1 then
               -- {line} is 1 whenever the preview panel is open, search or
               -- not; a fresh :edit lands there anyway, so only jump past it.
               pcall(vim.api.nvim_win_set_cursor, 0, { lnum, 0 })
            end
         end
      end
   end
end

local function float_config(title)
   local cols, lines = vim.o.columns, vim.o.lines - vim.o.cmdheight
   local width = math.max(math.min(cols - 4, math.max(math.floor(cols * 0.9), 40)), 1)
   local height = math.max(math.min(lines - 4, math.max(math.floor(lines * 0.85), 10)), 1)
   return {
      relative = 'editor',
      width = width,
      height = height,
      col = math.max(math.floor((cols - width) / 2), 0),
      row = math.max(math.floor((lines - height) / 2) - 1, 0),
      style = 'minimal',
      border = 'rounded',
      title = title,
      title_pos = 'center',
   }
end

--- opts.path: a directory to root broot at, or a file to start selected
--- (broot roots at its parent). Defaults to the current working directory.
function M.open(opts)
   opts = opts or {}
   if vim.fn.executable('broot') ~= 1 then
      return vim.notify('broot: executable not found', vim.log.levels.ERROR)
   end

   local path = opts.path
   if not path or path == '' or not vim.uv.fs_stat(path) then
      path = vim.fn.getcwd()
   end
   path = vim.fn.fnamemodify(path, ':p'):gsub('(.)/$', '%1')
   local root = vim.fn.isdirectory(path) == 1 and path or vim.fs.dirname(path)

   -- broot appends to the file and fails if it does not exist.
   local outcmd = vim.fn.tempname()
   vim.fn.writefile({}, outcmd)

   -- Ours goes first so its keys win over any of the user's on the same key.
   local confs = { nvim_conf() }
   confs[#confs + 1] = user_conf()
   -- --cmd opens the preview panel at startup; it then follows the selection.
   local cmd = {
      'broot', '--conf', table.concat(confs, ';'), '--outcmd', outcmd,
      '--cmd', ':open_preview', path,
   }

   local prev_win = vim.api.nvim_get_current_win()
   local buf = vim.api.nvim_create_buf(false, true)
   local title = ' broot: ' .. vim.fn.fnamemodify(root, ':~') .. ' '
   local win = vim.api.nvim_open_win(buf, true, float_config(title))
   vim.wo[win].winhighlight = 'NormalFloat:Normal'
   local augroup = vim.api.nvim_create_augroup('broot.' .. buf, { clear = true })

   local job = vim.fn.jobstart(cmd, {
      term = true,
      cwd = root,
      on_exit = function()
         vim.schedule(function()
            pcall(vim.api.nvim_del_augroup_by_id, augroup)
            if vim.api.nvim_win_is_valid(win) then
               vim.api.nvim_win_close(win, true)
            end
            if vim.api.nvim_buf_is_valid(buf) then
               vim.api.nvim_buf_delete(buf, { force = true })
            end
            local lines = read_lines(outcmd)
            os.remove(outcmd)
            if vim.api.nvim_win_is_valid(prev_win) then
               vim.api.nvim_set_current_win(prev_win)
            end
            run_outcmd(lines)
         end)
      end,
   })
   if job <= 0 then
      vim.api.nvim_del_augroup_by_id(augroup)
      vim.api.nvim_win_close(win, true)
      return vim.notify('broot: failed to start', vim.log.levels.ERROR)
   end

   -- Closing the float some other way (:q after leaving terminal mode) ends
   -- broot too; on_exit then does the rest.
   vim.api.nvim_create_autocmd('WinClosed', {
      group = augroup,
      pattern = tostring(win),
      once = true,
      callback = function()
         vim.fn.jobstop(job)
      end,
   })
   -- Not buffer-local: that would only fire while the terminal buffer is the
   -- current one, and the float should keep fitting after <C-w>p too.
   vim.api.nvim_create_autocmd('VimResized', {
      group = augroup,
      callback = function()
         if vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_win_set_config(win, float_config(title))
         end
      end,
   })

   -- broot itself hands a double-clicked file to the system opener. The
   -- first click has already selected the entry, so swallow the second and
   -- press Enter for it, which goes through the verbs above (and still
   -- focuses a directory).
   vim.keymap.set('t', '<2-LeftMouse>', function()
      vim.fn.chansend(job, '\r')
   end, { buffer = buf, desc = 'Open entry' })

   vim.cmd.startinsert()
end

return M
