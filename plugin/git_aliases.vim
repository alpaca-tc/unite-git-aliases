if exists('g:git_aliases_loaded') || !has('ruby')
  finish
endif
let g:git_aliases_loaded = 1

let s:save_cpo = &cpo
set cpo&vim

let &cpo = s:save_cpo
unlet s:save_cpo
