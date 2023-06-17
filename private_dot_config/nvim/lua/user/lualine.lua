local M = {
	"nvim-lualine/lualine.nvim",
	requires = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
}

function M.config()
	require("lualine").setup({
		options = {
			theme = "tokyonight",
		},
	})
end

return M
