call plug#begin('~/.vim/plugs')

Plug 'dense-analysis/ale'
Plug 'sjl/gundo.vim'
Plug 'tpope/vim-fugitive'
Plug 'ervandew/supertab'
Plug 'leafgarland/typescript-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'benmills/vimux'
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'lifepillar/vim-solarized8'

" Initialize plugin system
call plug#end()

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
set ruler

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
set smarttab

set expandtab
set shiftwidth=2
set tabstop=2

set shiftround

" Syntax, color and highligthing ===============================================

syntax on 

filetype plugin indent on

set encoding=utf8

" set Vim-specific sequences for RGB colors
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

set background=dark
colorscheme solarized8_low

set incsearch
set ignorecase
set smartcase

autocmd BufNewFile,BufRead *.fs setfiletype gforth
autocmd BufNewFile,BufRead *.red setfiletype red

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

" Splits

" Generate new vertical split
nnoremap <silent> vv <C-w>v

" Real delete
nnoremap <leader>d "_d
xnoremap <leader>d "_d
xnoremap <leader>p "_dP

" Unlearning section ===========================================================

" Gundo ========================================================================

" toggle gundo
nnoremap <leader>u :GundoToggle<CR>

" Nerd Tree ====================================================================

let g:NERDTreeWinPos = "right"
let NERDTreeShowHidden=0
let g:NERDTreeWinSize=35
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark<Space>
map <leader>nf :NERDTreeFind<cr>

" latex ========================================================================

let g:vimtex_view_general_viewer = 'SumatraPDF'
let g:vimtex_view_general_options
  \ = '-reuse-instance -forward-search @tex @line @pdf'
let g:vimtex_view_general_options_latexmk = '-reuse-instance'

" ale ==========================================================================
"
" Enable completion where available.
" This setting must be set before ALE is loaded.
"
" You should not turn this setting on if you wish to use ALE as a completion
" source for other completion plugins, like Deoplete.
let g:ale_completion_enabled = 1
" let g:ale_completion_delay = 500
set completeopt=menu,menuone,preview,noselect,noinsert

" let g:ale_linter_aliases = {'typescriptreact': 'typescript'}
let g:ale_linters = {'python': ['flake8', 'mypy', 'pylint', 'pyls']}

set omnifunc=ale#completion#OmniFunc

map <Leader>cc :ALEGoToDefinition<CR>
map <Leader>cv :ALEGoToDefinitionInVSplit<CR>
map <Leader>ch :ALEGoToDefinitionInSplit<CR>

" vimux ========================================================================

" Prompt for a command to run
map <Leader>vp :VimuxPromptCommand<CR>

" Run last command executed by VimuxRunCommand
map <Leader>vl :VimuxRunLastCommand<CR>

" Inspect runner pane
map <Leader>vi :VimuxInspectRunner<CR>

" Zoom the tmux runner pane
map <Leader>vz :VimuxZoomRunner<CR>

let g:VimuxResetSequence = ""

" FZF ==========================================================================

map <C-p> :FZF<CR>
map <Leader>a :Rg<CR>
