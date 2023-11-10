return {
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = {
    ---@type lspconfig.options
    servers = {
      angularls = {
        root_dir = require("lspconfig.util").root_pattern("angular.json", "project.json"),
      },
    },
  },
}
