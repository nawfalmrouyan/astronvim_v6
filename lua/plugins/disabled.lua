-- Every plugin that is intentionally turned off lives here, so it is easy to
-- see what is disabled and to flip it back on.
---@type LazySpec
return {
  -- Plugins that ship with AstroNvim but are not used in this setup.
  -- The repository names matter: a short name such as "aerial" does not match
  -- "aerial.nvim" and the disable would silently do nothing.
  { "nvimtools/none-ls.nvim", enabled = false },
  { "stevearc/aerial.nvim", enabled = false },
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  { "mrjones2014/smart-splits.nvim", enabled = false },

  -- Optional plugins kept around for later.
  {
    "monkoose/neocodeium",
    enabled = false,
    event = "VeryLazy",
    keys = {
      { "<A-g>", function() require("neocodeium").accept() end, mode = "i" },
      { "<A-f>", function() require("neocodeium").accept() end, mode = "i" },
      { "<C-l>", function() require("neocodeium").accept_word() end, mode = "i" },
      { "<C-j>", function() require("neocodeium").accept_line() end, mode = "i" },
      { "<A-e>", function() require("neocodeium").cycle_or_complete() end, mode = "i" },
      { "<A-r>", function() require("neocodeium").cycle_or_complete(-1) end, mode = "i" },
      { "<A-c>", function() require("neocodeium").clear() end, mode = "i" },
    },
  },
  {
    "nacro90/numb.nvim",
    enabled = false,
    event = "User AstroFile",
    opts = {
      show_numbers = true,
      show_cursorline = true,
    },
  },
}
