#
# zoxide
# https://github.com/ajeetdsouza/zoxide
#
# `zi` passes its arguments to fzf as a query, so the file names fish falls back
# to offering are never what you want. Named for `__zoxide_zi` because `zi` is
# an alias wrapping it, and because zoxide's init erases completions for `zi`
# itself, which stops fish autoloading them ever again.
#

complete --command __zoxide_zi --no-files
