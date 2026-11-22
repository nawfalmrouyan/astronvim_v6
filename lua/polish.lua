-- Runtime tweaks that run after Lazy has loaded the plugin set.

-- Custom filetypes
vim.filetype.add {
  extension = {
    todo = "txt",
    eml = "txt",
    list = "txt",
  },
  filename = {
    [".env"] = "config",
  },
  pattern = {
    ["req.*%.txt"] = "config", -- requirements.txt
    ["gitconf.*"] = "gitconfig",
  },
}

require "neovide"
require "keymaps"

---------------------------------------------------------------------------
-- Leap extras: labels on search, clever-f/t and line-scoped jumping
---------------------------------------------------------------------------
vim.api.nvim_create_autocmd("CmdlineLeave", {
  group = vim.api.nvim_create_augroup("LeapOnSearch", {}),
  callback = function()
    local ev = vim.v.event
    local is_search_cmd = (ev.cmdtype == "/") or (ev.cmdtype == "?")
    -- Let the command line finish before invoking Leap.
    vim.schedule(function()
      local cnt = vim.fn.searchcount().total
      if is_search_cmd and (not ev.abort) and (cnt > 1) then
        -- Use "safe" labels, but no autojump: the search already jumped.
        local labels = require("leap").opts.safe_labels:gsub("[nN]", "")
        -- Pattern search needs no conceallevel adjustment; keep the current value.
        local vim_opts = { ["wo.conceallevel"] = vim.wo.conceallevel }
        require("leap").leap {
          pattern = vim.fn.getreg "/",
          windows = { vim.fn.win_getid() },
          opts = { safe_labels = "", labels = labels, vim_opts = vim_opts },
        }
      end
    end)
  end,
})

do
  local function ft(key_specific_args)
    require("leap").leap(vim.tbl_deep_extend("keep", key_specific_args, {
      inputlen = 1,
      inclusive = true,
      opts = {
        labels = "", -- force autojump
        safe_labels = vim.fn.mode(1):match "o" and "" or nil,
      },
    }))
  end

  -- clever-f/t behavior: reuse the motion keys instead of ; and ,
  local clever = require("leap.user").with_traversal_keys
  local clever_f, clever_t = clever("f", "F"), clever("t", "T")

  vim.keymap.set({ "n", "x", "o" }, "f", function() ft { opts = clever_f } end)
  vim.keymap.set({ "n", "x", "o" }, "F", function() ft { backward = true, opts = clever_f } end)
  vim.keymap.set({ "n", "x", "o" }, "t", function() ft { offset = -1, opts = clever_t } end)
  vim.keymap.set({ "n", "x", "o" }, "T", function() ft { backward = true, offset = 1, opts = clever_t } end)
end

-- Jump without searching the lines around the cursor
vim.keymap.set({ "n", "x", "o" }, "|", function()
  local line = vim.fn.line "."
  local top, bot = unpack { math.max(1, line - 3), line + 3 }
  require("leap").leap {
    pattern = "\\v(%<" .. top .. "l|%>" .. bot .. "l)$",
    windows = { vim.fn.win_getid() },
    opts = { safe_labels = "" },
  }
end, { desc = "Leap outside the current lines" })

---------------------------------------------------------------------------
-- Neovim 0.13 built-ins
---------------------------------------------------------------------------
if vim.fn.has "nvim-0.13" == 1 then
  require("vim._core.ui2").enable { enable = true }

  vim.cmd "packadd nvim.undotree"
  vim.keymap.set("n", "<leader>u", require("undotree").open, { desc = "Undo tree" })
end

---------------------------------------------------------------------------
-- Transparency toggle
---------------------------------------------------------------------------
local function toggle_transparency()
  if vim.g.transparent then
    vim.g.transparent = false
    -- Re-applying the colorscheme restores every highlight, not just Normal
    vim.cmd.colorscheme(vim.g.colors_name or "kissaten-evening")
  else
    vim.g.transparent = true
    vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" })
  end
end
vim.keymap.set("n", "<F2>", toggle_transparency, { desc = "Toggle background transparency" })
