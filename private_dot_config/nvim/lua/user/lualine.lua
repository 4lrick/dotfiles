return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "echasnovski/mini.icons" },
	event = "VeryLazy",
	config = function()
		require("mini.icons").setup()
		require("mini.icons").mock_nvim_web_devicons()
		require("lualine").setup({})
	end,
}
