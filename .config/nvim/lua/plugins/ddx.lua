return {
    {
        "Shougo/ddx.vim",
        cmd = "Ddx",
        dependencies = {
            "vim-denops/denops.vim",
        },
    },
    {
        "Shougo/ddx-ui-hex",
        cmd = "Ddx",
        dependencies = {
            "Shougo/ddx.vim"
        }
    },
    {
        "Shougo/ddx-commands.vim",
        cmd = "Ddx",
        depandencies = {
            "Shougo/ddx.vim"
        }
    }
}
