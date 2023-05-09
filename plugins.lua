return require('packer').startup(function(use)
  use 'tpope/vim-fugitive'
  use 'tpope/vim-commentary'
 
  use {
    'junegunn/fzf.vim',
    requires = { 'junegunn/fzf', run = ':call fzf#install()' }
  }

  use 'lifepillar/vim-solarized8'

  use 'jamessan/vim-gnupg'
  
  use 'wbthomason/packer.nvim'

  use 'preservim/nerdtree'
end)

