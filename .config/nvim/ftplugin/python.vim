command R w|!python3 ./%

iabbrev pset breakpoint(s)<Esc>1hx
" iabbrev <expr> pset 'breakpoint()' . "\<Esc>F(i"
iabbrev printf print(f"<++>: {<++>}")<Esc>0

inoremap ;FUNC def <++>(<++>)->None:<Enter><++><Enter><Esc>kkk
inoremap ;PERF start_t = time.perf_counter()<Enter>print(<++>)<Enter>elapsed_t = time.perf_counter() - start_t<Enter>print(f"{<++>.__name__}: {datetime.timedelta(elapsed_t)}")<++>
inoremap ;CLASS class <++>:<Enter>def __init__(self, <++>): <Enter><++><Esc>kkk
inoremap ;FOR for <++> in range(<++>): <Enter><++> <Esc>kk
inoremap ;NAME if __name__ == "__main__":<Enter><++><Esc>kk
inoremap ;FROM from  import <++><Esc>11hi

inoremap '' ''<++><Esc>4hi
inoremap "" ""<++><Esc>4hi
inoremap {} {}<++><Esc>4hi
inoremap () ()<++><Esc>4hi
