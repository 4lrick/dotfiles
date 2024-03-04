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
	keymap("n", "<leader>ff", ":Telescope find_files<CR>", { silent = true })
	keymap("n", "<leader>ft", ":Telescope live_grep<CR>", { silent = true })
	keymap("n", "<leader>fn", ":Telescope notify<CR>", { silent = true })
	keymap("n", "<leader>fp", ":Telescope projects<CR>", { silent = true })
	keymap("n", "<leader>fb", ":Telescope buffers<CR>", { silent = true })
	keymap("n", "<leader>sh", ":Telescope help_tags<CR>", { silent = true })
	keymap("n", "<leader>sk", ":Telescope keymaps<CR>", { silent = true })
end

return M
