-- NOTE: set to auto read when a file is changed from the outside
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
	pattern = "*",
	command = "checktime",
})

-- NOTE: return to last position when editing the file && disable fixendofline
vim.api.nvim_create_autocmd("BufRead", {
	pattern = "*",
	callback = function()
		vim.cmd("normal g'\"")
		vim.cmd("set fixendofline")
	end,
})

-- NOTE: disable diagnostics for other people's code
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile", "LspAttach" }, {
	pattern = { ".env*", "*/node_modules/*" },
	callback = function(args)
		vim.diagnostic.disable(args.buf)
		vim.lsp.stop_client(args.buf)
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "neotest-output", "neotest-output-panel", "neotest-attach" },
	callback = function()
		vim.cmd("norm G")
		vim.cmd("setlocal number")
		vim.cmd("setlocal relativenumber")
	end,
})

-- NOTE: set correct filetypes
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.tfvars",
	command = "setlocal filetype=tf",
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.conf",
	command = "setlocal filetype=conf",
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { ".env*" },
	command = "setlocal filetype=sh",
})

-- NOTE: renew shortcuts
vim.api.nvim_create_autocmd({ "VimLeave" }, {
	pattern = "bm-*",
	command = "!shortcuts",
})

-- NOTE: compile suckless scripts & reload them
-- vim.api.nvim_create_autocmd({ "VimLeave" }, {
-- 	pattern = "*/src/*/config.h",
-- 	command = "!sudo make install",
-- })

local auto_commit = function(type, scope)
	return "git add .; git commit -m '"
		.. type
		.. "("
		.. scope
		.. "): ⚙️ auto-commit changes'; git pull && git push;"
end

vim.api.nvim_create_autocmd({ "VimLeave" }, {
	pattern = vim.fn.expand("$VIMWIKI_DIR") .. "/*",
	callback = function()
		vim.fn.jobstart(auto_commit("docs", "vimwiki"), { detach = true })
	end,
})

vim.api.nvim_create_autocmd({ "VimLeave" }, {
	pattern = {
		vim.fn.expand("$HOME") .. "/.config/shell/aliasrc*",
		vim.fn.expand("$HOME") .. "/.config/shell/profile*",
		vim.fn.expand("$HOME") .. "/.config/ticker/.ticker.yaml",
		"bm-*",
	},
	callback = function()
		local filename = vim.fn.expand("%:t")
		vim.fn.jobstart(auto_commit("config", filename), { detach = true })
	end,
})
