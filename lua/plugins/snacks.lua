-- Snacks configuration. AstroNvim enables most Snacks modules; this file only
-- overrides the pieces we care about.
---@type LazySpec
return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      preset = {
        header = table.concat({
          "                                                                       ",
          "                                                                     ",
          "       ████ ██████           █████      ██                     ",
          "      ███████████             █████                             ",
          "      █████████ ███████████████████ ███   ███████████   ",
          "     █████████  ███    █████████████ █████ ██████████████   ",
          "    █████████ ██████████ █████████ █████ █████ ████ █████   ",
          "  ███████████ ███    ███ █████████ █████ █████ ████ █████  ",
          " ██████  █████████████████████ ████ █████ █████ ████ ██████ ",
          "                                                                       ",
        }, "\n"),
      },
    },
    styles = {
      notification = { wo = { wrap = true } },
    },
    bigfile = {},
    explorer = {},
    quickfile = {},
    statuscolumn = {},
    words = {},
    scroll = {},
    picker = {
      sources = {
        grep = {
          need_search = false,
          live = false,
        },
      },
    },
  },
}
