"disable autocmd
autocmd!

let mapleader=','

"encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

"backspace indent
set backspace=indent,eol,start

"tabs
filetype plugin indent on
syntax enable
set tabstop=2
set expandtab
set shiftwidth=2
set softtabstop=0
set ai "Auto indent
set si "Smart indent
set nowrap "No Wrap lines

set nocompatible
set cursorline
set ignorecase
set number
set relativenumber
set ruler
set smartcase
set textwidth=80
set wildmenu
set hidden
set noswapfile
set nobackup
set nowritebackup
set undodir=~/.nvim/undodir
set undofile

" Suppress appending <PasteStart> and <PasteEnd> when pasting
set t_BE=

" Don't redraw while executing macros (good performance config)
set lazyredraw

" Finding files - Search down into subfolders
set path+=**
set wildignore+=*/node_modules/*

"stauts line
set laststatus=2
set noshowmode

"clipboard
set clipboard+=unnamedplus

"Imports
runtime ./plug.vim
"colorscheme
colorscheme gruvbox
"remaps
imap <C-c> <Esc>
nnoremap <C-L> :nohl<CR><C-L>


inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

"undo break points
inoremap , ,<C-g>u
inoremap . .<C-g>u
inoremap < <<C-g>u
inoremap > ><C-g>u

lua <<EOF
require('plugins')
EOF
