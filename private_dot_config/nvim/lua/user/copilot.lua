return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "BufReadPost",
	enabled = true,
	opts = {
		suggestion = { enabled = false },
		panel = { enabled = false },
		filetypes = { markdown = true },
	},
}
