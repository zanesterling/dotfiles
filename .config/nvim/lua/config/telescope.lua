local builtin = require('telescope.builtin')

--vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
--vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
--vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>h', builtin.help_tags, {})
vim.keymap.set('n', '<leader>s', builtin.lsp_dynamic_workspace_symbols, {})

vim.keymap.set('n', 'gr', builtin.lsp_references, {})
vim.keymap.set('n', 'gi', builtin.lsp_implementations, {})
vim.keymap.set('n', 'gd', builtin.lsp_definitions, {})
vim.keymap.set('n', 'gD', builtin.lsp_type_definitions, {})

local treesitter = require('nvim-treesitter')

vim.api.nvim_create_autocmd("User", {
	pattern = "TelescopePreviewerLoaded",
	callback = function(args)
		if vim.list_contains(treesitter.get_installed(), vim.treesitter.language.get_lang(args.data.filetype))
		then
			vim.treesitter.start(args.data.bufname)
		end
	end,
})
