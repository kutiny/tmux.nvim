local Tmux = {}
local Config = require('tmux.config')
local rt = {}

function Tmux.list_sessions()
    local sessions = vim.fn.system('tmux list-sessions -F "' .. rt.config.formats.sessions .. '"')
    print(sessions)
end

function Tmux.setup(opts)
    rt.config = Config.get_config(opts)
end

vim.api.nvim_create_user_command("ListSessions", Tmux.list_sessions, {})

return Tmux
