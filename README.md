# AstroNvim v6 configuration

Personal [AstroNvim](https://github.com/AstroNvim/AstroNvim) setup, launched with
`NVIM_APPNAME=astronvim_v6` (see `av` / `astro` in `~/.local/bin`).

## Layout

```text
init.lua                 bootstrap lazy.nvim, then load lazy_setup + polish
lua/
  lazy_setup.lua         AstroNvim import + lazy.nvim options
  community.lua          AstroCommunity packages
  keymaps.lua            global keymaps that are not AstroCore mappings
  polish.lua             post-startup tweaks (filetypes, leap, UI2, transparency)
  neovide.lua            Neovide-only GUI settings
  plugins/               one plugin (or one concern) per file
    astrocore.lua        core options, autocmds, rooter, mappings
    astrolsp.lua         LSP features, formatting, handlers, mappings
    astroui.lua          colorscheme and icons
    snacks.lua           dashboard, explorer, picker
    disabled.lua         every intentionally disabled plugin
    archive/             old `.bak` specs, kept for reference (not loaded)
ftplugin/
  markdown.lua           markdown-only keymaps (headings, navigation)
```

## Conventions

- Plugin overrides go in `lua/plugins/<plugin>.lua`; use `opts` instead of a
  custom `config` whenever the plugin provides `setup()`.
- Put lazy-loading triggers (`event`, `cmd`, `keys`, `ft`) on plugins that are
  not needed at startup.
- Disabled plugins belong in `lua/plugins/disabled.lua`. Use the full repository
  name (`nvimtools/none-ls.nvim`, not `none-ls`) or the disable is ignored.
- Filetype-specific mappings belong in `ftplugin/<filetype>.lua` with
  `buffer = 0`.
- `lua/plugins/archive/` is never imported by lazy.nvim; files there end in
  `.lua.bak` on purpose.

## Maintenance

```vim
:Lazy sync        " install/update/clean plugins
:Lazy profile     " find slow-loading plugins
:checkhealth      " verify LSP, treesitter, providers, etc.
```

The colorscheme is `kissaten-evening`; `<F2>` toggles background transparency.
