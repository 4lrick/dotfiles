vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	desc = "Highlight on yank",
	group = vim.api.nvim_create_augroup("highlight_on_yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	desc = "Pause illuminate on large files",
	callback = function()
		local line_count = vim.api.nvim_buf_line_count(0)
		if line_count >= 5000 then
			vim.cmd("IlluminatePauseBuf")
		end
	end,
})
