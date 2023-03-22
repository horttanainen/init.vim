call plug#begin('~/.vim/plugs')

Plug 'tpope/vim-fugitive'
Plug 'ervandew/supertab'
Plug 'leafgarland/typescript-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'benmills/vimux'
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'lifepillar/vim-solarized8'
Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-commentary'
Plug 'AndrewRadev/linediff.vim'
Plug 'tpope/vim-unimpaired'
Plug 'OmniSharp/omnisharp-vim'
Plug 'dense-analysis/ale'
Plug 'jamessan/vim-gnupg'
Plug 'rhysd/vim-clang-format'
Plug 'easymotion/vim-easymotion'
Plug 'preservim/nerdtree'
Plug 'lervag/vimtex'
" " Initialize plugin system
call plug#end()

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

" custom commands =======================

function TmpFunc(filename)
  execute ':e ' . system('mktemp /tmp/' . a:filename . '.XXXX')
endfunction

command! -nargs=1 Tmp call TmpFunc(<f-args>)

" Syntax, color and highligthing ===============================================

syntax on 

filetype plugin indent on

set encoding=utf8

set background=light

let g:solarized_use16=1

colorscheme solarized8

set incsearch
set ignorecase
set smartcase

autocmd BufNewFile,BufRead *.fs setfiletype gforth
autocmd BufNewFile,BufRead *.red setfiletype red

" Menus ========================================================================

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

nnoremap <leader>es :vsplit ~/.zprofile<cr>

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

" For local replace
nnoremap gr gd[{V%::s///gc<left><left><left>

" For global replace
nnoremap gR gD:%s///gc<left><left><left>

" Unlearning section ===========================================================

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

" OmniSharp ==============================================
let g:OmniSharp_server_use_mono = 1
" let g:OmniSharp_server_stdio = 1

let g:OmniSharp_selector_ui = 'fzf'
let g:OmniSharp_selector_findusages = 'fzf'

augroup omnisharp_commands
  autocmd!

   " Show type information automatically when the cursor stops moving.
  " Note that the type is echoed to the Vim command line, and will overwrite
  " any other messages in this space including e.g. ALE linting messages.
  autocmd CursorHold *.cs OmniSharpTypeLookup

  autocmd FileType cs nmap <silent> <buffer> <Leader>cd <Plug>(omnisharp_documentation)
  autocmd FileType cs nmap <silent> <buffer> <Leader>cc <Plug>(omnisharp_go_to_definition)
augroup END

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
let g:ale_linters = { 'cs': ['OmniSharp'], 'python': ['flake8', 'mypy', 'pylint', 'pyls'] }

let g:ale_fixers = { 
      \  'javascript': ['prettier', 'eslint'],
      \  'typescript': ['prettier', 'eslint'],
      \  'typescriptreact': ['prettier', 'eslint']
      \}

" set omnifunc=ale#completion#OmniFunc

map <Leader>cc :ALEGoToDefinition<CR>
map <Leader>cv :ALEGoToDefinition -vsplit<CR>
map <Leader>ch :ALEGoToDefinition -split<CR>
map <Leader>cr :ALEFindReferences<CR>
nmap <silent> <leader>j :ALENext<cr>
nmap <silent> <leader>k :ALEPrevious<cr>



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

let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'

function! RipgrepWithHiddenFilesFunc(search, bang)
  call fzf#vim#grep("rg --column --line-number --hidden --no-heading --color=always --smart-case -- ".shellescape(a:search), 1, fzf#vim#with_preview(), a:bang)
endfunction

" Zg is like Rg but searches hidden files
command!      -bang -nargs=* Zg                       call RipgrepWithHiddenFilesFunc(<q-args>, <bang>0)

map <C-p> :FZF<CR>
map <Leader>a :Zg 
map <Leader>gc :Commits<CR>
map <Leader>gb :BCommits<CR>

" supertab =====================================================================

let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-p>"
"let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
"let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']
"let g:SuperTabContextDiscoverDiscovery =
"        \ ["&omnifunc:<c-x><c-o>", "&completefunc:<c-x><c-u>" ]
"autocmd FileType *
"  \ if &omnifunc != '' |
"  \   call SuperTabChain(&omnifunc, "<c-p>") |
"  \   call SuperTabSetDefaultCompletionType("<c-x><c-u>") |
"  \ endif
