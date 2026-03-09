---@generic T
---@param super T[]
---@param sub T[]
---@return T[]
function table.except(super, sub)
  local result = {}
  local seenInResult = {}
  local lookupSub = {}

  for _, value in ipairs(sub) do
    lookupSub[value] = true
  end

  for _, value in ipairs(super) do
    if not lookupSub[value] and not seenInResult[value] then
      table.insert(result, value)
      seenInResult[value] = true
    end
  end

  return result
end

local treesitter = require('nvim-treesitter')
treesitter.setup()
treesitter.install(table.except({ "lua", "rust", "vim" }, treesitter.get_installed()))

vim.api.nvim_create_autocmd('FileType', {
	callback = function(args)
		if vim.list_contains(treesitter.get_installed(), vim.treesitter.language.get_lang(args.match))
		then
			vim.treesitter.start(args.buf)
			-- folds, provided by neovim
			vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
			vim.wo.foldmethod = 'expr'
			-- indentation, provided by nvim-treesitter
			--vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end
	end,
})
