return {
	"olimorris/codecompanion.nvim",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	keys = {
		{ "<C-a>", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "CodeCompanion Actions" },
		{ "<Leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "Toggle Chat" },
		{ "ga", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "Add to Chat" },
	},
	opts = {
		adapters = {
			copilot = function()
				return require("codecompanion.adapters").extend("copilot", {
					schema = {
						model = {
							-- default = "claude-3.7-sonnet-thought",
							default = "claude-3.5-sonnet",
						},
					},
				})
			end,
		},
		strategies = {
			chat = { adapter = "copilot" },
			inline = { adapter = "copilot" },
			cmd = { adapter = "copilot" },
		},
		display = {
			chat = {
				window = {
					position = "right",
				},
			},
		},
	},
}
