local plugin = require("lazy.core.config").plugins["Aquavium-dev"]

vim.opt.rtp:append(plugin.dir)

require("colors.Aquavium.utils").apply()

vim.api.nvim_set_hl(0, "DashboardHeader", { fg = "#4fbee3" })

vim.g.colors_name = "Aquavium-dev"
