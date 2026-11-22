---@type LazySpec
return {
  "saghen/blink.cmp",
  dependencies = {
    "daliusd/blink-cmp-fuzzy-path",
    "archie-judd/blink-cmp-words",
  },
  opts = function(_, opts)
    local sources = opts.sources
    local providers = sources.providers

    -- Path completion with fuzzy matching, only where it is useful
    sources.default = vim.list_extend(sources.default or {}, { "fuzzy-path" })
    providers["fuzzy-path"] = {
      name = "Fuzzy Path",
      module = "blink-cmp-fuzzy-path",
      score_offset = 0,
      opts = { filetypes = { "markdown", "json" } },
    }

    -- Word completion for prose
    providers.thesaurus = {
      name = "blink-cmp-words",
      module = "blink-cmp-words.thesaurus",
      opts = {
        score_offset = 0,
        definition_pointers = { "!", "&", "^" },
        similarity_pointers = { "&", "^" },
        similarity_depth = 2,
      },
    }
    providers.dictionary = {
      name = "blink-cmp-words",
      module = "blink-cmp-words.dictionary",
      opts = {
        dictionary_search_threshold = 3,
        score_offset = 0,
        definition_pointers = { "!", "&", "^" },
      },
    }
    sources.per_filetype = {
      text = { "dictionary" },
      markdown = { "thesaurus" },
    }

    opts.keymap = {
      preset = "default",
      ["<Tab>"] = { "select_next", "fallback" },
      ["<S-Tab>"] = { "select_prev", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
      ["<C-e>"] = { "cancel", "fallback" },
    }
  end,
}
