command! -buffer R
      \ update <bar>
      \ execute '!rustc '
      \ . shellescape(expand('%:p'))
      \ . ' -o '
      \ . shellescape(expand('%:p:r'))
      \ . ' && '
      \ . shellescape(expand('%:p:r'))

command! -buffer C
      \ update <bar>
      \ execute '!rustc ' . shellescape(expand('%:p'))

command! -buffer Crun update <bar> !cargo run
command! -buffer Cbuild update <bar> !cargo build

iabbrev <buffer> main fn main() {<Enter>}
iabbrev <buffer> print println!("{<++>}",<++>);<Esc>14h
iabbrev <buffer> println println!("{<++>}",<++>);<Esc>14h
iabbrev <buffer> if if <++> {<++>}<++>else {<++>}<Esc>29h

inoremap <buffer> '' ''<++><Esc>4hi
inoremap <buffer> "" ""<++><Esc>4hi
inoremap <buffer> {} {}<++><Esc>4hi
inoremap <buffer> () ()<++><Esc>4hi
inoremap <buffer> [] []<++><Esc>4hi
