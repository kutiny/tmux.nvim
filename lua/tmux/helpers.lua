local Helpers = {}
local group = require('tmux.autocmd')

function Helpers.get_sessions(config)
    local raw_sessions = vim.fn.system('tmux list-sessions -F "' .. config.formats.sessions .. '"')
    local sessions = {}
    for line in raw_sessions:gmatch(".*\n") do
        local text = string.gsub(line, '\n', '')
        table.insert(sessions, text)
    end
    return sessions
end

function Helpers.create_window(config)
    local win = vim.api.nvim_list_uis()
    local width = config.width or 80

    if #win > 0 and not config.width then
        width = math.floor(win[1].width * 0.7)
    end

    local height = config.height or 8
    local bufnr = vim.api.nvim_create_buf(false, true)
    local win_id = vim.api.nvim_open_win(bufnr, true, {
        relative = "editor",
        title = config.title,
        title_pos = config.title_pos,
        row = math.floor(((vim.o.lines - height) / 2) - 1),
        col = math.floor((vim.o.columns - width) / 2),
        width = width,
        height = height,
        style = "minimal",
        border = config.border,
    })

    local function close_win()
        vim.api.nvim_clear_autocmds({ group = group })
        vim.api.nvim_win_close(win_id, true)
    end

    vim.keymap.set('n', 'q', function()
        close_win()
    end, { buffer = bufnr, silent = true })

    vim.keymap.set('n', '<Esc>', function()
        close_win()
    end, { buffer = bufnr, silent = true })

    vim.keymap.set('n', '<CR>', function()
        print('golis')
        close_win()
    end, { buffer = bufnr, silent = true })


    return {
        win_id = win_id,
        bufnr = bufnr,
    }
end

return Helpers
