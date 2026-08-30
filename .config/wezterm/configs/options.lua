local M = {}

local state = require("config_state")

function M.apply(config)
    config.check_for_updates = true
    config.check_for_updates_interval_seconds = 86400

    if state.IS_WINDOWS then
        config.default_prog = { "pwsh.exe" }
    else
        config.default_prog = { "bash", "-l" }
    end

    if state.IS_WINDOWS then
        config.launch_menu = {
            {
                label = "PowerShell",
                args = { "pwsh.exe" },
                set_environment_variables = {
                    MSYSTEM = nil,
                    MSYS = nil,
                    MSYS2_PATH_TYPE = nil,
                },
            },
            { label = "Cmd", args = { "cmd.exe" } },
            { label = "Git Bash", args = { "C:/Program Files/git/bin/bash.exe" } },
            { label = "WSL Bash", args = { "bash", "-l" } },
            { label = "NeoVim (native)", args = { "nvim" } },
        }
    else
        -- Linux / Ubuntu
        config.launch_menu = {
            { label = "Bash", args = { "bash", "-l" } },
            { label = "NeoVim", args = { "nvim" } },
        }
    end
end

return M
