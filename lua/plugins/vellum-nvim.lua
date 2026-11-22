---@type LazySpec
return {
  "blackhat-7/vellum.nvim",
  ft = "markdown",
  keys = {
    { "<leader>mp", "<cmd>Vellum<cr>", desc = "Markdown preview" },
    { "<leader>mz", function() require("vellum").zoom() end, desc = "Markdown zoom" },
  },
  opts = {},
}
