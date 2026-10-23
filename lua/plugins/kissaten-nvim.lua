return {
  "bytebeast/kissaten.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("kissaten").setup({ style = "evening" })
    -- vim.cmd.colorscheme("kissaten")
  end,
}
