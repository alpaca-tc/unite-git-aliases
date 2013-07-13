if exists('g:git_aliases_loaded') || !has('ruby')
  finish
endif
let g:git_aliases_loaded = 1

let s:save_cpo = &cpo
set cpo&vim

let g:unite_source_menu_menus = get(g:, 'unite_source_menu_menus', {})
let g:unite_source_menu_menus.git_aliases = {
      \ 'description' : 'command alias',
      \ 'command_candidates' : {},
      \ }
let g:unite_source_menu_menus.git_aliases.command_candidates = git_aliases#candidates()

let &cpo = s:save_cpo
unlet s:save_cpo
