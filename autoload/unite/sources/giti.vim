" File:    giti.vim
" Author:  kmnk <kmnknmk+vim@gmail.com>
" Version: 0.1.0
" License: MIT Licence

let s:save_cpo = &cpo
set cpo&vim

function! unite#sources#giti#define()"{{{
  return add(map(
\   map(s:get_commands(), 's:to_define_func(v:val)'),
\   'call(v:val, [])'
\ ), s:source)
endfunction"}}}

let s:source = {
\ 'name' : 'giti',
\ 'description' : 'disp giti sources',
\}

function! s:source.gather_candidates(args, context)"{{{
  call unite#print_message('[giti] giti sources')
  return map(s:get_commands(), '{
\   "word"   : v:val,
\   "source" : s:source.name,
\   "kind"   : "source",
\   "action__source_name" : "giti/" . v:val,
\ }')
endfunction"}}}

" local functions {{{
function! s:get_commands()"{{{
  return map(
\   split(
\     globpath(&runtimepath, 'autoload/unite/sources/giti/*.vim'),
\     '\n'
\   ),
\   'fnamemodify(v:val, ":t:r")'
\ )
endfunction"}}}

function! s:to_define_func(command)"{{{
  return 'unite#sources#giti#' . a:command . '#define'
endfunction}}}
" }}}

let &cpo = s:save_cpo
unlet s:save_cpo
" __END__
