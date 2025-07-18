return {
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
	-- { "ellisonleao/gruvbox.nvim", priority = 1000, config = true, opts = ... },
	{
		"Shatur/neovim-ayu",
	},
	{
		"xero/miasma.nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"morhetz/gruvbox",
	},
	{
		"folke/tokyonight.nvim",
	},
	{
		"arcticicestudio/nord-vim",
	},
}
