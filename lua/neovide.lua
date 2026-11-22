-- Neovide-only GUI settings. Loaded from `lua/polish.lua`.
if not vim.g.neovide then return end

-- Font (uncomment and adjust to taste)
-- vim.opt.guifont = "PragmataPro Nerd Font Mono:h16"
-- vim.opt.guifont = "Pragmasevka Nerd Font Propo Condensed:h15"
-- vim.opt.guifont = "OpalBSD:h16:style=Semi-Condensed\\ Semi-Bold"

vim.g.neovide_text_gamma = 0.9
vim.g.neovide_text_contrast = 0.1

-- Window transparency. Keep `neovide_opacity` in sync with `transparency` so the
-- title bar matches the content.
local alpha = function() return string.format("%x", math.floor(255 * (vim.g.transparency or 0.8))) end
vim.g.transparency = 0.9
vim.g.neovide_opacity = 0.9
vim.g.neovide_background_color = "#1E1E2F" .. alpha()

-- Floating window blur and shadow
vim.g.neovide_floating_blur_amount_x = 2.0
vim.g.neovide_floating_blur_amount_y = 2.0
vim.g.neovide_floating_shadow = true
vim.g.neovide_floating_z_height = 10
vim.g.neovide_light_angle_degrees = 45
vim.g.neovide_light_radius = 5
