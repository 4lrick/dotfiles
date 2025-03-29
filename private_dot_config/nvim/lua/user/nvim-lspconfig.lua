return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "saghen/blink.cmp" },
	},
	config = function()
		local capabilities = require("blink.cmp").get_lsp_capabilities({
			textDocument = {
				completion = {
					completionItem = {
						snippetSupport = true,
					},
				},
			},
		})

		local opts = { noremap = true, silent = true }
		local keymap = vim.keymap.set

		keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
		keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
		keymap("n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
		keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
		keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
		keymap("n", "<leader>li", "<cmd>LspInfo<CR>", opts)
		keymap("n", "<leader>lI", "<cmd>Mason<CR>", opts)
		keymap("n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>", opts)
		keymap("n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<CR>", opts)
		keymap("n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
		keymap("n", "<leader>ll", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
		keymap({ "n", "v" }, "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
		keymap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)

		local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")

		mason_lspconfig.setup_handlers({
			function(server_name)
				local server_opts = {
					capabilities = capabilities,
				}

				local ok, custom_opts = pcall(require, "ls_settings." .. server_name)
				if ok then
					server_opts = vim.tbl_deep_extend("force", custom_opts, server_opts)
				end

				lspconfig[server_name].setup(server_opts)
			end,
		})

		if lspconfig.gdscript then
			lspconfig.gdscript.setup({
				capabilities = capabilities,
			})
		end

		local signs = {
			{ name = "DiagnosticSignError", text = "" },
			{ name = "DiagnosticSignWarn", text = "" },
			{ name = "DiagnosticSignHint", text = "" },
			{ name = "DiagnosticSignInfo", text = "" },
		}

		for _, sign in ipairs(signs) do
			vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
		end

		local config = {
			-- disable virtual text
			virtual_text = false,
			-- show signs
			signs = {
				active = signs,
			},
			update_in_insert = true,
			underline = true,
			severity_sort = true,
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
				suffix = "",
			},
		}

		vim.diagnostic.config(config)

		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
			border = "rounded",
		})

		vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
			border = "rounded",
		})
	end,
}
