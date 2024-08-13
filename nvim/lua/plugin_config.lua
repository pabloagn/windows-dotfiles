local M = {}

function M.setup()
  -- LSP configurations
  require('lspconfig').pylsp.setup{}

  -- Comment.nvim setup
  require('Comment').setup()

  -- Catppuccin theme setup
  require("catppuccin").setup({
      flavour = "mocha",
      background = { light = "mocha", dark = "mocha" },
      transparent_background = true,
      -- ... (rest of your catppuccin configuration)
  })
  vim.cmd.colorscheme "catppuccin"

  -- Completion setup
  local cmp = require('cmp')
  local luasnip = require('luasnip')
  require('luasnip.loaders.from_vscode').lazy_load()
  luasnip.config.setup {}

  cmp.setup {
      -- ... (your cmp configuration)
  }

  -- Telescope setup
  require('telescope').setup({
      -- ... (your telescope configuration)
  })
  require('telescope').load_extension('fzf')

  -- Indent-blankline setup
  require("ibl").setup()

  -- Colorizer setup
  require("colorizer").setup {
      -- ... (your colorizer configuration)
  }

  -- Lualine setup
  require('lualine').setup({
      -- ... (your lualine configuration)
  })

  -- Treesitter setup
  require('nvim-treesitter.configs').setup {
      -- ... (your treesitter configuration)
  }
end

return M