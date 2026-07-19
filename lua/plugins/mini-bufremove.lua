return {
	{
		"echasnovski/mini.bufremove",
		version = "*",
		config = function()
			local bufremove = require("mini.bufremove")
			bufremove.setup()

			vim.keymap.set("n", "<leader>x", function()
				bufremove.delete(0, false)
			end, { desc = "Delete Buffer" })
		end,
	},
}
