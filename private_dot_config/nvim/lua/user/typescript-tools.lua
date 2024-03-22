local M = {
	"pmizio/typescript-tools.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	event = { "BufReadPre", "BufNewFile" },
}

function M.config()
	require("typescript-tools").setup({})
end

return M
