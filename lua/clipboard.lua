local function clipboard_config()
    vim.o.clipboard = "unnamed"
    vim.g.clipboard = {
        name = "xclip-clipboard",
        copy = {
            ["+"] = {"xclip", "-i"},
            ["*"] = {"xclip", "-i"},
        },
        paste = {
            ["+"] = {"xclip", "-o"},
            ["*"] = {"xclip", "-o"},
        },
        cache_enabled = true
    }
end

clipboard_config()
