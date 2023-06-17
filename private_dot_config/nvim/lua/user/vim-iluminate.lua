local M = {
	"RRethy/vim-illuminate",
	event = "VeryLazy",
}

function M.config()
	local illuminate = require("illuminate")
	illuminate.configure({
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
