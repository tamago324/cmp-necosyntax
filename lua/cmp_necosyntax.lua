local cmp = require'cmp'

local M = {
  config = {
    filetypes = {"*"},
  },
}

M.setup = function(opts)
  opts = vim.tbl_deep_extend('keep', opts, M.config)
  M.config = opts
end

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

M.is_available = function(self)
  return vim.deep_equal(self.config.filetypes, {"*"}) or vim.tbl_contains(self.config.filetypes, vim.bo.filetype)
end

return M
