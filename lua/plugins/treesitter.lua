 return {
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      event = { "BufReadPost", "BufNewFile" },
      config = function()
        require("nvim-treesitter").setup({
          ensure_installed = {
            "c",
            "clojure",
            "go",
            "kotlin",
            "java",
            "lua",
            "vimdoc",
            "typescript",
            "javascript",
            "zig",
            "bash",
            "html",
            "css",
            "json",
            "markdown",
            "python",
            "swift"
          },
          auto_install = true,
        })
      end,
    },
  }
