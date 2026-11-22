---@type LazySpec
return {
  "JoseConseco/windows.nvim",
  dependencies = {
    "anuvyklack/middleclass", -- required
    "anuvyklack/animation.nvim", -- smooth maximize/restore animations
  },
  keys = {
    { "<A-=>", "<Cmd>WindowsMaximize<CR>", desc = "Maximize window" },
    { "<A-=>", "<C-\\><C-n><Cmd>WindowsMaximize<CR>i", mode = "t", desc = "Maximize window" },
    { "<A-/>", "<Cmd>WindowsMaximizeVertically<CR>", desc = "Maximize window vertically" },
    { "<A-->", "<Cmd>WindowsMaximizeHorizontally<CR>", desc = "Maximize window horizontally" },
    { "<A-0>", "<Cmd>WindowsEqualize<CR>", desc = "Equalize windows" },
  },
  -- `winwidth`, `winminwidth` and `equalalways` are set in astrocore.lua so they
  -- apply from startup rather than only after this plugin loads.
  opts = {},
}
