local M = {
	"zbirenbaum/copilot-cmp",
	event = { "InsertEnter", "LspAttach" },
}
function M.config()
	require("copilot_cmp").setup()
end

return M
