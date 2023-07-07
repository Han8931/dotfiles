command R w|!./%:r
command C w|!rustc ./%
command Crun w|!cargo run
command Cbuild w|!cargo build

iabbrev main fn main() {<Enter>}
iabbrev print println!("{<++>}",<++>);<Esc>14h
iabbrev if if <++> {<++>}<++>else {<++>}<Esc>29h
