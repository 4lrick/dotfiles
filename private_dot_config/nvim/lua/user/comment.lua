local M = {
	"numToStr/Comment.nvim",
	lazy = false,
}

function M.config()
	require("Comment").setup(vim.api.nvim_command("set commentstring=#%s"))
end

return M
