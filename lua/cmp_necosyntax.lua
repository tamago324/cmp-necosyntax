local cmp = require'cmp'

local M = {}

M.new = function()
  local self = setmetatable({}, { __index = M })
  vim.api.nvim_call_function('necosyntax#initialize', {})
  return self
end

M.get_keyword_pattern = function()
  return [[\S\+]]
end

M.complete = function(self, request, callback)
  local q = request.context.cursor_before_line
  local words = {}
  for _, val in ipairs(vim.api.nvim_eval('necosyntax#gather_candidates()')) do
    -- if vim.startswith(val, q) then
      table.insert(words, {
        label = val,
      })
    -- end
  end

  callback(words)
end

return M
