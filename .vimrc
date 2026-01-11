let mapleader=" "

" UI
set number
set relativenumber
set showmode
set signcolumn=yes
set cursorline
set scrolloff=8
set splitright
set splitbelow
set nowrap
set mouse=a
set hlsearch
syntax on
filetype plugin indent on

" search
set ignorecase
set smartcase
set incsearch
set hlsearch

" Indent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set autoindent
set smartindent

" File
set noswapfile
set nobackup
" set undofile
" set undodir=~/.vim/undodir

" Perf
set updatetime=1000
set timeoutlen=300

" Maps
nnoremap <Space> <Nop>
vnoremap <Space> <Nop>
nnoremap <C-s> :w<CR>
command! W w
command! Q q
nnoremap df gg"_dG
nnoremap yf ggVGy<C-o>zz
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap <Esc> :nohlsearch<CR>
nnoremap <C-c> :nohlsearch<CR>
nnoremap <C-s> :w<CR>
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>p "+p
nnoremap <C-p> o<Esc>p
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l



" Fzf replacement.
set path+=**
set wildmenu
set wildignore+=*/.git/*,*/build/*,*/dist/*
set autochdir
cnoreabbrev ff find **/

" Colorscheme
colorscheme catppuccin_mocha_legacy

let g:netrw_banner = 0
let g:netrw_lifestyle = 3



