return function(_, opts)
  neovimium.lspkind = opts
  require("lspkind").init(opts)
end
