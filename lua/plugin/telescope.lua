require('telescope').setup{
    -- https://github.com/nvim-telescope/telescope-live-grep-args.nvim not used
    extensions = {
        frecency = {
            show_scores = true,
            -- bad for customization
            --[[workspaces = {
                conf = "$HOME/.config/nvim",
            }]]--
        }
    }--
}

