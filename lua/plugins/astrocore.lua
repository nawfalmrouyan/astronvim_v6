---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Project root detection (`:AstroRootInfo` shows the current result)
    rooter = {
      detector = {
        "lsp", -- prefer the workspace reported by a running language server
        { ".git", "_darcs", ".hg", ".bzr", ".svn" }, -- then a version controlled parent
        { "lua", "Makefile", "package.json" }, -- finally common project markers
      },
      ignore = {
        servers = {}, -- language servers to ignore, e.g. { "efm" }
        dirs = {}, -- directory patterns to ignore
      },
      autochdir = true, -- follow the detected root automatically
      scope = "win", -- change the working directory per window
      notify = true, -- notify on every working directory change
    },

    treesitter = {
      ensure_installed = { "vim", "lua" },
      highlight = {
        enable = true,
        -- Vim regex highlighting on top of treesitter is expensive and rarely needed
        additional_vim_regex_highlighting = false,
      },
      textobjects = {
        select = {
          select_textobject = {
            ["ak"] = { query = "@block.outer", desc = "around block" },
          },
        },
      },
    },

    autocmds = {
      -- Absolute line numbers while inserting, relative numbers otherwise
      insert_absolute_numbers = {
        {
          event = "InsertEnter",
          desc = "Use absolute line numbers while inserting",
          callback = function()
            if vim.wo.relativenumber then
              vim.g.backtorelative = true
              vim.wo.relativenumber = false
              vim.wo.cursorline = false
            end
          end,
        },
        {
          event = "InsertLeave",
          desc = "Restore relative line numbers after inserting",
          callback = function()
            if vim.g.backtorelative then
              vim.wo.relativenumber = true
              vim.wo.cursorline = true
              vim.g.backtorelative = nil
            end
          end,
        },
      },
      cursor_diagnostics = {
        {
          event = "CursorHold",
          desc = "Show diagnostics under the cursor",
          callback = function() vim.diagnostic.open_float(nil, { focusable = false, source = "if_many" }) end,
        },
      },
    },

    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- limits for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics = { virtual_text = false, virtual_lines = false }, -- diagnostics on startup
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },

    -- Passed to `vim.diagnostic.config()`
    diagnostics = {
      virtual_text = false,
      underline = true,
    },

    options = {
      opt = {
        relativenumber = true,
        number = true,
        spell = false,
        signcolumn = "yes",
        ignorecase = false,
        smartcase = false,
        list = true,
        listchars = { eol = "¬", trail = "·", precedes = "…", extends = "…", tab = "→\\ " },
        showbreak = "﬌ ",
        wrap = true,
        inccommand = "split",
        colorcolumn = "100",
        cursorline = true,
        cursorlineopt = "both",
        autoread = true,
        -- Keep splits stable (used by windows.nvim for maximize/restore)
        winwidth = 20,
        winminwidth = 20,
        equalalways = false,
      },
      g = {
        -- `mapleader` and `maplocalleader` are set in `lua/lazy_setup.lua`
      },
      env = {
        SNACKS_KITTY = "1",
      },
    },

    mappings = {
      n = {
        -- Buffers
        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },
        ["<Leader>bo"] = {
          function() require("astrocore.buffer").close_all(true) end,
          desc = "Close all buffers but the current one",
        },
        ["<Leader>c"] = {
          function()
            local bufs = vim.fn.getbufinfo { buflisted = true }
            require("astrocore.buffer").close(0)
            if not bufs[2] then require("snacks").dashboard() end
          end,
          desc = "Close buffer",
        },

        -- which-key group names
        ["<Leader>D"] = { desc = "Diff" },
        ["<Leader>P"] = { desc = "Pull Requests" },
        ["<Leader>m"] = { desc = "Markdown" },
        ["<Leader>mh"] = { desc = "Headings" },
        ["<Leader>s"] = { desc = "SQL" },

        -- Quality of life
        ["<M-O>"] = { "O<esc>", desc = "Insert new line above" },
        ["<M-$>"] = { "g$", desc = "End of wrapped line" },
        ["/"] = { "ms/", desc = "Search and replace" },
        ["<Esc>"] = { "<Cmd>nohlsearch|diffupdate|normal!<C-l><CR>", desc = "Clear highlights" },
        ["<MiddleMouse>"] = { "i<MiddleMouse><ESC>", desc = "Paste mode" },
        ["<M-w>"] = { ":set wrap! wrap?<cr>", desc = "Toggle wrap" },
        ["<M-r>"] = { ":set relativenumber! relativenumber?<cr>", desc = "Toggle relative number" },
        ["<Leader>fs"] = { "<cmd>%s/\\s\\+$//e<cr>:noh<cr>", desc = "Delete trailing whitespace" },
      },
      i = {
        ["<M-o>"] = { "<C-o>o", desc = "Insert new line below" },
        ["<M-O>"] = { "<C-o>O", desc = "Insert new line above" },
      },
      t = {
        ["<Esc>"] = { "<C-\\><C-N>", desc = "Escape terminal mode" },
        ["<C-Up>"] = { "<C-\\><C-N>resize -2<cr>", desc = "Resize up" },
        ["<C-Down>"] = { "<C-\\><C-N>resize +2<cr>", desc = "Resize down" },
        ["<C-Left>"] = { "<C-\\><C-N>vertical resize -2<cr>", desc = "Resize left" },
        ["<C-Right>"] = { "<C-\\><C-N>vertical resize +2<cr>", desc = "Resize right" },
      },
      x = {
        ["P"] = { '"_c<c-r>0<esc>', desc = "Better paste" },
      },
    },
  },
}
