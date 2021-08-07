filetype plugin indent on
syntax enable
set nocompatible

let mapleader=','

"encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

"backspace indent
set backspace=indent,eol,start

"tabs
set tabstop=4
set expandtab
set shiftwidth=4
set softtabstop=0
set autoindent

set cursorline
set ignorecase
set number
set relativenumber
set ruler
set smartcase
set textwidth=80
set nowrap
set wildmenu
set hidden
set noswapfile
set nobackup
set nowritebackup
set undodir=~/.nvim/undodir
set undofile

set bg=dark

"stauts line
set laststatus=2
set noshowmode
"Plugins
call plug#begin('~/.config/nvim/plugged')
"temas"
Plug 'morhetz/gruvbox'
Plug 'franbach/miramare'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'joshdick/onedark.vim'
"plugins"
Plug 'mattn/emmet-vim'
"Plug 'jelera/vim-javascript-syntax'
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'
call plug#end()
"airline
let g:airline_powerline_fonts = 1
let g:airline_theme='deus'
"colorscheme
colorscheme gruvbox
hi Normal guibg=NONE ctermbg=NONE
"emmet"
let g:user_emmet_leader_key=','
let g:user_emmet_mode='i'
"jsx-pretty
let g:vim_jsx_pretty_colorful_config = 0 " default 0
"Ale
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint','prettier'],
\   'typescript': ['eslint', 'prettier'],
\   'typescriptreact': ['eslint', 'prettier']
\}
let g:ale_javascript_prettier_options = '--single-quote --trailing-comma all --tab-width 4'
let g:ale_fix_on_save = 1
let g:ale_disable_lsp = 1
"CoC
let g:coc_global_extensions = [
  \ 'coc-tsserver'
  \ ]
"remaps
imap <C-c> <Esc>
nnoremap <C-L> :nohl<CR><C-L>

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

nnoremap <Leader>f :GFiles<Cr>

"undo break points
inoremap , ,<C-g>u
inoremap . .<C-g>u
inoremap < <<C-g>u
inoremap > ><C-g>u
