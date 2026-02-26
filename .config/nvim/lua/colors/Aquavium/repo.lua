local plugin = require("lazy.core.config").plugins["Aquavium"]

vim.opt.rtp:append(plugin.dir)

require("colors.Aquavium").apply()

vim.g.colors_name = "Aquavium"
