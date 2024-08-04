local group = require('tmux.autocmd')
local Buffer = {}

function Buffer.initialize(rt)
    vim.api.nvim_create_autocmd('BufLeave', {
        group = group,
        buffer = rt.buf,
        callback = function()
            vim.api.nvim_win_close(rt.win, true)
        end,
    })

    vim.keymap.set('n', '<CR>', function()
        local curr_line = vim.api.nvim_get_current_line()
        local id = nil

        if not id then
            print("There was an error.")
            return
        end

        vim.api.nvim_win_close(rt.win, true)
    end, {
        buffer = rt.buf,
        silent = true,
    })

    vim.api.nvim_buf_set_lines(rt.buf, 0, -1, false, rt.buffer_text)
end

return Buffer
