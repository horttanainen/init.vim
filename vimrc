execute pathogen#infect()

" Line related stuff =========================================================== 

" Highlight column
set colorcolumn=81

" How many lines vim remembers
set history=1000

" Keep cursor line in the middle of the screen when scrolling
set so=999

set number
set rnu

" Automatic stuff ==============================================================

" Show absolute line numbers when vim is not focused
" au FocusLost * :set nornu
" au FocusGained * :set rnu

" Show absolute line numbers when in insert mode
autocmd InsertEnter * :set nornu
autocmd InsertLeave * :set rnu

" Jump to the last position when reopening a file
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
      \| exe "normal! g'\"" | endif

" Code style ===================================================================
set autoindent
set smartindent
set smartcase
set smarttab

set expandtab
set shiftwidth=2
set tabstop=2

set shiftround

" Syntax, color and highligthing ===============================================

syntax on 

filetype plugin indent on

set encoding=utf8

set t_Co=256

set incsearch

" Menus =======================================================

set completeopt=menuone,menu,longest

set wildignore+=.git
set wildmode=longest,list,full
set wildmenu

set cmdheight=1

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
if has("win32")
  nnoremap <leader>ev :vsplit ~/vimfiles/vimrc<cr>
else
	if has("unix")
    nnoremap <leader>ev :vsplit ~/.vim/vimrc<cr>
  endif
endif


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

let g:syntastic_haskell_checkers = ['hdevtools', 'hlint']

" Supertab =====================================================================

let g:haskellmode_completion_ghc = 1
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

" ghcmod-vim =====================================================

map <silent> tw :GhcModTypeInsert<CR>
map <silent> ts :GhcModSplitFunCase<CR>
map <silent> tq :GhcModType<CR>
map <silent> te :GhcModTypeClear<CR>
