return {
	{
		"xiantang/darcula-dark.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},
	{
		"wtfox/jellybeans.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			transparent = true,
			italics = true,
			bold = true,
			flat_ui = true, -- toggles "flat UI" for pickers
			background = {
				dark = "jellybeans", -- default dark palette
				light = "jellybeans_muted", -- default light palette
			},
			plugins = {
				all = false,
				auto = true, -- will read lazy.nvim and apply the colors for plugins that are installed
			},
			on_highlights = function(highlights, colors) end,
			on_colors = function(colors) end,
		}, -- Optional
	},
	{
		"ribru17/bamboo.nvim",
		config = function()
			require("bamboo").setup({
				transparent = true, -- Built-in option
				colors = {
					-- bg = "#1e1e1e90", -- Background with 90% opacity
					bg = "#1e1e1e50",
				},
			})
		end,
	},
	{
		{
			"folke/tokyonight.nvim",
			opts = {
				style = "moon",
				transparent = true, -- Built-in option
				styles = {
					sidebars = "transparent",
					floats = "transparent",
				},
			},
		},
	},
	{
		"olimorris/onedarkpro.nvim",
		config = function()
			require("onedarkpro").setup({
				options = {
					transparency = true, -- Built-in transparency
				},
			})
		end,
	},
	{
		"craftzdog/solarized-osaka.nvim",
		lazy = true,
		priority = 1000,
		opts = function()
			return {
				transparent = true,
			}
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
	},
	{
		"vague2k/vague.nvim",
		config = function()
			require("vague").setup({
				-- optional configuration
			})
		end,
	},
	{
		"Shatur/neovim-ayu",
	},
	{
		"xero/miasma.nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"ellisonleao/gruvbox.nvim",
		-- "morhetz/gruvbox",
	},
	-- {
	-- 	"folke/tokyonight.nvim",
	-- },
	{
		"arcticicestudio/nord-vim",
	},
	-- {
	-- 	"joshdick/onedark.vim",
	-- },
	{
		"rebelot/kanagawa.nvim",
	},
	{
		"sainnhe/everforest",
	},
}
