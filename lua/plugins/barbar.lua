return {
	"romgrk/barbar.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	version = "^1.0.0",

	init = function()
		vim.g.barbar_auto_setup = false
	end,

	opts = {
		animation = true,
		insert_at_start = true,
		clickable = true,
		icons = {
			buffer_index = true,
			buffer_number = false,
			button = "",
			diagnostics = {
				[vim.diagnostic.severity.ERROR] = { enabled = true, icon = " " },
				[vim.diagnostic.severity.WARN] = { enabled = true, icon = " " },
				[vim.diagnostic.severity.INFO] = { enabled = true, icon = " " },
				[vim.diagnostic.severity.HINT] = { enabled = true, icon = "󰌶 " },
			},
			filetype = {
				enabled = true,
			},
		},
	},

	config = function(_, opts)
		require("barbar").setup(opts)

		local map = vim.keymap.set

		-- Move between buffers
		map("n", "<A-,>", "<Cmd>BufferPrevious<CR>", { desc = "Previous buffer" })
		map("n", "<A-.>", "<Cmd>BufferNext<CR>", { desc = "Next buffer" })

		-- Reorder buffers
		map("n", "<A-S-Left>", "<Cmd>BufferMovePrevious<CR>", { desc = "Move buffer left" })
		map("n", "<A-S-Right>", "<Cmd>BufferMoveNext<CR>", { desc = "Move buffer right" })

		-- Go to buffer by position
		for i = 1, 9 do
			map("n", "<C-" .. i .. ">", "<Cmd>BufferGoto " .. i .. "<CR>", { desc = "Go to buffer " .. i })
		end

		map("n", "<A-0>", "<Cmd>BufferLast<CR>", { desc = "Last buffer" })
	end,
}
