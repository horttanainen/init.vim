return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "c",
          "clojure",
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
        },
        auto_install = true,
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<CR>",
            node_incremental = "<CR>",
            node_decremental = "<BS>",
            scope_incremental = "<TAB>",
          },
        },
        textobjects = {
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["gj"] = "@function.outer",
              ["]b"] = "@block.outer",
              ["]a"] = "@parameter.inner",
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["gJ"] = "@function.outer",
              ["]B"] = "@block.outer",
              ["]A"] = "@parameter.inner",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["gk"] = "@function.outer",
              ["[b"] = "@block.outer",
              ["[a"] = "@parameter.inner",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["gK"] = "@function.outer",
              ["[B"] = "@block.outer",
              ["[A"] = "@parameter.inner",
            },
          },
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ab"] = "@block.outer",
              ["ib"] = "@block.inner",
              ["al"] = "@loop.outer",
              ["il"] = "@loop.inner",
              ["a/"] = "@comment.outer",
              ["i/"] = "@comment.inner",
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
            },
          },
        },
      })
    end,
  },
}
