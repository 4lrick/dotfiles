local M = {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
}

function M.config()
	require("lint").linters_by_ft = {
		javascript = { "eslint" },
		typescript = { "eslint" },
		javascriptreact = { "eslint" },
		typescriptreact = { "eslint" },
		c = { "clang-tidy" },
		cpp = { "clang-tidy" },
	}
end

return M
