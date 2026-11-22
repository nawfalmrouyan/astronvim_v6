-- Markdown-only keymaps. Buffer-local, so they never shadow normal editing
-- keys in other filetypes.

-- Jump between headings
vim.keymap.set("n", "gj", function()
  vim.cmd "silent! /^##\\+\\s.*$"
  vim.cmd "nohlsearch"
end, { buffer = 0, desc = "Next markdown heading" })

vim.keymap.set("n", "gk", function()
  vim.cmd "silent! ?^##\\+\\s.*$"
  vim.cmd "nohlsearch"
end, { buffer = 0, desc = "Previous markdown heading" })

-- Increase heading level
vim.keymap.set("n", "<leader>mhi", function()
  -- `[[ ]]` escapes the special characters in the command
  vim.cmd [[:g/\(^$\n\s*#\+\s.*\n^$\)/ .+1 s/^#\+\s/#&/c]]
end, { buffer = 0, desc = "Increase heading level (confirm)" })

vim.keymap.set("n", "<leader>mhI", function()
  vim.cmd [[:g/\(^$\n\s*#\+\s.*\n^$\)/ .+1 s/^#\+\s/#&/]]
end, { buffer = 0, desc = "Increase heading level" })

-- Decrease heading level
vim.keymap.set("n", "<leader>mhd", function()
  vim.cmd [[:g/^\s*#\{2,}\s/ s/^#\(#\+\s.*\)/\1/c]]
end, { buffer = 0, desc = "Decrease heading level (confirm)" })

vim.keymap.set("n", "<leader>mhD", function()
  vim.cmd [[:g/^\s*#\{2,}\s/ s/^#\(#\+\s.*\)/\1/]]
end, { buffer = 0, desc = "Decrease heading level" })
