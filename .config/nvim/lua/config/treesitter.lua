require'nvim-treesitter.configs'.setup {
  -- A directory to install the parsers into.
  -- If this is excluded or nil parsers are installed
  -- to either the package dir, or the "site" dir.
  -- If a custom path is used (not nil) it must be added to the runtimepath.
  parser_install_dir = nil,

  -- A list of parser names, or "all"
  ensure_installed = { "lua", "rust", "vim" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = {},

  highlight = { enable = true },
  incremental_selection = { enable = true },
  indent = { enable = true },
}
