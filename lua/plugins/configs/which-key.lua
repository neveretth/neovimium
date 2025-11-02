return function(_, opts)
  require("which-key").setup(opts)
  require("neovimium.utils").which_key_register()
end
