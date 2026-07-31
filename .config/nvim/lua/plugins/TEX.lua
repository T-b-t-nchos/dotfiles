return {
    {
        "lervag/vimtex",
        ft = {"tex"},

        init = function ()
            vim.g.tex_flavor = "lualatex"

            vim.g.vimtex_quickfix_ignore_all_warnings = 1
            vim.g.vimtex_quickfix_mode = 2

            vim.g.vimtex_compiler_latexmk = {
                background = 1,
                build_dir = "",
                continuous = 1,
                options = {
                    "-lualatex",
                    "-verbose",
                    "-file-line-error",
                    "-synctex=1",
                    "-interaction=nonstopmode",
                    "-shell-escape",
                },
            }

            if vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1 or (vim.fn.has('unix') == 1 and vim.fn.exists('$WSLENV') == 1) then
                if vim.fn.executable('SumatraPDF.exe') == 1 then
                    vim.g.vimtex_view_general_viewer = vim.fn.expand("$LOCALAPPDATA") .. "/SumatraPDF/SumatraPDF.exe"
                    vim.g.vimtex_view_general_options = "-reuse-instance -forward-search @tex @line @pdf"
                end
            end
        end,

        config = function()
        end,
    },
}
