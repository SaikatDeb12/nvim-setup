-- Standalone plugins with less than 10 lines of config go here
return {
	{
		-- Hints keybinds
		"folke/which-key.nvim",
	},
	{
		-- Highlight todo, notes, etc in comments
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
	{
		-- High-performance color highlighter
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
}
