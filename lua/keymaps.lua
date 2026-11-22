-- Global keymaps that are not part of AstroCore's mapping tables.
-- Buffer/filetype specific maps live in `ftplugin/` instead.

-- Explorer and file utilities
vim.keymap.set("n", "<leader>e", function() Snacks.explorer() end, { desc = "Snacks Explorer" })
vim.keymap.set("n", "<leader>fn", function() vim.cmd ":%s/\\r//g" end, { desc = "Clear Windows newlines" })

-- Keep indentation in visual mode
vim.keymap.set("n", "<", "<<")
vim.keymap.set("n", ">", ">>")
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Move through wrapped lines when there is no count
for _, key in ipairs { "j", "<Down>" } do
  vim.keymap.set({ "n", "x" }, key, "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
end
for _, key in ipairs { "k", "<Up>" } do
  vim.keymap.set({ "n", "x" }, key, "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
end

-- Start/end of line
vim.keymap.set({ "n", "v" }, "gh", "^", { desc = "Go to the beginning of the line" })
vim.keymap.set({ "n", "v" }, "gl", "$", { desc = "Go to the end of the line" })

-- chmod the current file without leaving Neovim
vim.keymap.set("n", "<leader>fx", '<cmd>!chmod +x "%"<CR>', { silent = true, desc = "Make file executable" })
vim.keymap.set("n", "<leader>fX", '<cmd>!chmod -x "%"<CR>', { silent = true, desc = "Remove executable flag" })

-- Search within a visual selection
vim.keymap.set("x", "/", "<Esc>/\\%V", { desc = "Search within selection" })

-- Duplicate the current line and comment out the copy
vim.keymap.set("n", "ycc", '"yy" . v:count1 . "gcc\']p"', { remap = true, expr = true, desc = "Duplicate and comment" })

-- Wrap the current paragraph at 70 words
vim.keymap.set("n", "<leader>yp", [[:%s/\(\(\S\+\s\+\)\{70}\)/\1\r\r/g<CR>]], { desc = "Wrap paragraph at 70 words" })

-- Incremental selection using treesitter, falling back to LSP ranges
local function select_incremental(direction)
  return function()
    if vim.treesitter.get_parser(nil, nil, { error = false }) then
      require("vim.treesitter._select")[direction == "parent" and "select_parent" or "select_child"](vim.v.count1)
    else
      vim.lsp.buf.selection_range(direction == "parent" and vim.v.count1 or -vim.v.count1)
    end
  end
end
vim.keymap.set(
  { "n", "x", "o" },
  "<M-o>",
  select_incremental "parent",
  { desc = "Select parent treesitter node or outer LSP range" }
)
vim.keymap.set(
  { "n", "x", "o" },
  "<M-i>",
  select_incremental "child",
  { desc = "Select child treesitter node or inner LSP range" }
)

-- Native multicursor support (Neovim 0.13+)
if vim.fn.has "nvim-0.13" == 1 then
  local mcursor_ns = vim.api.nvim_create_namespace "nvim.multicursor"

  local function has_cursor(start, stop)
    return #vim.api.nvim_buf_get_extmarks(0, mcursor_ns, start, stop, { limit = 1 }) > 0
  end

  -- Add a cursor at the next occurrence of the word under the cursor
  vim.keymap.set("n", "<C-n>", function()
    if has_cursor(0, -1) then
      local row, col = unpack(vim.api.nvim_win_get_cursor(0))
      -- Wrapped onto an occurrence that already has a cursor: all are selected.
      if has_cursor({ row - 1, col }, { row - 1, col }) then return end
    else
      local word = vim.fn.expand "<cword>"
      if word == "" then return end
      local pattern = [[\<]] .. vim.fn.escape(word, [[\/]]) .. [[\>]]
      vim.fn.setreg("/", pattern)
      vim.o.hlsearch = true
      vim.fn.search(pattern, "bcW")
    end

    vim.cmd "normal! Qn1q="
  end, { desc = "Add multicursor at next occurrence of word under cursor" })

  vim.keymap.set({ "n", "x" }, "<C-q>", function()
    vim.api.nvim_buf_clear_namespace(0, mcursor_ns, 0, -1)
  end, { desc = "Clear multicursors" })
end
