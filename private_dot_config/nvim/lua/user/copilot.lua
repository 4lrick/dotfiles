local M = {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	enabled = true,
}
function M.config()
	require("copilot").setup({})
end

return M
