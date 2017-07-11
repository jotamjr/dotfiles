"
" Vundle stuff
"
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'itchyny/lightline.vim'
Plugin 'edkolev/promptline.vim'
Plugin 'altercation/vim-colors-solarized'

call vundle#end()
if has("autocmd")
  filetype plugin indent on
endif

" follow last position in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" indent tabs
set smartindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set nojoinspaces
set shiftround

" text stuff
set encoding=utf-8
scriptencoding utf-8
set nowrap
set list
set listchars=tab:>.,trail:.,nbsp:¬

" interface
syntax enable
set background=dark
colorscheme solarized
set number
set cursorline
set laststatus=2
set ttimeoutlen=50
set noshowmode
set ruler
"set termguicolors
set showcmd
set ignorecase
set smartcase
set incsearch
set hlsearch

" lightline theme config
let g:lightline = {
  \ 'colorscheme': 'solarized',
  \ 'component' : {
  \   'readonly' : '%{&readonly?"":""}',
  \   'branch' : '%{&branch?"":""}',
  \   'linecolumn' : '%{&linecolumn?"":""}',
  \ },
  \ 'separator': { 'left': '', 'right': '' },
  \ 'subseparator': { 'left': '', 'right': '' }
  \}

" use lightline theme for promptline
let g:promptline_theme = 'lightline'
let g:promptline_preset = {
  \'a' : [ promptline#slices#host() ],
  \'b' : [ promptline#slices#cwd() ],
  \'c' : [ promptline#slices#vcs_branch(), promptline#slices#git_status() ],
  \'warn' : [ promptline#slices#last_exit_code () ]}
