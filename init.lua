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
      --611021
      mantle = "#000000",
      crust = "#ea00d9",
    },
    highlight_overrides = {
    },
  },
}

vim.cmd [[colorscheme catppuccin-mocha]]
vim.cmd [[set wrap]]
-- Tex comp & show
vim.cmd [[nmap <leader>jl :w<cr> :!make <cr><cr>]] -- && rm %:r.aux %:r.log %:r.blg %:r.bcf %:r.bbl %:r.run.xml <cr><cr>]]
vim.cmd [[nmap <leader>jo :!zathura %:r.pdf &<cr><cr>]]
-- Prettier
vim.cmd [[nmap <leader>pp :w<cr> :!npx prettier --write % <cr>]]
-- Java comp & run
vim.cmd [[nmap <leader>jc :w<cr> :!javac % ]]
vim.cmd [[nmap <leader>jd :!java %:r ]]
vim.cmd [[nmap <leader>je :TermExec cmd="java %:r"]] -- add <cr> after makes it faster, maybe give it feeler?
-- c/cpp comp & run (kinda odd keys, but it works)
-- vim.cmd[[nmap <leader>jg :w<cr> :!make % ]]
vim.cmd [[nmap <leader>jv :w<cr> :!make ]]
vim.cmd [[nmap <leader>jf :!./%:r ]]
vim.cmd [[nmap <leader>jr :TermExec cmd="./%:r"]] -- add <cr> after makes it faster, maybe give it feeler?

-- Testing for calendar.vim
vim.cmd [[nmap <leader>pc :Calendar<cr>]] -- && rm %:r.aux %:r.log %:r.blg %:r.bcf %:r.bbl %:r.run.xml <cr><cr>]]

vim.cmd [[inoremap <C-k><C-k> <Cmd>lua require'better-digraphs'.digraphs("insert")<CR>]]
vim.cmd [[nnoremap r<C-k><C-k> <Cmd>lua require'better-digraphs'.digraphs("normal")<CR>]]
vim.cmd [[vnoremap r<C-k><C-k> <ESC><Cmd>lua require'better-digraphs'.digraphs("visual")<CR>]]

vim.cmd [[nmap <Leader>mf _i==> <ESC> A <==<ESC>]]

-- auto-reload files when modified externally
-- vim.o.autoread = true
-- vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
-- 	command = "if mode() != 'c' | checktime | endif",
-- 	pattern = { "*" },
-- })
