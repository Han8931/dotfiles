command R w|!./%:r
command C w|!rustc ./%
command CR w|!rustc ./%|!./%:r

iabbrev main fn main() {<Enter>}
iabbrev print println!("{<++>}",<++>);<Esc>14h
iabbrev if if <++> {<++><Enter>}else {<++><Enter>}<Esc>37h
