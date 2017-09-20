execute pathogen#infect()

" Line related stuff =========================================================== 

" Highlight column
set colorcolumn=81

" How many lines vim remembers
set history=500

" Keep cursor line in the middle of the screen when scrolling
set so=999

" Automatic stuff ==============================================================

" Show absolute line numbers when vim is not focused
au FocusLost * :set number
au FocusGained * :set relativenumber

" Show absolute line numbers when in insert mode
au InsertEnter * :set number
au InsertLeave * :set relativenumber

" Jump to the last position when reopening a file
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
      \| exe "normal! g'\"" | endif

" Code style ===================================================================
set autoindent
set smartindent
set expandtab
set shiftwidth=2
set tabstop=2
set shiftround

" Syntax and color =============================================================

" Turn on color syntax highlighting
syntax on 

filetype plugin indent on

set encoding=utf8

" Backup and saving ============================================================

set nobackup
set nowb
set noswapfile

" Mappings =====================================================================

let mapleader = ","
let g:mapleader = ","

" Use jk as esc in insert mode
inoremap jk <esc>

" Open vimrc in a vertical split for quick edit
nnoremap <leader>ev :vsplit ~/.vim_runtime/vimrc<cr>

" Source vimrc file wihtout closing vim
nnoremap <leader>sv :source $MYVIMRC<cr>

" Fast saving
nnoremap <leader>w :w!<cr>

" Use hjkl to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Tabs
map <leader>tn :tabnew<cr>
map <leader>tc :tabclose<cr>

" Unlearning section ===========================================================

inoremap <esc> <nop>

inoremap <up> <nop> 
inoremap <down> <nop> 
inoremap <left> <nop> 
inoremap <right> <nop> 

" Nerd Tree =================================================================

let g:NERDTreeWinPos = "right"
let NERDTreeShowHidden=0
let g:NERDTreeWinSize=35
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark<Space>
map <leader>nf :NERDTreeFind<cr>

" Syntastic ====================================================================
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Hdevtools ====================================================================

au FileType haskell nnoremap <buffer> <leader>q :HdevtoolsType<CR>
au FileType haskell nnoremap <buffer> <leader>w :HdevtoolsInfo<CR>
au FileType haskell nnoremap <buffer> <silent> <leader>e :HdevtoolsClear<CR>
