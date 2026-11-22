---@type LazySpec
return {
  "2giosangmitom/sqmeow.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },
  version = "*",
  build = function()
    -- Download the matching release binary; pass 'curl', 'wget', 'powershell' or 'cargo' to choose.
    require("sqmeow").install()
  end,
  opts = {},
  cmd = "Sqmeow",
  keys = {
    { "<leader>sd", "<cmd>Sqmeow toggle<cr>", desc = "SQL: toggle" },
    { "<leader>sc", "<cmd>Sqmeow cancel<cr>", desc = "SQL: cancel" },
    { "<leader>sa", "<cmd>Sqmeow add<cr>", desc = "SQL: add connection" },
    { "<leader>ss", "<cmd>Sqmeow scratch<cr>", desc = "SQL: new scratchpad" },
  },
}
