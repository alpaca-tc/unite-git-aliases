function! s:current_git() "{{{
  let current_dir = getcwd()
  if !exists("s:git_root_cache") | let s:git_root_cache = {} | endif
  if has_key(s:git_root_cache, current_dir)
    return s:git_root_cache[current_dir]
  endif

  let git_root = system('git rev-parse --show-toplevel')
  if git_root =~ "fatal: Not a git repository"
    " throw "No a git repository."
    return ""
  endif

  let s:git_root_cache[current_dir] = substitute(git_root, '\n', '', 'g')

  return s:git_root_cache[current_dir]
endfunction"}}}

function! git_aliases#current_dir() "{{{
  return s:current_git()
endfunction"}}}

function! git_aliases#candidates() "{{{
  if empty(s:current_git())
    echomsg 'Not git Directory'
    return {}
  endif

  let rel_path = 'autoload/git_aliases/*.vim'
  let candidates  = map(split(globpath(&runtimepath, rel_path), "\<NL>") , 
                     \ 'fnamemodify(v:val , ":t:r")')

  let list = {}
  for v in candidates
    let Fn = function('git_aliases#' . v . '#define')
    let candidate = Fn()
    call extend(list, candidate)
  endfor

  return list
endfunction"}}}
