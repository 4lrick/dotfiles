local M = {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>F",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
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
			javascript = { "prettier" },
		},
	})
end

return M
