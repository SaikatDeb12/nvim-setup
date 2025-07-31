return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	lazy = false,
	opts = {
		close_if_last_window = true, -- Close Neo-tree if it's the last window left
		window = {
			position = "float",
			mappings = {
				["<esc>"] = "close_window",
			},
		},
		filesystem = {
			filtered_items = {
				visible = true, -- Show hidden files by default
			},
		},
	},
	config = function(_, opts)
		-- Custom float settings
		opts.window.float = {
			relative = "editor",
			width = math.floor(vim.o.columns * 0.8),
			height = math.floor(vim.o.lines * 0.8),
			top = math.floor((vim.o.lines - vim.o.lines * 0.8) / 2),
			left = math.floor((vim.o.columns - vim.o.columns * 0.8) / 2),
			border = "rounded",
		}
		require("neo-tree").setup(opts)
	end,
}
