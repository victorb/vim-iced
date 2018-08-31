let s:save_cpo = &cpo
set cpo&vim

let g:iced#nrepl#cider#debug#print_length = get(g:, 'iced#nrepl#cider#debug#print_length', 10)
let g:iced#nrepl#cider#debug#print_level = get(g:, 'iced#nrepl#cider#debug#print_level', 10)

function! iced#nrepl#cider#debug#init() abort
  if !iced#nrepl#is_connected() | echom iced#message#get('not_connected') | return | endif

  call iced#nrepl#send({
      \ 'op': 'init-debugger',
      \ 'session': iced#nrepl#current_session(),
      \ 'print-length': g:iced#nrepl#cider#debug#print_length,
      \ 'print-level': g:iced#nrepl#cider#debug#print_level,
      \ })
endfunction

function! iced#nrepl#cider#debug#input(key, in) abort
  if !iced#nrepl#is_connected() | echom iced#message#get('not_connected') | return | endif
  call iced#nrepl#send({
      \ 'op': 'debug-input',
      \ 'session': iced#nrepl#current_session(),
      \ 'key': a:key,
      \ 'input': a:in,
      \ })
endfunction

call iced#nrepl#register_handler('init-debugger')
call iced#nrepl#register_handler('debug-input')

let &cpo = s:save_cpo
unlet s:save_cpo