command R w|!python3 ./%

iabbrev pset breakpoint()
iabbrev printf print(f": {}")

inoremap ;PERF start_t = time.perf_counter()<Enter>print(<++>)<Enter>elapsed_t = time.perf_counter() - start_t<Enter>print(f"{<++>.__name__}: {datetime.timedelta(elapsed_t)}")<++>
inoremap ;CLASS class <++>:<Enter>def __init__(self, <++>): <Enter><++><Esc>kkk
inoremap ;FOR for <++> in range(<++>): <Enter><++> <Esc>kk
