return {
  { 
    "junegunn/fzf.vim",
    keys = {
      { "<C-p>", "<cmd>FZF<cr>", mode = {"n", "v", "o"}},
      { "<Leader>gc", "<cmd>Commits<cr>" , mode = {"n", "v", "o"}},
      { "<Leader>gb", "<cmd>BCommits<cr>" , mode = {"n", "v", "o"}},
      { "<Leader>a", ":Rg " , mode = {"n", "v", "o"}},
    },
    init = function()
      vim.env.FZF_DEFAULT_COMMAND = 'rg --files --hidden'

      vim.cmd([[
      command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
        \   "rg --hidden --glob '!.git' --column --line-number --no-heading --color=always --smart-case -- ".shellescape(<q-args>), 1,
        \   fzf#vim#with_preview(), <bang>0)
        ]])
    end, 
    dependencies = {
      { 
        "junegunn/fzf",
        build = ':call fzf#install()'
      }
    },
  },
}
