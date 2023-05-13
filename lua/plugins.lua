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
  
  use 'neovim/nvim-lspconfig'
  use 'folke/neodev.nvim'

  use({
    "hrsh7th/nvim-cmp",
    requires = {
      { "hrsh7th/cmp-nvim-lsp" },
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'hrsh7th/cmp-cmdline'},
      {'hrsh7th/cmp-vsnip'},
      {'hrsh7th/vim-vsnip'}
    },
  })

  use({
    "scalameta/nvim-metals",
    requires = {
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
    },
  })
end)

