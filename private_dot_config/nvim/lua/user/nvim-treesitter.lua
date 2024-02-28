local M = {
	"nvim-treesitter/nvim-treesitter",
	event = "BufReadPost",
	build = ":TSUpdate",

	dependencies = {
		{
			"JoosepAlviste/nvim-ts-context-commentstring",
			event = "VeryLazy",
		},
		{
			"nvim-tree/nvim-web-devicons",
			event = "VeryLazy",
		},
	},
}
function M.config()
	-- local treesitter = require("nvim-treesitter")
	local configs = require("nvim-treesitter.configs")

	configs.setup({
		ensure_installed = {
			"bash",
			"c",
			"cpp",
			"css",
			"dockerfile",
			"html",
            "javascript",
			"json",
			"lua",
			"make",
			"markdown",
			"markdown_inline",
			"python",
            "tsx",
            "typescript",
            "vue",
			"yaml",
		},
		sync_install = false,

		highlight = {
			enable = true, -- false will disable the whole extension
		},
		autopairs = {
			enable = true,
		},
		indent = { enable = true },
	})
end

return M
