return {
	"akinsho/bufferline.nvim",
	event = { "BufReadPre", "BufNewFile", "BufAdd" },
	dependencies = { "famiu/bufdelete.nvim" },
	enabled = true,
	opts = {
		options = {
			close_command = "Bdelete! %d",
			right_mouse_command = "Bdelete! %d",
			offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
			separator_style = "thin",
		},
	},
}
