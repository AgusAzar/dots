call plug#begin('~/.config/nvim/plugged')
"themes"
Plug 'morhetz/gruvbox'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

"treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

"Telescope dependences
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

"lsp
Plug 'neovim/nvim-lspconfig'
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
Plug 'jose-elias-alvarez/null-ls.nvim'


"OmniSharp
Plug 'OmniSharp/omnisharp-vim'
let g:OmniSharp_server_stdio = 1

"Completion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'williamboman/nvim-lsp-installer'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'L3MON4D3/LuaSnip'

"auto pairs
Plug 'windwp/nvim-autopairs'

"Web snipets
Plug 'mattn/emmet-vim'

"Icons
Plug 'kyazdani42/nvim-web-devicons'

"Status line
Plug 'nvim-lualine/lualine.nvim'


call plug#end()
