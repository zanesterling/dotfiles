local format_on_save = require('format-on-save')
local formatters = require('format-on-save.formatters')

format_on_save.setup({
	exclude_search_patterns = {},

	formatter_by_ft = {
		rust = formatters.lsp,
	},

	experiments = {
		partial_update = 'diff',
	}
})
