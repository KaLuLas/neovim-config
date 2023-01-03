-- setup personal environment varaibles in vim.env
local env = vim.env
local my_env = {}

-- true if current using tmux
my_env.isUsingTmux = env.TMUX ~= nil

return my_env
