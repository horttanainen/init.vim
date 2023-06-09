local api = vim.api
local opt = vim.opt

local function err_count(severity)
  local diags = vim.diagnostic.get(api.nvim_get_current_buf(), { severity = severity })
  if not next(diags) then
    return ""
  else
    return " " .. #diags .. " "
  end
end

local function get_branch()
  local name = api.nvim_call_function("FugitiveHead", {})
  if name and name ~= "" then
    return " " .. name .. " "
  else
    return ""
  end
end

local function scrollbar()
  local current_line = vim.fn.line(".")
  local total_lines = vim.fn.line("$")
  local default_chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
  local chars = default_chars
  local index = 1

  if current_line == 1 then
    index = 1
  elseif current_line == total_lines then
    index = #chars
  else
    local line_no_fraction = vim.fn.floor(current_line) / vim.fn.floor(total_lines)
    index = vim.fn.float2nr(line_no_fraction * #chars)
    if index == 0 then
      index = 1
    end
  end
  return chars[index]
end

local function metals_status()
  return vim.g["metals_status"] or ""
end

local function readonly()
  if opt.readonly:get() then
    return " readonly"
  else
    return ""
  end
end

local function statusline()
  return table.concat({
    " %t ", -- filename only
    readonly(),
    "%m ",
    get_branch(),
    "%#StatusError#",
    err_count("Error"),
    "%#StatusWarn#",
    err_count("Warn"),
    "%#StatusLine#",
    metals_status(),
    "%=", -- Left and Right divider
    "%l, ", -- line number
    "%c ", -- column number
    scrollbar(),
    "%",
  })
end

return {
  statusline = statusline,
}
