local M = {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	event = "BufReadPre",
}

function M.config()
	require("ibl").setup({
		whitespace = {
			remove_blankline_trail = false,
		},
		scope = { enabled = false },
	})
end

return M
