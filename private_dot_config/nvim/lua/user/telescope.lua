local M = {
	"nvim-telescope/telescope.nvim",
	event = "Bufenter",
	cmd = { "Telescope" },
	dependencies = {
		{
			"ahmedkhalf/project.nvim",
			"nvim-lua/plenary.nvim",
		},
	},
}

function M.config()
	local actions = require("telescope.actions")

	require("telescope").setup({
		defaults = {
			prompt_prefix = " ",
			selection_caret = " ",
			path_display = { "smart" },
			file_ignore_patterns = { ".git/", "node_modules" },
			mappings = {
				i = {
					["<Down>"] = actions.move_selection_next,
					["<Up>"] = actions.move_selection_previous,
					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,
				},
			},
		},
	})

	local keymap = vim.keymap.set
	keymap("n", "<leader>ff", ":Telescope find_files<CR>")
	keymap("n", "<leader>ft", ":Telescope live_grep<CR>")
	keymap("n", "<leader>fn", ":Telescope notify<CR>")
	keymap("n", "<leader>fp", ":Telescope projects<CR>")
	keymap("n", "<leader>fb", ":Telescope buffers<CR>")
	keymap("n", "<leader>sh", ":Telescope help_tags<CR>")
	keymap("n", "<leader>sk", ":Telescope keymaps<CR>")
end

return M
