local autocmd = {}

autocmd.setup = function()
    --[[
    https://github.com/nvim-treesitter/nvim-treesitter/wiki/Installation 
    Users of packer.nvim have reported that when using treesitter for folds, they sometimes receive an error "No folds found", or that treesitter highlighting does not apply. A workaround for this is to set the folding options in an autocmd:
]]

    -- vim.opt.foldmethod     = 'expr'
    -- vim.opt.foldexpr       = 'nvim_treesitter#foldexpr()'
    --#region WORKAROUND
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufAdd', 'BufNew', 'BufNewFile', 'BufWinEnter' }, {
        group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
        callback = function()
            vim.opt.foldmethod = 'expr'
            vim.opt.foldexpr   = 'nvim_treesitter#foldexpr()'
            -- vim.opt.foldcolumn     = '3'
            -- vim.opt.foldenable     = false
        end
    })
    --#endregion

    vim.api.nvim_create_autocmd({ 'TermOpen' }, {
        pattern = 'term://*toggleterm#*',
        callback = function()
            keymap.execute_terminal_mapping()
        end
    })
end

return autocmd
