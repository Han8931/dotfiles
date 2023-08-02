command R w|!python3 ./%

iabbrev pset pdb.set_trace()
iabbrev print print(f": {}")


inoremap ;CLASS class <++>:<Enter>def __init__(self, <++>): <Enter><++><Esc>kkk
inoremap ;FOR for <++> in range(<++>): <Enter><++> <Esc>kk
