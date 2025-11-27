return {
  {
    "kylechui/nvim-surround",
    version = "^3.0.0",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },
}

-- Common operations:
--   - ys{motion}{char} - Add surroundings (e.g., ysiw" to surround word with quotes)
--   - cs{old}{new} - Change surroundings (e.g., cs"' to change "hello" to 'hello')
--   - ds{char} - Delete surroundings (e.g., ds" to remove quotes from "hello")
--   - yss{char} - Surround entire line

--   Examples:
--   - ysiw) - Surround word with parentheses
--   - cs]) - Change [text] to (text)
--   - dst - Delete surrounding HTML tag
--   - yss{ - Surround line with braces (with spaces)

--   In visual mode, just use S{char} to surround the selection.
