return {
	"williamboman/mason-lspconfig.nvim",
	-- version = "1.32.0",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "williamboman/mason.nvim" },
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"ansiblels",
				"bashls",
				"clangd",
				"cssls",
				"emmet_language_server",
				"html",
				"jsonls",
				"lua_ls",
				"marksman",
				"pyright",
				"rust_analyzer",
				"tailwindcss",
				"ts_ls",
				"vue_ls",
				"yamlls",
			},
			automatic_enable = true,
		})

		require("mason-tool-installer").setup({
			ensure_installed = {
				"eslint_d",
				"gdtoolkit",
				"black",
				"clang-format",
				"stylua",
				"prettier",
				"shfmt",
			},
		})
	end,
}
