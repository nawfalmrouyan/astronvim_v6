-- AstroLSP configuration (`:h astrolsp`)
---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    features = {
      codelens = true,
      inlay_hints = true,
      semantic_tokens = true,
      signature_help = true,
    },

    formatting = {
      format_on_save = {
        enabled = false,
        allow_filetypes = {},
        ignore_filetypes = {},
      },
      disabled = {},
      timeout_ms = 1000,
    },

    -- Language servers to enable without Mason
    servers = {},

    ---@diagnostic disable: missing-fields
    config = {
      ["*"] = {
        capabilities = {
          textDocument = {
            foldingRange = { dynamicRegistration = false },
          },
        },
        flags = { exit_timeout = 5000 },
      },
    },

    -- Attach every server through `vim.lsp.enable` (Neovim's native LSP API)
    handlers = {
      ["*"] = function(server) vim.lsp.enable(server) end,
    },

    autocmds = {
      lsp_codelens_refresh = {
        cond = "textDocument/codeLens",
        {
          event = { "InsertLeave", "BufEnter" },
          desc = "Refresh codelens (buffer)",
          callback = function(args)
            if require("astrolsp").config.features.codelens then vim.lsp.codelens.refresh { bufnr = args.buf } end
          end,
        },
      },
    },

    mappings = {
      n = {
        gD = {
          function() vim.lsp.buf.declaration() end,
          desc = "Declaration of current symbol",
          cond = "textDocument/declaration",
        },
        ["<Leader>UY"] = {
          function() require("astrolsp.toggles").buffer_semantic_tokens() end,
          desc = "Toggle LSP semantic highlight (buffer)",
          cond = function(client)
            return client:supports_method "textDocument/semanticTokens/full" and vim.lsp.semantic_tokens ~= nil
          end,
        },
      },
    },

    on_attach = function() end,
  },
}
