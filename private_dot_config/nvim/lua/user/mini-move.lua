local M = {
	"echasnovski/mini.move",
	version = false,
	event = "VeryLazy",
}

function M.config()
	require("mini.move").setup()
end

return M
