local Tmux = {}
local Config = require('tmux.config')
local Helpers = require('tmux.helpers')
local rt = {}

function Tmux.list_sessions()
    local sessions = Helpers.get_sessions(rt.config)
    if rt.win then
        return
    else
        local bufwin = Helpers.create_window(rt.config)
        vim.api.nvim_buf_set_lines(bufwin.bufnr, 0, -1, false, sessions)
        vim.api.nvim_set_option_value('readonly', true, { buf = bufwin.bufnr })
        vim.api.nvim_set_option_value('modifiable', false, { buf = bufwin.bufnr })
    end

end

function Tmux.setup(opts)
    rt.config = Config.get_config(opts)
end

vim.api.nvim_create_user_command("ListSessions", Tmux.list_sessions, {})

return Tmux
