function! git_aliases#append_git_keep#define()"{{{
  return has('ruby') ? { 'Append .git_keep to empty directories': 'call git_aliases#append_git_keep#do()'} : {}
endfunction"}}}

function! git_aliases#append_git_keep#do()"{{{
  let current_dir = getcwd()
  lcd `=git_aliases#current_dir()`
  call system("find . -type d -empty -not -path './.git*' -exec touch {}\\/.gitkeep \\;")
  lcd `=current_dir`
endfunction"}}}
