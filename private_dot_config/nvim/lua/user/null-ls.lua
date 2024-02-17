local M = {
	"jose-elias-alvarez/null-ls.nvim",
	event = "BufReadPre",
	dependencies = {
		{
			"nvim-lua/plenary.nvim",
		},
	},
}

function M.config()
	local notify = vim.notify
	---@diagnostic disable-next-line: duplicate-set-field
	vim.notify = function(msg, ...)
		if msg:match("warning: multiple different client offset_encodings") then
			return
		end

		notify(msg, ...)
	end

	local null_ls = require("null-ls")
	local formatting = null_ls.builtins.formatting
	local diagnostics = null_ls.builtins.diagnostics

	null_ls.setup({
		sources = {
			formatting.black,
			formatting.clang_format,
			diagnostics.flake8,
			formatting.stylua,
			formatting.prettier,
		},
	})
end

return M
