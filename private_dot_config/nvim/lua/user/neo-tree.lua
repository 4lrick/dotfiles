local M = {
	"nvim-neo-tree/neo-tree.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	event = "VimEnter",
}

function M.config()
	require("neo-tree").setup({
		event_handlers = {
			{
				event = "file_opened",
				handler = function(file_path)
					-- auto close
					-- vimc.cmd("Neotree close")
					-- OR
					require("neo-tree.command").execute({ action = "close" })
				end,
			},
		},
		close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
		filesystem = {
			filtered_items = {
				hide_dotfiles = false,
			},
			bind_to_cwd = true, -- true creates a 2-way binding between vim's cwd and neo-tree's root
		},
	})

	vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { silent = true })
end

return M
