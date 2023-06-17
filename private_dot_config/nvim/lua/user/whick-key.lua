local M = {
	"folke/which-key.nvim",
	event = "VeryLazy",
}

function M.opts()
	vim.o.timeout = true
	vim.o.timeoutlen = 300
	require("which-key").setup({})
end

return M
