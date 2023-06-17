local M = {
	"lukas-reineke/indent-blankline.nvim",
	event = "BufReadPre",
}

function M.config()
	require("indent_blankline").setup({
		show_trailing_blankline_indent = false,
	})
end

return M
