return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	enabled = true,
	opts = {
		suggestion = { enabled = false },
		panel = { enabled = false },
		filetypes = { markdown = true },
	},
}
