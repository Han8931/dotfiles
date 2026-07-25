command! -buffer R
      \ update <bar>
      \ execute '!python3 ' . shellescape(expand('%:p'))

iabbrev <buffer> pset breakpoint(s)<Esc>1hx
" iabbrev <expr> pset 'breakpoint()' . "\<Esc>F(i"
iabbrev <buffer> printf print(f"<++>: {<++>}")<Esc>16h

inoremap <buffer> ;" """<Enter><++><Enter>"""<Enter><++><Esc>4k

inoremap <buffer> ;DOCS """<Enter><++><Enter>"""<Enter><++><Esc>kkk
inoremap <buffer> ;FUNC def <++>(<++>)->None:<Enter><++><Enter><Esc>kkk
inoremap <buffer> ;PERF start_t = time.perf_counter()<Enter>print(<++>)<Enter>elapsed_t = time.perf_counter() - start_t<Enter>print(f"{<++>.__name__}: {datetime.timedelta(elapsed_t)}")<++>
inoremap <buffer> ;CLASS class <++>:<Enter>def __init__(self, <++>): <Enter><++><Esc>kkk
inoremap <buffer> ;FOR for <++> in range(<++>): <Enter><++> <Esc>kk
inoremap <buffer> ;MAIN if __name__ == "__main__":<Enter><++><Esc>kk
inoremap <buffer> ;FROM from  import <++><Esc>11hi

inoremap <buffer> '' ''<++><Esc>4hi
inoremap <buffer> "" ""<++><Esc>4hi
inoremap <buffer> {} {}<++><Esc>4hi
inoremap <buffer> () ()<++><Esc>4hi
inoremap <buffer> [] []<++><Esc>4hi
