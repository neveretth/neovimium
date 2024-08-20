return function(_, opts)
  vim.g.digraph_map_sequences = {
    insert = "<C-k><C-k>",
    normal = "r<C-k><C-k>",
    visual = "r<C-k><C-k>"
  }
end
