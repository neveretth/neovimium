return function(_, opts)
  local mason_lspconfig = require "mason-lspconfig"
  mason_lspconfig.setup(opts)
  mason_lspconfig.setup_handlers {
    function(server) require("neovimium.utils.lsp").setup(server) end,
  }
  require("neovimium.utils").event "MasonLspSetup"
end
