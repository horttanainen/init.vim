execute pathogen#infect()

" Tabs and stuff

:set hidden

" Line related stuff =========================================================== 

" Highlight column
set colorcolumn=81

" How many lines vim remembers
set history=1000

set number
set rnu

:set wrap
:set linebreak
:set nolist  " list disables linebreak
:set textwidth=0
:set wrapmargin=0

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

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

"set t_Co=256

set background=dark
colorscheme solarized
" colorscheme molokai

set incsearch

" Menus ========================================================================

set completeopt=menuone,menu,longest

set wildignore+=.git
set wildmode=longest,list,full
set wildmenu

set cmdheight=1

" Gui ==========================================================================

:set guioptions-=m  "remove menu bar
:set guioptions-=T  "remove toolbar
:set guioptions-=r  "remove right-hand scroll bar

if has('gui_running')
  set guifont=Source_Code_pro:h14
endif

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

" Real delete
nnoremap <leader>d "_d
xnoremap <leader>d "_d
xnoremap <leader>p "_dP

" Unlearning section ===========================================================

inoremap <esc> <nop>

inoremap <up> <nop> 
inoremap <down> <nop> 
inoremap <left> <nop> 
inoremap <right> <nop> 

" Gundo ========================================================================

" toggle gundo
nnoremap <leader>u :GundoToggle<CR>

" Ag ===========================================================================

" open ag.vim
nnoremap <leader>a :Ag

" Nerd Tree ====================================================================

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
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1

let g:syntastic_haskell_checkers = ['hdevtools', 'hlint']

let g:tex_flavor = 'latex'
let g:syntastic_tex_checkers = ['chktex']

let g:tsuquyomi_disable_quickfix = 1
let g:syntastic_typescript_checkers = ['tsuquyomi']

" Disable loading of javac when opening java files since syntasic won't work
" with java in any case. This is a hack that fools syntastic that javac is
" already loaded.
let g:loaded_syntastic_java_javac_checker = 1

" Supertab =====================================================================

let g:haskellmode_completion_ghc = 1
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

" ghcmod-vim ===================================================================

map <silent> tw :GhcModTypeInsert<CR>
map <silent> ts :GhcModSplitFunCase<CR>
map <silent> tq :GhcModType<CR>
map <silent> te :GhcModTypeClear<CR>

" latex ========================================================================

let g:vimtex_view_general_viewer = 'SumatraPDF'
let g:vimtex_view_general_options
  \ = '-reuse-instance -forward-search @tex @line @pdf'
let g:vimtex_view_general_options_latexmk = '-reuse-instance'

