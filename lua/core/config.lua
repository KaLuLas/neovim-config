-- PATH related configuration for the current device
local config = {}

config.python_executable = "$HOME/miniconda3/bin/python"

config.setup_vim_basic = function()
    local opt = vim.opt
    local g = vim.g
    local prev_packpath = ',$HOME/.vim'

    opt.runtimepath = opt.runtimepath + prev_packpath
    opt.packpath = opt.packpath + prev_packpath

    g.python3_host_prog = config.python_executable
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
end

return config
