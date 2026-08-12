return {
	"nvim-lualine/lualine.nvim",
	config = function()
		----------------------------------------------------------------------
		-- Gruvbox Dark Theme
		----------------------------------------------------------------------
		local colors = {
			black = "#282828",
			white = "#ebdbb2",
			red = "#fb4934",
			green = "#b8bb26",
			blue = "#83a598",
			yellow = "#fe8019",
			gray = "#a89984",
			darkgray = "#3c3836",
			lightgray = "#504945",
			inactivegray = "#7c6f64",
		}

		local gruvbox_dark = {
			normal = {
				a = { bg = colors.gray, fg = colors.black, gui = "bold" },
				b = { bg = colors.lightgray, fg = colors.white },
				c = { bg = colors.darkgray, fg = colors.gray },
			},
			insert = {
				a = { bg = colors.blue, fg = colors.black, gui = "bold" },
				b = { bg = colors.lightgray, fg = colors.white },
				c = { bg = colors.lightgray, fg = colors.white },
			},
			visual = {
				a = { bg = colors.yellow, fg = colors.black, gui = "bold" },
				b = { bg = colors.lightgray, fg = colors.white },
				c = { bg = colors.inactivegray, fg = colors.black },
			},
			replace = {
				a = { bg = colors.red, fg = colors.black, gui = "bold" },
				b = { bg = colors.lightgray, fg = colors.white },
				c = { bg = colors.black, fg = colors.white },
			},
			command = {
				a = { bg = colors.green, fg = colors.black, gui = "bold" },
				b = { bg = colors.lightgray, fg = colors.white },
				c = { bg = colors.inactivegray, fg = colors.black },
			},
			inactive = {
				a = { bg = colors.darkgray, fg = colors.gray, gui = "bold" },
				b = { bg = colors.darkgray, fg = colors.gray },
				c = { bg = colors.darkgray, fg = colors.gray },
			},
		}

		----------------------------------------------------------------------
		-- Components
		----------------------------------------------------------------------

		local mode = {
			"mode",
			fmt = function(str)
				return " " .. str
			end,
		}

		local filename = {
			"filename",
			file_status = true,
			path = 1,
			fmt = function(path)
				local parts = {}
				for part in path:gmatch("[^/]+") do
					table.insert(parts, part)
				end

				if #parts >= 3 then
					return table.concat({
						parts[#parts - 2],
						parts[#parts - 1],
						parts[#parts],
					}, "/")
				else
					return path
				end
			end,
		}

		local hide_in_width = function()
			return vim.fn.winwidth(0) > 100
		end

		local diagnostics = {
			"diagnostics",
			sources = { "nvim_diagnostic" },
			sections = { "error", "warn" },
			symbols = {
				error = " ",
				warn = " ",
				info = " ",
				hint = " ",
			},
			colored = false,
			update_in_insert = false,
			always_visible = false,
			cond = hide_in_width,
		}

		local diff = {
			"diff",
			colored = false,
			symbols = {
				added = " ",
				modified = " ",
				removed = " ",
			},
			cond = hide_in_width,
		}

		----------------------------------------------------------------------
		-- Lualine
		----------------------------------------------------------------------

		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = gruvbox_dark,

				section_separators = { left = "", right = "" },
				component_separators = "",

				disabled_filetypes = { "alpha", "neo-tree" },
				always_divide_middle = true,
			},

			sections = {
				lualine_a = {
					{
						"mode",
						fmt = function(str)
							return " " .. str
						end,
						separator = { left = "" },
						right_padding = 2,
					},
				},

				lualine_b = {
					{
						"branch",
						separator = { left = "", right = "" },
					},
				},

				lualine_c = { filename },

				lualine_x = {
					diagnostics,
					diff,
					{ "encoding", cond = hide_in_width },
					{ "filetype", cond = hide_in_width },
				},

				lualine_y = { "location" },

				lualine_z = {
					{
						"progress",
						separator = { right = "" },
						left_padding = 2,
					},
				},
			},

			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {
					{ "filename", path = 1 },
				},
				lualine_x = {
					{ "location", padding = 0 },
				},
				lualine_y = {},
				lualine_z = {},
			},

			tabline = {},
			extensions = { "fugitive" },
		})
	end,
}
