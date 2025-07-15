-- Configuration for none-ls.nvim to manage formatters and linters
-- Sets up autoformatting for various file types, standardizes indentation to 4 spaces,
-- and enables permanent line wrapping for long lines.

return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
		"jayp0521/mason-null-ls.nvim", -- ensure dependencies are installed
	},
	config = function()
		-- Set global Neovim options for consistent indentation and line wrapping
		vim.o.tabstop = 4 -- Tabs are 4 spaces wide
		vim.o.shiftwidth = 4 -- Indentation (e.g., >>) is 4 spaces
		vim.o.expandtab = true -- Convert tabs to spaces
		vim.o.wrap = true -- Enable line wrapping for long lines

		local null_ls = require("null-ls")
		local formatting = null_ls.builtins.formatting -- to setup formatters
		local diagnostics = null_ls.builtins.diagnostics -- to setup linters

		-- Formatters & linters for mason to install
		require("mason-null-ls").setup({
			ensure_installed = {
				"prettier", -- ts/js formatter
				"eslint_d", -- ts/js linter
				"shfmt", -- Shell formatter
				"clang-format",
				-- 'checkmake', -- linter for Makefiles
				-- 'stylua', -- lua formatter; Already installed via Mason
				-- 'ruff', -- Python linter and formatter; Already installed via Mason
			},
			automatic_installation = true,
		})

		local sources = {
			diagnostics.checkmake,
			formatting.prettier.with({
				filetypes = {
					"html",
					"json",
					"yaml",
					"markdown",
					"javascript",
					"typescript",
					"javascriptreact",
					"typescriptreact",
					"css",
					"scss",
				},
				extra_args = {
					"--tab-width",
					"4", -- Use 4 spaces for indentation
					"--use-tabs",
					"false", -- Use spaces instead of tabs
				},
			}),
			formatting.stylua, -- Already defaults to 4 spaces
			formatting.shfmt.with({ args = { "-i", "4" } }),
			formatting.terraform_fmt,
			require("none-ls.formatting.ruff").with({ extra_args = { "--extend-select", "I" } }),
			require("none-ls.formatting.ruff_format"),
			formatting.clang_format.with({
				filetypes = { "c", "cpp", "objc", "objcpp" },
				extra_args = {
					"--style",
					"{IndentWidth: 4, TabWidth: 4, UseTab: Never}",
				},
			}),
		}

		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
		null_ls.setup({
			-- debug = true, -- Enable debug mode. Inspect logs with :NullLsLog.
			sources = sources,
			-- you can reuse a shared lspconfig on_attach callback here
			on_attach = function(client, bufnr)
				if client:supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ async = false })
						end,
					})
				end
			end,
		})
	end,
}
