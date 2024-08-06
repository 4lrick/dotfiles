local M = {
	"OXY2DEV/markview.nvim",
	ft = "markdown",

	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
}

function M.config()
	require("markview").setup({
		modes = { "n", "i", "no", "c" },
		hybrid_modes = { "i" },
	})
end

return M
