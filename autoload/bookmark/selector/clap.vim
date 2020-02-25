function! s:sink(file) abort
  " neovimだと何の問題もない
  if has("nvim")
    return bookmark#action(s:file)
  endif
  " vimでは複数行echoした際の挙動が非同期呼び出しの場合若干違う
  " 仕方ないのでユーザーのふりをする
  call feedkeys(printf(":call bookmark#action(\"%s\")\<CR>", a:file), "n")
endfunction

let g:clap_provider_bookmark = {
      \ "source": function("bookmark#list"),
      \ "sink": function("s:sink"),
      \ "support_open_action": v:true,
      \ }

function! bookmark#selector#clap#call() abort
  Clap bookmark
endfunction
