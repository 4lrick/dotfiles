local M = {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
}

function M.config()
	require("indent_blankline").setup({
		show_trailing_blankline_indent = false,
	})
end

return M
