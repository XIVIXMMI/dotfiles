-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

-- Make nvm-managed node/npm visible to Mason and other tools
local nvm_default = vim.fn.expand("$HOME/.nvm/alias/default")
local ok, version_alias = pcall(function()
  return vim.fn.readfile(nvm_default)[1]
end)
if ok and version_alias then
  -- resolve "lts/*" or exact version to an actual version folder
  local resolved = vim.fn.glob(vim.fn.expand("$HOME/.nvm/versions/node/") .. "*/", false, true)
  if #resolved > 0 then
    -- pick the last (highest) version as fallback
    local bin = resolved[#resolved]:gsub("/$", "") .. "/bin"
    vim.env.PATH = bin .. ":" .. vim.env.PATH
  end
end
