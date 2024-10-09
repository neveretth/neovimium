-- ============================================================
--    NAME: Neovimium
--  AUTHOR: N. Everett Howard  <howard@nth.blue>
-- VERSION: v0.2.1                    CHANGED: 2024-09-15
-- LICENSE: MIT                       CREATED: 2023-03-13
-- ============================================================
-- DESCRIPTION & COMMENTS:                                     
-- Find further documentation at      
-- docs.nth.blue/neovimium                                            
-- ============================================================

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

require'marks'.setup {
  -- whether to map keybinds or not. default true
  default_mappings = true,
  -- which builtin marks to show. default {}
  builtin_marks = { ".", "^" },
  -- whether movements cycle back to the beginning/end of buffer. default true
  cyclic = true,
  -- whether the shada file is updated after modifying uppercase marks. default false
  force_write_shada = false,
  -- how often (in ms) to redraw signs/recompute mark positions. 
  -- higher values will have better performance but may cause visual lag, 
  -- while lower values may cause performance penalties. default 150.
  refresh_interval = 250,
  -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
  -- marks, and bookmarks.
  -- can be either a table with all/none of the keys, or a single number, in which case
  -- the priority applies to all marks.
  -- default 10.
  sign_priority = { lower=10, upper=15, builtin=8, bookmark=20 },
  -- disables mark tracking for specific filetypes. default {}
  excluded_filetypes = {},
  -- disables mark tracking for specific buftypes. default {}
  excluded_buftypes = {},
  -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
  -- sign/virttext. Bookmarks can be used to group together positions and quickly move
  -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
  -- default virt_text is "".
  bookmark_0 = {
    sign = "⚑",
    virt_text = "hello world",
    -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
    -- defaults to false.
    annotate = false,
  },
  mappings = {}
}

-- ====== VARIOUS SETTINGS I'M TOO FUCKING LAZY TO DO PROPERLY ======
vim.cmd [[colorscheme catppuccin-mocha]]
vim.cmd [[set wrap]]
-- resize vs
vim.cmd [[nnoremap <C-right> :vertical resize -5<cr>]]
vim.cmd [[nnoremap <C-left> :vertical resize +5<cr>]]
vim.cmd [[nnoremap <C-down> :resize -5<cr>]]
vim.cmd [[nnoremap <C-up> :resize +5<cr>]]

-- ====== VARIOUS KEYMAPPINGS I'M TOO FUCKING LAZY TO DO PROPERLY ======
-- Temporary vim-pencil bindings
vim.cmd [[nmap <leader>uP :TogglePencil<cr> :SoftPencil <cr><cr>]]

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
vim.cmd [[nmap <Leader>ms O<ESC>cc====== @@@ ======<ESC> k <SPACE>/_f@ce]]
