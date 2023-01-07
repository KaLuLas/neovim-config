-- print("init.lua is loaded!")
local cmd = vim.cmd
local l_env = require('core.environment')
-- personal global varaible used outside init.lua
_G.keymap = require('core.keymap')
_G.runtime = require('core.runtime')

require("core.config").setup_vim_basic()

-- plugins.lua require all config lua files for plugins, run on require()
require('core.plugins')
require('core.autocmd').setup()
require('core.clipboard').setup()
keymap.setup_end_mapping()

--#region colorscheme
-- [fix] setting colorscheme during reload causing a nil index
if not runtime.is_reloading then
    vim.o.background = "dark"
    if not l_env.is_using_tmux then
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
