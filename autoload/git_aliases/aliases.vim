function! git_aliases#aliases#define() "{{{
  return { 
    \ 'Reset --soft HEAD^': 'call system("git reset --soft HEAD^")',
    \ 'Remove all branches' : "call system(",
    \ 'Remove local branches' : "call git_aliases#aliases#remove_local_branches()",
    \ 'Remove remote branches' : "call git_aliases#aliases#remove_remote_branches()",
    \ 'Edit file unmerged' : "call git_aliases#aliases#edit_file_unmerged()"
    \ }
endfunction"}}}

function! git_aliases#aliases#remove_all_branches() "{{{
  echo system("git checkout master && git pull origin master && git fetch -p origin && git branch -d $(git branch --merged | grep -v master | grep -v '*') && git push origin $(git branch -r --merged | grep origin/ | grep -v master | sed s~origin/~:~)")
endfunction"}}}

function! git_aliases#aliases#remove_local_branches() "{{{
  echo system("git branch -d $(git branch --merged | grep -v master | grep -v '*')")
endfunction"}}}

function! git_aliases#aliases#remove_remote_branches() "{{{
  echo system("git push origin $(git branch -r --merged | grep origin/ | grep -v master | sed s~origin/~:~)")
endfunction"}}}

function! git_aliases#aliases#edit_file_unmerged() "{{{
  let file_list = split(system('git ls-files --unmerged | cut -f2 | sort -u'), '\n')
  let current_dir = getcwd()

  for file in file_list
    lcd `=current_dir`
    tabedit `=file`
  endfor
endfunction"}}}
