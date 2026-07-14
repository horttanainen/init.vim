return {
  {
    "neovim-treesitter/nvim-treesitter",
    branch = "main",
    dependencies = { "neovim-treesitter/treesitter-parser-registry" },
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local ts = require("nvim-treesitter")

      -- Install parsers for languages you use
      ts.install({
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
        "markdown_inline",
        "go",
        "python",
        "swift",
      })

      -- Enable treesitter highlighting and indentation for all filetypes
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter", { clear = true }),
        callback = function(ev)
          pcall(vim.treesitter.start, ev.buf)
          vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
}
