local M = {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
}

function M.config()
	require("noice").setup({
		lsp = {
			hover = {
				enabled = false,
			},
			signature = {
				enabled = false,
			},
		},
		notify = {
			enabled = false,
		},
	})
    require("notify").setup({
        timeout = 1,
        max_width = 50,
        render = "wrapped-compact",
    })
end

return M
