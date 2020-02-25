" Bookmark plugin
" Author: kuuote <znmxodq1@gmail.com>
" License: MIT

let s:vimdir = $HOME .. (has("win32") ? "/vimfiles" : "/.vim")
let g:bookmark_path = get(g:, "bookmark_path", s:vimdir .. "/bookmark.lst")
let g:bookmark_selector = get(g:, "bookmark_selector", "skk")

if exists('g:loaded_bookmark')
  finish
endif
let g:loaded_bookmark = 1

call bookmark#load(g:bookmark_path)

nnoremap <Plug>(bookmark-add) :<C-u>call bookmark#add(expand("%:p"), v:true)<CR>
nnoremap <Plug>(bookmark-select) :<C-u>call bookmark#selector#{g:bookmark_selector}#call()<CR>

" vim: set et:
