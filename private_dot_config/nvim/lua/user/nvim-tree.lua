local M = {
	"kyazdani42/nvim-tree.lua",
	event = "VimEnter",
}

function M.config()
	require("nvim-tree").setup({
		update_focused_file = {
			enable = true,
			update_cwd = false,
		},
		renderer = {
			highlight_git = true,
			icons = {
				show = {
					git = false,
				},
			},
		},
		git = {
			ignore = false,
		},
	})

	vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
end

return M
