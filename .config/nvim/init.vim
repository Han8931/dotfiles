"           _____                    _____                    _____          
"          /\    \                  /\    \                  /\    \         
"         /::\____\                /::\    \                /::\____\        
"        /:::/    /               /::::\    \              /::::|   |        
"       /:::/    /               /::::::\    \            /:::::|   |        
"      /:::/    /               /:::/\:::\    \          /::::::|   |        
"     /:::/____/               /:::/__\:::\    \        /:::/|::|   |        
"    /::::\    \              /::::\   \:::\    \      /:::/ |::|   |        
"   /::::::\    \   _____    /::::::\   \:::\    \    /:::/  |::|   | _____  
"  /:::/\:::\    \ /\    \  /:::/\:::\   \:::\    \  /:::/   |::|   |/\    \ 
" /:::/  \:::\    /::\____\/:::/  \:::\   \:::\____\/:: /    |::|   /::\____\
" \::/    \:::\  /:::/    /\::/    \:::\  /:::/    /\::/    /|::|  /:::/    /
"  \/____/ \:::\/:::/    /  \/____/ \:::\/:::/    /  \/____/ |::| /:::/    / 
"           \::::::/    /            \::::::/    /           |::|/:::/    /  
"            \::::/    /              \::::/    /            |::::::/    /   
"            /:::/    /               /:::/    /             |:::::/    /    
"           /:::/    /               /:::/    /              |::::/    /     
"          /:::/    /               /:::/    /               /:::/    /      
"         /:::/    /               /:::/    /               /:::/    /       
"         \::/    /                \::/    /                \::/    /        
"          \/____/                  \/____/                  \/____/         
"
"   2023. 08. 31
"
"
           





let mapleader =","

set number                  " add line numbers
" set relativenumber

set nocompatible            " disable compatibility to old-time vi
set hlsearch                " highlight search 
"set showmatch               " show matching 
"set ignorecase              " case insensitive 
"set mouse=v                 " middle-click paste with 
"set incsearch               " incremental search

set autoindent              " indent a new line the same amount as the line just typed
set tabstop=4               " number of co" a tab 
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set shiftwidth=4            " width for autoindents
"set expandtab               " converts tabs to white space
"set cc=80                  " set an 80 column border for good coding style

" set wildmode=longest,list,full
" set wildmenu
filetype plugin indent on   "allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard

set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim
set spell!                 " enable spell check (may need to download language package)

" set noswapfile            " disable creating swap file
" set backupdir=~/.cache/vim " Directory to store backup files.

call plug#begin()
    Plug 'https://github.com/vim-airline/vim-airline' " Status Bar
    Plug 'https://github.com/preservim/nerdtree' " NERDTree
    Plug 'ryanoasis/vim-devicons' " Developer Icons
    Plug 'junegunn/goyo.vim' " Status Bar
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'https://github.com/tpope/vim-commentary'
    Plug 'https://github.com/preservim/tagbar'
    Plug 'rmehri01/onenord.nvim', { 'branch': 'main' }
    Plug 'windwp/nvim-autopairs'
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'tpope/vim-surround'
	Plug 'mg979/vim-visual-multi', {'branch': 'master'}

	" Just install sudo pacman -S ripgrep  " To use ripgrep
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'

    Plug 'nvim-lua/plenary.nvim'
	Plug 'sharkdp/fd'

	" Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
	Plug 'lervag/vimtex'

	" Plug 'ellisonleao/glow.nvim'

	" Plug 'nvim-tree/nvim-web-devicons' " optional
	" Plug 'nvim-tree/nvim-tree.lua'
call plug#end()

colorscheme onenord

"======================================
" NerdTree Setup

" Open Vim with NERDTree:
" autocmd vimenter * NERDTree

let g:NERDTreeDirArrowExpandable="+"
	map <leader>n :NERDTreeToggle<CR>
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    if has('nvim')
        let NERDTreeBookmarksFile = stdpath('data') . '/NERDTreeBookmarks'
    else
        let NERDTreeBookmarksFile = '~/.vim' . '/NERDTreeBookmarks'
    endif
"======================================

"======================================
" CoC Complete
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <expr> <Enter> coc#pum#visible() ? coc#pum#confirm() : "\<Enter>"
"======================================

" FZF preview window setup
let g:fzf_preview_window = ['hidden,right,50%,<70(up,40%)', 'ctrl-/']

" Shortcutting split navigation, saving a keypress:
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

map H gT
map L gt

inoremap <c-j> <Esc>/<++><Enter>"_c4l
nnoremap <c-j> <Esc>/<++><Enter>"_c4l

" For spell checker navigation
inoremap <c-s> ]s
nnoremap <c-s> ]s

nnoremap ,<space> :nohlsearch<CR>
map <leader>g :Rg<CR>
map <leader>f :FZF<CR>
map <leader>t :Tagbar<CR>
" map <leader>p :highlight Normal guibg=none<CR>
" map <leader>h :highlight Normal guibg=#2e3440<CR>

let s:normal_bg_color_toggle = 0
let s:default_bg_color = ""

function! ToggleNormalBGColor()
    if s:normal_bg_color_toggle == 0
        " Capture the default background color
        let s:default_bg_color = synIDattr(hlID("Normal"), "bg")

        " Set background color to none
        highlight Normal guibg=none
        let s:normal_bg_color_toggle = 1
    else
        " Restore default background color
        execute "highlight Normal guibg=" . s:default_bg_color
        let s:normal_bg_color_toggle = 0
    endif
endfunction

nnoremap <leader>p :call ToggleNormalBGColor()<CR>




function! s:TERMINAL(...)
	execute printf('belowright split | resize 10 | terminal')
endfunction

command TERM call s:TERMINAL()


" nnoremap <C-p> :Telescope live_grep<CR>
" nnoremap fzf :Telescope find_files<CR>
" cnoremap fzf Telescope find_files


" In case of using nvim-tree
" lua << EOF
" vim.g.loaded_netrw = 1
" vim.g.loaded_netrwPlugin = 1
" vim.opt.termguicolors = true
" require("nvim-tree").setup()
" EOF

autocmd BufRead,BufNewFile /tmp/calcurse* set filetype=markdown
autocmd BufRead,BufNewFile ~/.local/share/calcurse/notes* set filetype=markdown

" lua << EOF
" require('glow').setup({
"   style = "dark",
"   width = 150,
" })
" EOF

