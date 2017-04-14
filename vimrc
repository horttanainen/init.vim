execute pathogen#infect()

" Automatic stuff ==============================================================

" Show absolute line numbers when vim is not focused
autocmd FocusLost * :set number
autocmd FocusGained * :set relativenumber

" Show absolute line numbers when in insert mode
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber

" Line related stuff =========================================================== 
set relativenumber

" Highlight column
set colorcolumn=81

" How many lines vim remembers
set history=500

" Code style ===================================================================
set autoindent
set expandtab
set shiftwidth=2
set tabstop=2

" Syntax and color =============================================================

" Turn on color syntax highlighting
syntax on

" Backup and saving ============================================================

" Turn backup off
set nobackup
set nowb
set noswapfile

" Mappings =====================================================================

let mapleader = ","
let g:mapleader = ","

" Use jk as esc in insert mode
inoremap jk <esc>

" Open vimrc in a vertical split for quick edit
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" Source vimrc file wihtout closing vim
nnoremap <leader>sv :source $MYVIMRC<cr>

" Fast saving
nnoremap <leader>w :w!<cr>

" Unlearning section ===========================================================

inoremap <esc> <nop>

inoremap <up> <nop> 
inoremap <down> <nop> 
inoremap <left> <nop> 
inoremap <right> <nop> 
