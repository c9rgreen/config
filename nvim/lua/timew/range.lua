-- timew.range — the date ranges the interval view shows.
--
-- timew resolves its own ranges but never says what it resolved them to, and
-- the view needs the bounds: to group by day, to clip intervals that run
-- past midnight, and to step back and forward. So the view resolves them
-- itself, in local time, and hands timew explicit bounds. A range is a start
-- day plus a length in days, or in months so that stepping through months
-- lands on the 1st. The end is exclusive, as it is for timew.
--
-- Accepted, with or without timew's leading colon: day today yesterday week
-- lastweek fortnight month lastmonth quarter lastquarter year lastyear, a
-- weekday name (the latest one before today), 7d or 2w (the last N days to
-- today), 2026-09 (a month), 2026-09-21 (a day), and 2026-09-01 - 2026-09-15
-- (with `-`, `to` or `until` between, and an optional `from` before).

local M = {}

M.WORDS = {
   'day', 'today', 'yesterday', 'week', 'lastweek', 'fortnight', 'month', 'lastmonth',
   'quarter', 'lastquarter', 'year', 'lastyear',
   'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday',
}

local WDAY = { sunday = 1, monday = 2, tuesday = 3, wednesday = 4, thursday = 5, friday = 6, saturday = 7 }

-- Days are {year, month, day} tables. Noon keeps DST shifts from moving the
-- date when os.time normalises an out-of-range day or month.
local function time(d, hour)
   return os.time({ year = d.year, month = d.month, day = d.day, hour = hour or 12 })
end

local function norm(d)
   local t = os.date('*t', time(d))
   return { year = t.year, month = t.month, day = t.day }
end

local function today()
   local t = os.date('*t')
   return { year = t.year, month = t.month, day = t.day }
end

local function add_days(d, n)
   return norm({ year = d.year, month = d.month, day = d.day + n })
end

local function add_months(d, n)
   return norm({ year = d.year, month = d.month + n, day = d.day })
end

local function monday(d)
   return add_days(d, -((os.date('*t', time(d)).wday + 5) % 7))
end

local function date(s)
   local y, m, d = (s or ''):match('^(%d%d%d%d)%-(%d%d)%-(%d%d)$')
   return y and norm({ year = tonumber(y), month = tonumber(m), day = tonumber(d) })
end

local function days(n, start)
   return { start = start, days = n }
end

local function months(n, start)
   return { start = start, months = n }
end

-- The range named by a word, or nil.
local function word(w)
   w = w:gsub('^:', '')
   local t = today()
   local first = { year = t.year, month = t.month, day = 1 }
   local q = { year = t.year, month = t.month - (t.month - 1) % 3, day = 1 }
   if w == 'day' or w == 'today' then
      return days(1, t)
   elseif w == 'yesterday' then
      return days(1, add_days(t, -1))
   elseif w == 'week' then
      return days(7, monday(t))
   elseif w == 'lastweek' then
      return days(7, add_days(monday(t), -7))
   elseif w == 'fortnight' then
      return days(14, add_days(monday(t), -7))
   elseif w == 'month' then
      return months(1, first)
   elseif w == 'lastmonth' then
      return months(1, add_months(first, -1))
   elseif w == 'quarter' then
      return months(3, q)
   elseif w == 'lastquarter' then
      return months(3, add_months(q, -3))
   elseif w == 'year' then
      return months(12, { year = t.year, month = 1, day = 1 })
   elseif w == 'lastyear' then
      return months(12, { year = t.year - 1, month = 1, day = 1 })
   elseif WDAY[w] then
      local back = (os.date('*t', time(t)).wday - WDAY[w] + 6) % 7 + 1
      return days(1, add_days(t, -back))
   end
   local n, unit = w:match('^(%d+)([dw])$')
   if n then
      n = tonumber(n) * (unit == 'w' and 7 or 1)
      return n > 0 and days(n, add_days(t, 1 - n)) or nil
   end
   local y, m = w:match('^(%d%d%d%d)%-(%d%d)$')
   if y then
      return months(1, { year = tonumber(y), month = tonumber(m), day = 1 })
   end
   local d = date(w)
   return d and days(1, d)
end

local function between(a, b)
   return math.floor((time(b) - time(a)) / 86400 + 0.5)
end

-- Read a range from the front of `words` and return it with the words left
-- over (the tags), or nil and the words when they do not start with one.
function M.parse(words)
   local i = words[1] == 'from' and 2 or 1
   local a = date(words[i])
   local sep = words[i + 1]
   if a and (sep == '-' or sep == 'to' or sep == 'until') then
      local b = date(words[i + 2])
      if b and between(a, b) > 0 then
         return days(between(a, b), a), vim.list_slice(words, i + 3)
      end
   end
   local r = words[i] and word(words[i])
   if r then
      return r, vim.list_slice(words, i + 1)
   end
   return nil, words
end

-- Start and end as epoch seconds, at local midnight.
function M.bounds(r)
   local s = r.start
   local to = r.months and { year = s.year, month = s.month + r.months, day = s.day }
      or { year = s.year, month = s.month, day = s.day + r.days }
   return time(s, 0), time(to, 0)
end

-- The same length, `n` lengths later (earlier when negative).
function M.shift(r, n)
   if r.months then
      return months(r.months, add_months(r.start, n * r.months))
   end
   return days(r.days, add_days(r.start, n * r.days))
end

local function fmt(d, f)
   return os.date(f or '%Y-%m-%d', time(d))
end

-- The range as input that M.parse reads back.
function M.text(r)
   if r.months == 1 and r.start.day == 1 then
      return fmt(r.start, '%Y-%m')
   elseif r.days == 1 then
      return fmt(r.start)
   end
   local _, to = M.bounds(r)
   return fmt(r.start) .. ' - ' .. os.date('%Y-%m-%d', to + 43200)
end

-- The range for a title: a day, a month, or first to last day.
function M.label(r)
   if r.days == 1 then
      return fmt(r.start, '%a %Y-%m-%d')
   elseif r.months == 1 and r.start.day == 1 then
      return fmt(r.start, '%B %Y')
   elseif r.months == 3 and r.start.day == 1 and r.start.month % 3 == 1 then
      return ('Q%d %d'):format((r.start.month + 2) / 3, r.start.year)
   elseif r.months == 12 and r.start.day == 1 and r.start.month == 1 then
      return tostring(r.start.year)
   end
   local _, to = M.bounds(r)
   return fmt(r.start, '%a %Y-%m-%d') .. ' – ' .. os.date('%a %Y-%m-%d', to - 43200)
end

-- Local midnight at the start of every day in the range.
function M.days(r)
   local from, to = M.bounds(r)
   local out, d = {}, r.start
   local t = time(d, 0)
   while t < to do
      out[#out + 1] = t
      d = add_days(d, 1)
      t = time(d, 0)
   end
   return out, from, to
end

return M
