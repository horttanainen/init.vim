return {
  { 
    "preservim/nerdtree",
    keys = {
      { "<leader>nn", "<cmd>NERDTreeToggle<cr>", mode = {"n", "v", "o"}},
      { "<leader>nf", "<cmd>NERDTreeFind<cr>" , mode = {"n", "v", "o"}},
    },
    init = function()
      vim.g.NERDTreeWinPos = "right"
      vim.g.NERDTreeWinSize = 45
    end, 
  },
}
