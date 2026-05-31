""           _____                    _____                    _____          
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
"   2026. 05. 30
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
    " Plug 'neoclide/coc.nvim', {'branch': 'release'}

	Plug 'neovim/nvim-lspconfig'
	Plug 'mason-org/mason.nvim'
	Plug 'mason-org/mason-lspconfig.nvim'

	Plug 'hrsh7th/nvim-cmp'
	Plug 'hrsh7th/cmp-nvim-lsp'
	Plug 'hrsh7th/cmp-buffer'
	Plug 'hrsh7th/cmp-path'
	Plug 'L3MON4D3/LuaSnip'
	Plug 'saadparwaiz1/cmp_luasnip'

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

lua << EOF
require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
    "gopls",
    "pyright",
    "ts_ls",
    "clangd",
  },
})

local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),

    ["<CR>"] = cmp.mapping.confirm({
      select = true,
    }),

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),

  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  },
})

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

local function has_lsp_method(method)
  local clients = vim.lsp.get_clients({ bufnr = 0 })

  for _, client in ipairs(clients) do
    if client:supports_method(method) then
      return true
    end
  end

  return false
end

vim.keymap.set("n", "gd", function()
  if has_lsp_method("textDocument/definition") then
    vim.lsp.buf.definition()
  else
    vim.cmd("normal! gd")
  end
end, { desc = "Go to definition" })

vim.keymap.set("n", "gr", function()
  if has_lsp_method("textDocument/references") then
    vim.lsp.buf.references()
  else
    vim.cmd("normal! gr")
  end
end, { desc = "Go to references" })

vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>f", function()
  vim.lsp.buf.format({ async = true })
end)

vim.lsp.enable({
  "lua_ls",
  "gopls",
  "pyright",
  "ts_ls",
  "clangd",
})
EOF



colorscheme onenord

" NERDTree
let g:NERDTreeDirArrowExpandable="+"
nnoremap <leader>n :NERDTreeToggle<CR>

autocmd bufenter * if winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree() | q | endif

if has('nvim')
    let NERDTreeBookmarksFile = stdpath('data') . '/NERDTreeBookmarks'
endif

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
