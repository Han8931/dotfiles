command R w|!go run ./%

iabbrev printf fmt.Print("<++>: %v",<++>)<Esc>20h
iabbrev println fmt.Println(<++>)<Esc>15h
"
" inoremap ;PERF start_t = time.perf_counter()<Enter>print(<++>)<Enter>elapsed_t = time.perf_counter() - start_t<Enter>print(f"{<++>.__name__}: {datetime.timedelta(elapsed_t)}")<++>
" inoremap ;CLASS class <++>:<Enter>def __init__(self, <++>): <Enter><++><Esc>kkk
" inoremap ;FOR for <++> in range(<++>): <Enter><++> <Esc>kk
" inoremap ;MAIN if __name__ == "__main__":<Enter><++><Esc>kk
" inoremap ;FROM from  import <++><Esc>11hi

inoremap '' ''<++><Esc>4hi
inoremap "" ""<++><Esc>4hi
inoremap {} {}<++><Esc>4hi
inoremap () ()<++><Esc>4hi
inoremap [] []<++><Esc>4hi
