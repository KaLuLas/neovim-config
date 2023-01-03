-- print("init.lua is loaded!")
local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local opt = vim.opt

local prev_packpath = ',$HOME/.vim'

opt.runtimepath = opt.runtimepath + prev_packpath
opt.packpath = opt.packpath + prev_packpath

g.python3_host_prog = "$HOME/miniconda3/bin/python"
g.loaded_perl_provider = 0

-- show line number
opt.number = true

-- show eol, space
opt.list = true
opt.listchars:append "space:·"
opt.listchars:append "eol:"

-- 4 spaces indent
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4

-- no wrapping
vim.wo.wrap = false

local my_env = require('environment')

-- plugins.lua require all config lua files for plugins
require('plugins')
require('autocmd')
require('clipboard')
require('keymap')

--#region colorscheme
vim.o.background = "dark"
if not my_env.isUsingTmux then
    -- print('not using tmux, guicolors = true')
    vim.opt.termguicolors = true
    cmd 'colorscheme tokyonight-storm'
else
    cmd 'colorscheme gruvbox'
end

-- cmd 'colorscheme gruvbox'
-- cmd 'colorscheme tokyonight-storm'
--#endregion
