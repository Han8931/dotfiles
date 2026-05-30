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
let mapleader=","

set nocompatible
set number
set hidden
set nowrap
set cursorline
set mouse=a
set clipboard=unnamedplus
set termguicolors
set background=dark

set tabstop=4
set softtabstop=4
set shiftwidth=4
" set expandtab

set autoindent
set smartindent

set hlsearch
set incsearch
set ignorecase
set smartcase

set scrolloff=8
set sidescrolloff=8
set signcolumn=yes
set updatetime=300
set splitbelow
set splitright
set undofile
set undodir=~/.local/share/nvim/undo

filetype plugin indent on
syntax on

call plug#begin()
    Plug 'vim-airline/vim-airline'
    Plug 'preservim/nerdtree'
    Plug 'ryanoasis/vim-devicons'
    Plug 'junegunn/goyo.vim'

    Plug 'rmehri01/onenord.nvim', { 'branch': 'main' }
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'windwp/nvim-autopairs'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    Plug 'mg979/vim-visual-multi', {'branch': 'master'}
    Plug 'preservim/tagbar'
    Plug 'lervag/vimtex'

    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'tpope/vim-fugitive'
    Plug 'NeogitOrg/neogit'
    Plug 'sindrets/diffview.nvim'
call plug#end()

colorscheme onenord

" NERDTree
let g:NERDTreeDirArrowExpandable="+"
nnoremap <leader>n :NERDTreeToggle<CR>

autocmd bufenter * if winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree() | q | endif

if has('nvim')
    let NERDTreeBookmarksFile = stdpath('data') . '/NERDTreeBookmarks'
endif

" CoC completion
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~# '\s'
endfunction

inoremap <expr> <S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

" Split navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Tab navigation
nnoremap H gT
nnoremap L gt

" Search
nnoremap ,<space> :nohlsearch<CR>

" Telescope
nnoremap <leader>ff <cmd>Telescope find_files hidden=true<CR>
nnoremap <leader>fg <cmd>Telescope live_grep<CR>
nnoremap <leader>fb <cmd>Telescope buffers<CR>
nnoremap <leader>fh <cmd>Telescope help_tags<CR>
nnoremap <leader>fr <cmd>Telescope oldfiles<CR>

" Tagbar
nnoremap <leader>t :TagbarToggle<CR>

" Placeholder jump
inoremap <C-j> <Esc>/<++><CR>"_c4l
nnoremap <C-j> /<++><CR>"_c4l

" Spell only for writing files
autocmd FileType markdown,tex,gitcommit setlocal spell

" Calcurse notes as markdown
autocmd BufRead,BufNewFile /tmp/calcurse* set filetype=markdown
autocmd BufRead,BufNewFile ~/.local/share/calcurse/notes* set filetype=markdown

" Transparent background toggle
let s:normal_bg_color_toggle = 0
let s:default_bg_color = ""

function! ToggleNormalBGColor()
    if s:normal_bg_color_toggle == 0
        let s:default_bg_color = synIDattr(hlID("Normal"), "bg")
        highlight Normal guibg=none
        let s:normal_bg_color_toggle = 1
    else
        execute "highlight Normal guibg=" . s:default_bg_color
        let s:normal_bg_color_toggle = 0
    endif
endfunction

nnoremap <leader>p :call ToggleNormalBGColor()<CR>

" Terminal command
function! s:TERMINAL(...)
    belowright split
    resize 10
    terminal
endfunction

command! TERM call s:TERMINAL()          
