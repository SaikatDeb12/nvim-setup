return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",

		config = function()
			require("toggleterm").setup({
				size = function(term)
					if term.direction == "horizontal" then
						return 15
					elseif term.direction == "vertical" then
						return math.floor(vim.o.columns * 0.40)
					end
				end,

				start_in_insert = true,
				insert_mappings = true,
				terminal_mappings = true,
				persist_size = true,
				persist_mode = true,
				close_on_exit = true,
				auto_scroll = true,

				direction = "horizontal",

				shade_terminals = true,
				shading_factor = -30,

				float_opts = {
					border = "rounded",
				},
			})

			------------------------------------------------------------------
			-- Terminal keymaps
			------------------------------------------------------------------

			-- Toggle current terminal
			vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<CR>", {
				desc = "Toggle Terminal",
			})

			-- New horizontal terminal (bottom)
			vim.keymap.set("n", "<leader>tn", "<cmd>ToggleTerm direction=horizontal<CR>", {
				desc = "New Bottom Terminal",
			})

			-- New vertical terminal
			vim.keymap.set("n", "<leader>th", function()
				vim.cmd("leftabove vsplit")
				vim.cmd("ToggleTerm direction=vertical")
			end, { desc = "Vertical Terminal Left" })

			vim.keymap.set("n", "<leader>tl", function()
				vim.cmd("rightbelow vsplit")
				vim.cmd("ToggleTerm direction=vertical")
			end, { desc = "Vertical Terminal Right" })

			------------------------------------------------------------------
			-- Terminal mode mappings
			------------------------------------------------------------------

			local function set_terminal_keymaps()
				local opts = { buffer = 0 }

				-- Leave terminal mode
				vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], opts)

				-- Navigate windows
				vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
				vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
				vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
				vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)

				-- Resize windows (optional)
				vim.keymap.set("t", "<C-Up>", [[<Cmd>resize +2<CR>]], opts)
				vim.keymap.set("t", "<C-Down>", [[<Cmd>resize -2<CR>]], opts)
				vim.keymap.set("t", "<C-Left>", [[<Cmd>vertical resize -2<CR>]], opts)
				vim.keymap.set("t", "<C-Right>", [[<Cmd>vertical resize +2<CR>]], opts)
			end

			vim.api.nvim_create_autocmd("TermOpen", {
				pattern = "term://*",
				callback = set_terminal_keymaps,
			})
		end,
	},
}
