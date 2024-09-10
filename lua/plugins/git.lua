return {
  "lewis6991/gitsigns.nvim",
  enabled = vim.fn.executable "git" == 1,
  ft = "gitcommit",
  event = "User AstroGitFile",
  opts = {
    signs = {
      -- ====== new icons ======
      -- Don't know if I like this or hate this...
      add = { text = "+" },
      change = { text = "Δ" },
      delete = { text = "-" },
      topdelete = { text = "▬" },
      changedelete = { text = "-" },
      untracked = { text = "·" },
      
      -- ====== original icons ======
      -- add = { text = "▎" },
      -- change = { text = "▎" },
      -- delete = { text = "▎" },
      -- topdelete = { text = "契" },
      -- changedelete = { text = "▎" },
      -- untracked = { text = "▎" },
    },
  },
}
