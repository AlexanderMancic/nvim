-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    opts = {
      ensure_installed = { 'ts_ls' }, -- Use ts_ls instead of tsserver
    },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        tsserver = {}, -- remains, for backward compatibility
        ts_ls = {}, -- the one Mason will actually install
      },
    },
  },
}
