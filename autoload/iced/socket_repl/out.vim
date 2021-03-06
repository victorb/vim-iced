let s:save_cpo = &cpoptions
set cpoptions&vim

function! iced#socket_repl#out#lines(eval_response) abort
  let out = iced#socket_repl#trim_prompt(get(a:eval_response, 'out', ''))
  if empty(out)
    let out = get(a:eval_response, 'value', '')
  endif
  let out = substitute(out, '\(^"\|"$\)', '', 'g')

  if empty(out) | return [] | endif

  let lines = split(out, '\r\?\n')
  if len(lines) <= 1
    let lines = split(out, '\\n')
  endif

  return lines
endfunction

let &cpoptions = s:save_cpo
unlet s:save_cpo
