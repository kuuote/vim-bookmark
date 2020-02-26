let s:marks = []

function! bookmark#add(file, showmsg) abort
  let i = index(s:marks, a:file)
  if i != -1
    unlet s:marks[i]
  endif
  call insert(s:marks, a:file)
  if a:showmsg
    echo "Added " .. a:file
  endif
  call bookmark#save(g:bookmark_path)
endfunction

function! bookmark#remove(file) abort
  unlet s:marks[index(s:marks, a:file)]
  echo "Removed " .. a:file
  call bookmark#save(g:bookmark_path)
endfunction

function! bookmark#list() abort
  return copy(s:marks)
endfunction

const s:helpmsg = "d: delete bookmark\n"
          \ .. "?: show help\n"
          \ .. "<Space>: jump to bookmark\n"

function! bookmark#action(file) abort
  echo "Action(Press ? key to show help):"
  let c = getchar()
  redraw
  if c == 32      "<Space>
    "MRU風味
    call bookmark#add(a:file, v:false)
    execute "buf" bufnr(a:file, v:true)
  elseif c == 63  "?
    echo s:helpmsg
    call bookmark#action(a:file)
  elseif c == 100 "d
    call bookmark#remove(a:file)
  else
    echo "Cancelled"
  endif
endfunction

function! bookmark#load(path) abort
  if filereadable(a:path)
    let s:marks = readfile(a:path)
  endif
endfunction

function! bookmark#save(path) abort
  call writefile(s:marks, a:path)
endfunction

