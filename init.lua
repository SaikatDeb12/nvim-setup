require("core.options")
require("core.keymaps")

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

require("lazy").setup({
	require("plugins.neotree"),
	require("plugins.colortheme"),
	require("plugins.bufferline"),
	require("plugins.lualine"),
	require("plugins.treesitter"),
	require("plugins.telescope"),
	require("plugins.lsp"),
	require("plugins.autocompletion"),
	require("plugins.autoformatting"),
	require("plugins.gitsigns"),
	require("plugins.alpha"),
	require("plugins.indent-blankline"),
	require("plugins.misc"),
	require("plugins.ts-autotag"),
	require("plugins.wakatime"),
	require("plugins.cursorline"),
	-- require("plugins.noice"),
	require("plugins.neoscroll"),
	-- require("plugins.smear-cursor"),
	require("plugins.tailwindcss-colors"),
	require("plugins.competitive"),
})

vim.g.catppuccin_flavor = "dark"
-- vim.cmd.colorscheme("catppuccin")
-- vim.cmd.colorscheme("ayu-mirage")
-- vim.cmd.colorscheme("tokyonight")
-- vim.cmd.colorscheme("bamboo")
vim.cmd.colorscheme("darcula-dark")
--
-- vim.cmd.colorscheme("kanagawa-dragon")
-- vim.cmd.colorscheme("onedark")
-- Jellybean colorschemes:
-- Default (vibrant dark)
-- vim.cmd([[colorscheme jellybeans]])

-- Vibrant light
-- vim.cmd[[colorscheme jellybeans-light]]

-- Muted dark
-- vim.cmd([[colorscheme jellybeans-muted]])

-- Muted light
-- vim.cmd([[colorscheme jellybeans-muted-light]])

-- Mono dark
-- vim.cmd([[colorscheme jellybeans]])

-- vim.cmd.colorscheme("vague")
-- vim.cmd.colorscheme("solarized-osaka")
-- vim.cmd.colorscheme("gruvbox")
--
-- vim.o.background = "dark" -- or "light" for light mode
-- vim.cmd([[colorscheme gruvbox]])
--
-- vim.cmd.colorscheme("miasma")
-- vim.cmd.colorscheme("nord")
--
-- vim.o.background = "dark"
-- vim.cmd([[colorscheme tokyonight]])
--
-- vim.o.background = "dark"
-- vim.g.everforest_background = "hard"
-- vim.cmd([[colorscheme everforest]])
