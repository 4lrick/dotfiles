local M = {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>F",
			function()
				require("conform").format({ async = true, lsp_fallback = true, quiet = true })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
}

M.config = function()
	require("conform").setup({
		formatters_by_ft = {
			python = { "black" },
			c = { "clang_format" },
			cpp = { "clang_format" },
			lua = { "stylua" },
			javascript = { "prettier", "eslint_d" },
			typescript = { "prettier", "eslint_d" },
			javascriptreact = { "prettier", "eslint_d" },
			typescriptreact = { "prettier", "eslint_d" },
			vue = { "prettier", "eslint_d" },
			bash = { "shfmt" },
		},
	})
end

return M
