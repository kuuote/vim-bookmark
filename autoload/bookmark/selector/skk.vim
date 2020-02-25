"SKK like selector

let g:skk_selector_keys = get(g:, "skk_selector_keys", "asdfjkl")
let g:skk_selector_prev = get(g:, "skk_selector_prev", "x")
let g:skk_selector_next = get(g:, "skk_selector_next", "\<Space>")

function! bookmark#selector#skk#call() abort
  let l = bookmark#list()
  let keys = split(g:skk_selector_keys, '\zs')
  let chars = map(copy(keys), "char2nr(v:val)")
  let prev = char2nr(g:skk_selector_prev)
  let next = char2nr(g:skk_selector_next)
  let pagecnt = ceil(len(l)/len(keys))
  let page = 0
  while 1
    redraw
    let s = page * len(keys)
    let sl = l[s : s + len(keys) - 1]
    echo join(map(copy(sl), "printf('%s: %s', keys[v:key], v:val)"), "\n") .. "\n>"
    let c = getchar()
    if c == prev
      let page = max([0, page - 1])
    elseif c == next
      let page = min([pagecnt - 1, page + 1])
    else
      let idx = index(chars, c)
      if idx != -1
        return bookmark#action(sl[idx])
      endif
      return
    endif
  endwhile
endfunction

