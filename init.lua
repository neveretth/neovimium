if vim.loader then vim.loader.enable() end -- enable vim.loader early if available

for _, source in ipairs {
  "astronvim.bootstrap",
  "astronvim.options",
  "astronvim.lazy",
  "astronvim.autocmds",
  "astronvim.mappings",
} do
  local status_ok, fault = pcall(require, source)
  if not status_ok then vim.api.nvim_err_writeln("Failed to load " .. source .. "\n\n" .. fault) end
end

if astronvim.default_colorscheme then
  if not pcall(vim.cmd.colorscheme, astronvim.default_colorscheme) then
    require("astronvim.utils").notify("Error setting up colorscheme: " .. astronvim.default_colorscheme, "error")
  end
end

require("astronvim.utils").conditional_func(astronvim.user_opts("polish", nil, false), true)

require("notify").setup({
  background_colour = "#000000",
})

require("catppuccin").setup {
  flavour = "mocha",
  dim_inactive = {
    enabled = true,
    shade = "dark",
    percentage = .15,
  },
  --True because terminal background is the same as theme background
  transparent_background = true,
  color_overrides = {
    mocha = {
      base = "#161021",
      mantle = "#000000",
      crust = "#ea00d9",
    },
    highlight_overrides = {
    },
  },
}

-- ====== VARIOUS SETTINGS I'M TOO FUCKING LAZY TO DO PROPERLY ======
vim.cmd [[colorscheme catppuccin-mocha]]
vim.cmd [[set wrap]]

-- ====== VARIOUS KEYMAPPINGS I'M TOO FUCKING LAZY TO DO PROPERLY ======
-- Tex comp & show
vim.cmd [[nmap <leader>jl :w<cr> :!make <cr><cr>]]
vim.cmd [[nmap <leader>jo :!zathura %:r.pdf &<cr><cr>]]

vim.cmd [[inoremap <C-k><C-k> <Cmd>lua require'better-digraphs'.digraphs("insert")<CR>]]
vim.cmd [[nnoremap r<C-k><C-k> <Cmd>lua require'better-digraphs'.digraphs("normal")<CR>]]
vim.cmd [[vnoremap r<C-k><C-k> <ESC><Cmd>lua require'better-digraphs'.digraphs("visual")<CR>]]

vim.cmd [[nmap <Leader>mf _i==> <ESC> A <==<ESC>]]
vim.cmd [[nmap <Leader>mc :AddFileHeader<cr>]]

-- ====== ACTUALLY KIND OF COOL MACROS ======
-- This is a hell of a macro, I really should make it better, but I almost respect how stupid it is.
vim.cmd [[nmap <Leader>ms O<ESC>cc====== SECTION ======<ESC> k <SPACE>/_eeevbc]]
