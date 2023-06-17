local M = {
	"akinsho/bufferline.nvim",
	event = { "BufReadPre", "BufAdd", "BufNew", "BufReadPost" },
	dependencies = {
		{
			"famiu/bufdelete.nvim",
		},
	},
}

function M.config()
	require("bufferline").setup({
		options = {
			close_command = "Bdelete! %d",
			right_mouse_command = "Bdelete! %d",
			offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
			separator_style = "thin",
		},
	})
end

return M
