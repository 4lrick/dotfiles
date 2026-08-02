return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local treesitter = require("nvim-treesitter")

		treesitter.setup()

		treesitter.install({
			"bash",
			"c",
			"cpp",
			"c_sharp",
			"css",
			"dockerfile",
			"gdscript",
			"html",
			"hyprlang",
			"javascript",
			"json",
			"lua",
			"make",
			"markdown",
			"markdown_inline",
			"python",
			"query",
			"tsx",
			"typescript",
			"vim",
			"vimdoc",
			"vue",
			"yaml",
		})

		vim.api.nvim_create_autocmd("FileType", {
			callback = function()
				pcall(vim.treesitter.start)
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
