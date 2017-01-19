function! GetCurrentContent(file)
  let l:content = getline(0,line("$"))
  let l:result = 0
  for l:temp in l:content
    if strlen(l:temp)> 0
      let l:result = 1
      break
    endif
  endfor
  if l:result == 0
    exe InitJSX(a:file)
  endif
endfunction

function! InitJSX(file)
  let filename = fnamemodify(a:file, ':t:r')
  call inputsave()
  echom "New JSX file. Choose component:"
  echom "1. Functional component"
  echom "2. Functional component connected to store"
  echom "3. Stateful component"
  echom "4. Stateful component connected to store"
  let choice = input('Choose one: ')
  let componentname = input('Component name (leave empty for ' . filename . ' ): ')
  call inputrestore()
  if choice ==? 1
    let component = expand("<sfile>:p:h") . "/../components/ReactFunctionalComponent.jsx"
  elseif choice ==? 2
    let component = expand("<sfile>:p:h") . "/../components/ReactFunctionalConnectedComponent.jsx"
  elseif choice ==? 3
    let component = expand("<sfile>:p:h") . "/../components/ReactStatefulComponent.jsx"
  elseif choice ==? 4
    let component = expand("<sfile>:p:h") . "/../components/ReactStatefulConnectedComponent.jsx"
  endif
  :execute ":r" . component
  :normal! kdd
  if componentname ==? ''
    :execute ":%s/TemplateComponent/" . filename . "/g"
  else
    :execute ":%s/TemplateComponent/" . componentname . "/g"
  endif
  :normal! <cr>
  :w
endfunction

augroup jsxgroup
  au!
  au BufEnter *.jsx :call GetCurrentContent(expand("<afile>"))
augroup END
