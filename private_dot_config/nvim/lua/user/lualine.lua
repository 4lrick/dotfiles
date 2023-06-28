local M = {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
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
