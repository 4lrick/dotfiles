local M = {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	event = "BufReadPre",
}

function M.config()
	require("ibl").setup({
		scope = { enabled = false },
	})
end

return M
