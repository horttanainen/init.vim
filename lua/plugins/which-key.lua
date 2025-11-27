return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      delay = 500,
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)

      -- Optional: Add descriptions for your leader key groups
      wk.add({
        { "<leader>c", group = "Code/LSP" },
        { "<leader>g", group = "Git" },
        { "<leader>t", group = "Tabs" },
        { "<leader>e", group = "Diagnostics" },
      })
    end,
  },
}
