return {
	{
		"yamatsum/nvim-cursorline",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			vim.opt.cursorline = true

			local function set_cursorline()
				vim.api.nvim_set_hl(0, "CursorLine", {
					bg = "#2b2a27",
					underline = false,
				})
			end

			set_cursorline()

			local group = vim.api.nvim_create_augroup("CursorLineGroup", { clear = true })

			vim.api.nvim_create_autocmd("ColorScheme", {
				group = group,
				callback = set_cursorline,
			})

			vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
				group = group,
				callback = set_cursorline,
			})
		end,
	},
}
