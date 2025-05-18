return {
	settings = {
		Lua = {
			format = {
				enable = false,
			},
			diagnostics = {
				globals = { "vim", "_lazygit_toggle" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
			telemetry = {
				enable = false,
			},
		},
	},
}
