-- LSP configuration for Neovim with diagnostic display enhancements
-- This file sets up nvim-lspconfig, mason.nvim, and related plugins to manage LSP servers,
-- and includes diagnostic configuration to display error/warning signs, virtual text, and underlines.

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		-- Automatically install LSPs and related tools to stdpath for Neovim
		{ "mason-org/mason.nvim", config = true },

		-- Bridges the gap between LSP config names and Mason package names.
		"mason-org/mason-lspconfig.nvim",

		-- Installs LSPs, linters, formatters, etc.
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		-- Useful status updates for LSP.
		{
			"j-hui/fidget.nvim",
			opts = {
				notification = {
					window = {
						winblend = 0,
					},
				},
			},
		},

		-- Allows extra capabilities provided by nvim-cmp.
		"hrsh7th/cmp-nvim-lsp",

		-- Shows function signatures / parameters inside nvim-cmp.
		"hrsh7th/cmp-nvim-lsp-signature-help",
	},

	config = function()
		-- Configure LSP diagnostics
		vim.diagnostic.config({
			virtual_text = {
				prefix = "●",
				source = "always",
				format = function(diagnostic)
					return string.format("%s: %s", diagnostic.source, diagnostic.message)
				end,
			},

			signs = {
				active = true,
				values = {
					{ name = "DiagnosticSignError", text = "" },
					{ name = "DiagnosticSignWarn", text = "" },
					{ name = "DiagnosticSignHint", text = "" },
					{ name = "DiagnosticSignInfo", text = "" },
				},
			},

			update_in_insert = false,
			underline = true,
			severity_sort = true,

			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})

		-- LSP attach configuration
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),

			callback = function(event)
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, {
						buffer = event.buf,
						desc = "LSP: " .. desc,
					})
				end

				-- Go to definition
				map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

				-- Find references
				map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

				-- Go to implementation
				map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

				-- Go to type definition
				map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

				-- Document symbols
				map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

				-- Workspace symbols
				map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

				-- Rename
				map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

				-- Code action
				map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })

				-- Go to declaration
				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

				-- Get current LSP client
				local client = vim.lsp.get_client_by_id(event.data.client_id)

				------------------------------------------------------------------
				-- Highlight references
				------------------------------------------------------------------
				if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
					local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", {
						clear = false,
					})

					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})

					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),

						callback = function(event2)
							vim.lsp.buf.clear_references()

							vim.api.nvim_clear_autocmds({
								group = "kickstart-lsp-highlight",
								buffer = event2.buf,
							})
						end,
					})
				end

				------------------------------------------------------------------
				-- Toggle inlay hints
				------------------------------------------------------------------
				if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
					map("<leader>th", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({
							bufnr = event.buf,
						}))
					end, "[T]oggle Inlay [H]ints")
				end
			end,
		})

		----------------------------------------------------------------------
		-- LSP capabilities
		----------------------------------------------------------------------
		local capabilities = vim.lsp.protocol.make_client_capabilities()

		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		----------------------------------------------------------------------
		-- LSP servers
		----------------------------------------------------------------------
		local servers = {
			------------------------------------------------------------------
			-- JavaScript / TypeScript
			------------------------------------------------------------------
			ts_ls = {},

			------------------------------------------------------------------
			-- Python
			------------------------------------------------------------------
			pyright = {},
			ruff = {},

			------------------------------------------------------------------
			-- HTML / CSS
			------------------------------------------------------------------
			html = {
				filetypes = {
					"html",
					"twig",
					"hbs",
				},
			},

			cssls = {},
			tailwindcss = {},

			------------------------------------------------------------------
			-- Other languages/tools
			------------------------------------------------------------------
			dockerls = {},
			sqlls = {},
			terraformls = {},
			jsonls = {},
			yamlls = {},

			------------------------------------------------------------------
			-- Lua
			------------------------------------------------------------------
			lua_ls = {
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},

						runtime = {
							version = "LuaJIT",
						},

						workspace = {
							checkThirdParty = false,
							library = vim.api.nvim_get_runtime_file("", true),
						},

						diagnostics = {
							globals = { "vim" },
							disable = { "missing-fields" },
						},

						format = {
							enable = false,
						},
					},
				},
			},

			------------------------------------------------------------------
			-- C / C++
			------------------------------------------------------------------
			clangd = {
				cmd = {
					"clangd",
					"--background-index",
					"--completion-style=detailed",
					"--header-insertion=iwyu",
				},

				on_attach = function(client, bufnr)
					-- Disable diagnostics
					vim.diagnostic.enable(false, {
						bufnr = bufnr,
					})

					-- Formatting handled by none-ls + clang-format
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentRangeFormattingProvider = false
				end,
			},

			-- Alternative clangd configuration
			-- Uncomment if you want different C/C++ behavior.
			--
			-- clangd = {
			-- 	cmd = {
			-- 		"clangd",
			-- 		"--background-index",
			-- 		"--clang-tidy",
			-- 		"--completion-style=detailed",
			-- 		"--header-insertion=iwyu",
			-- 		"--function-arg-placeholders",
			-- 		"--fallback-style=llvm",
			-- 	},
			--
			-- 	filetypes = {
			-- 		"c",
			-- 		"cpp",
			-- 		"objc",
			-- 		"objcpp",
			-- 		"cuda",
			-- 		"proto",
			-- 	},
			-- },
		}

		----------------------------------------------------------------------
		-- Tools to install through Mason
		----------------------------------------------------------------------
		local ensure_installed = vim.tbl_keys(servers or {})

		vim.list_extend(ensure_installed, {
			"stylua",
			"prettier",
			"eslint_d",
			"shfmt",
			"clang-format",
		})

		require("mason-tool-installer").setup({
			ensure_installed = ensure_installed,
		})

		----------------------------------------------------------------------
		-- Configure and enable servers
		----------------------------------------------------------------------
		for server, cfg in pairs(servers) do
			cfg.capabilities = vim.tbl_deep_extend("force", {}, capabilities, cfg.capabilities or {})

			vim.lsp.config(server, cfg)
			vim.lsp.enable(server)
		end
	end,
}
