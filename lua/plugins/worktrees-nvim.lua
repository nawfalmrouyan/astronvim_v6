---@type LazySpec
return {
  "Juksuu/worktrees.nvim",
  opts = {},
  keys = {
    { "<leader>gws", function() Snacks.picker.worktrees() end, desc = "Worktrees: Switch" },
    { "<leader>gwn", function() Snacks.picker.worktrees_new() end, desc = "Worktrees: New" },
    { "<leader>gwr", function() Snacks.picker.worktrees_remove() end, desc = "Worktrees: Remove" },
  },
}
