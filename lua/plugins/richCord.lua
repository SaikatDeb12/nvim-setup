return {
	"vyfor/cord.nvim",

	opts = {
		enabled = true,

		-- Neovim application settings
		editor = {
			client = "neovim",
			tooltip = "Coding with Neovim",
		},

		-- Discord Rich Presence appearance
		display = {
			theme = "catppuccin",
			flavor = "accent",
			view = "full",
			swap_icons = true,
			swap_fields = false,
		},

		-- Rich Presence messages
		text = {
			editing = function(opts)
				return "Editing " .. opts.filename
			end,

			viewing = function(opts)
				return "Viewing " .. opts.filename
			end,

			workspace = function(opts)
				return "Working on " .. opts.workspace
			end,

			dashboard = "Neovim Dashboard",
		},

		-- Custom icons for file types
		assets = {
			[".tsx"] = {
				icon = "react",
				tooltip = "React / TypeScript",
			},

			[".go"] = {
				icon = "go",
				tooltip = "Golang",
			},
		},

		-- Idle settings
		idle = {
			enabled = true,
			timeout = 300000, -- 5 minutes
			show_status = true,
			details = "Taking a break",
			tooltip = "AFK",
		},

		-- Automatically reconnect to Discord
		advanced = {
			discord = {
				reconnect = {
					enabled = true,
				},
			},
		},
	},

	-- Keybindings
	keys = {
		{
			"<leader>ds",
			"<cmd>Cord enable<CR>",
			desc = "Discord: Start Rich Presence",
		},
		{
			"<leader>dx",
			"<cmd>Cord disable<CR>",
			desc = "Discord: Stop Rich Presence",
		},
		{
			"<leader>dt",
			"<cmd>Cord toggle<CR>",
			desc = "Discord: Toggle Rich Presence",
		},
		{
			"<leader>dr",
			"<cmd>Cord restart<CR>",
			desc = "Discord: Restart Cord",
		},
		{
			"<leader>dc",
			"<cmd>Cord status<CR>",
			desc = "Discord: Connection Status",
		},
		{
			"<leader>dq",
			"<cmd>Cord shutdown<CR>",
			desc = "Discord: Shutdown Cord",
		},
	},
}
