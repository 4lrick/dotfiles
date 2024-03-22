local M = {
	"nvimdev/lspsaga.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	event = "LspAttach",
}

function M.config()
	require("lspsaga").setup({
		code_action = {
			show_server_name = true,
		},
		lightbulb = {
			virtual_text = false,
		},
		rename = {
			auto_save = true,
			keys = {
				quit = "q",
			},
		},
	})

	local opts = { noremap = true, silent = true }
	local keymap = vim.keymap.set

	keymap({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
	keymap("n", "gp", "<cmd>Lspsaga peek_definition<CR>", opts)
	keymap("n", "gd", "<cmd>Lspsaga goto_definition<CR>", opts)
	keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
	keymap("n", "<leader>lr", "<cmd>Lspsaga rename<CR>", opts)
end

return M
