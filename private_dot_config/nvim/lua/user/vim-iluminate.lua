local M = {
	"RRethy/vim-illuminate",
	event = "VeryLazy",
}

function M.config()
	local illuminate = require("illuminate")
	illuminate.configure({
		large_file_cutoff = 5000,
		providers = {
			"lsp",
			"treesitter",
			"regex",
		},
		filetypes_denylist = {
			"dirvish",
			"fugitive",
			"alpha",
			"NvimTree",
			"packer",
			"neogitstatus",
			"Trouble",
			"lir",
			"Outline",
			"spectre_panel",
			"toggleterm",
			"DressingSelect",
			"TelescopePrompt",
		},
	})
end

return M
