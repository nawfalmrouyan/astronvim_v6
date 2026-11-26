-- Every plugin that is intentionally turned off lives here, so it is easy to
-- see what is disabled and to flip it back on.
---@type LazySpec
return {
  -- Plugins that ship with AstroNvim but are not used in this setup.
  -- The repository names matter: a short name such as "aerial" does not match
  -- "aerial.nvim" and the disable would silently do nothing.
  { "nvimtools/none-ls.nvim", enabled = false },
  -- { "stevearc/aerial.nvim", enabled = false },
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  -- { "mrjones2014/smart-splits.nvim", enabled = false },
}
