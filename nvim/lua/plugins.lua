local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd [[packadd packer.nvim]]
end

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'numToStr/Comment.nvim'
  use { 'catppuccin/nvim', as = 'catppuccin' }
  use { 'nvim-telescope/telescope.nvim', requires = { {'nvim-lua/plenary.nvim'} } }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use 'lukas-reineke/indent-blankline.nvim'
  use 'norcalli/nvim-colorizer.lua'
  use 'nvim-lualine/lualine.nvim'

  if packer_bootstrap then
    require('packer').sync()
  end
end)