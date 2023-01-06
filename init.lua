-- print("init.lua is loaded!")
local cmd = vim.cmd
-- local fn = vim.fn
local g = vim.g
local opt = vim.opt

local my_config = require('config')
local my_env = require('environment')
_G.keymap = require('keymap')
_G.runtime = require('core.runtime')

local prev_packpath = ',$HOME/.vim'

opt.runtimepath = opt.runtimepath + prev_packpath
opt.packpath = opt.packpath + prev_packpath

g.python3_host_prog = my_config.python_executable
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

-- plugins.lua require all config lua files for plugins
require('plugins')
require('autocmd')
require('clipboard')
keymap.setup()

--#region colorscheme
-- [fix] setting colorscheme during reload causing a nil index
if not runtime.is_reloading then
    vim.o.background = "dark"
    if not my_env.isUsingTmux then
        -- print('not using tmux, guicolors = true')
        vim.opt.termguicolors = true
        cmd 'colorscheme tokyonight-storm'
    else
        cmd 'colorscheme gruvbox'
    end
end
-- cmd 'colorscheme gruvbox'
-- cmd 'colorscheme tokyonight-storm'
--#endregion
