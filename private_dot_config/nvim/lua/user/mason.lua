local M = {
	"williamboman/mason.nvim",
	cmd = "Mason",
	event = "BufReadPre",
	lazy = false,
	dependencies = {
		{
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
	},
}

local settings = {
	ui = {
		border = "none",
		icons = {
			package_installed = "◍",
			package_pending = "◍",
			package_uninstalled = "◍",
		},
	},
}

function M.config()
	require("mason").setup(settings)
	require("mason-lspconfig").setup({
		ensure_installed = require("utils").servers,
		automatic_installation = true,
	})
	require("mason-tool-installer").setup({
		ensure_installed = {
			-- linters
			"eslint_d",

			-- formatters
			"black",
			"clang-format",
			"stylua",
			"prettier",
		},
	})
end

return M
