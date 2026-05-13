-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    -- defer past snacks' own ColorScheme re-apply autocmd
    vim.schedule(function()
      local overrides = {
        "Normal", "NormalNC", "NormalFloat", "FloatBorder", "FloatTitle",
        "SignColumn", "EndOfBuffer", "FoldColumn", "LineNr", "CursorLineNr",
        "SnacksDashboardNormal", "SnacksDashboardHeader", "SnacksDashboardFooter",
        "SnacksDashboardDesc", "SnacksDashboardIcon", "SnacksDashboardKey",
      }
      for _, name in ipairs(overrides) do
        vim.api.nvim_set_hl(0, name, { bg = "NONE" })
      end
    end)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "snacks_dashboard",
  callback = function()
    vim.wo.winhighlight = "Normal:Normal,NormalNC:Normal,NormalFloat:Normal"
  end,
})
