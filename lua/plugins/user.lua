-- Small, self-contained plugins that do not need their own file.
---@type LazySpec
return {
  { "andweeb/presence.nvim", event = "VeryLazy" },

  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- only start session saving when a file was actually opened
    opts = { need = 0 },
  },
}
