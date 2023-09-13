vim.opt.autoindent    = true		        -- Copy indent from current line when starting a new line
vim.opt.clipboard     = "unnamedplus"    	-- Use system clipboard
vim.opt.expandtab     = true		        -- In Insert mode: Use the appropriate number of spaces to insert a <Tab>
vim.opt.hlsearch      = true		        -- highlight search pattern
vim.opt.ignorecase    = true		        -- Ignore case in search patterns
vim.opt.number        = true		        -- Print the line number in front of each line
vim.opt.scrolloff     = 10                  -- Minimal number of screen lines to keep above and below the cursor
vim.opt.shiftwidth    = 4		            -- Number of spaces to use for each step of (auto)indent
vim.opt.sidescrolloff = 10                  -- The minimal number of screen columns to keep to the left and to the right of the cursor
vim.opt.signcolumn    = "yes"               -- When and how to draw the signcolumn (yes = always)
vim.opt.smartcase     = true		        -- Override the 'ignorecase' option if the search pattern contains upper case characters
vim.opt.smartindent   = true		        -- Do smart autoindenting when starting a new line
vim.opt.tabstop	      = 4                   -- Number of spaces that a <Tab> in the file counts for
vim.opt.termguicolors = true                -- Enables 24-bit RGB color in the TUI
vim.opt.undofile      = true		        -- When on, Vim automatically saves undo history to an undo file when writing a buffer to a file, and restores undo history from the same file on buffer read
vim.opt.wrap 	      = false        	    -- When on, lines longer than the width of the window will wrap and displaying continues on the next line
vim.opt.autoread      = true                -- When a file has been detected to have been changed outside of Vim and it has not been changed inside of Vim, automatically read it again
