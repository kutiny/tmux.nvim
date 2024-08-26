local Config = {}

---@alias UserConfig{formats: { sessions: string?, windows: string?}?}
---@alias Config{formats: { sessions: string, windows: string}}

---Joins the user configuration with defaults
---@param user_config UserConfig
---@return Config
function Config.get_config(user_config)
    local default_config = {
        formats = {
            sessions = '#{session_name} (#{session_windows})',
            windows = '#{window_name}',
        },
    }

    return vim.tbl_extend('keep', user_config or {}, default_config)
end

return Config
