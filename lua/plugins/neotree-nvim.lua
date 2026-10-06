return {
  "neo-tree.nvim",
  opts = function(plugin, opts)
    table.insert(opts.filesystem.follow_current_file, "enabled")
  end,
}
