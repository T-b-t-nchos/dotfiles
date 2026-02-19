return {
    'skardyy/neo-img',
    cmd = "NeoImg",
    build = ":NeoImg Install",
    config = function()
        require('neo-img').setup({
            supported_extensions = {
                png = true,
                jpg = true,
                jpeg = true,
                tiff = true,
                tif = true,
                svg = true,
                webp = true,
                bmp = true,
                gif = true, -- static only
                docx = true,
                xlsx = true,
                pdf = true,
                pptx = true,
                odg = true,
                odp = true,
                ods = true,
                odt = true
            },

            ----- Important ones -----
            size = "80%",  -- size of the image in percent
            center = true, -- rather or not to center the image in the window
            ----- Important ones -----

            ----- Less Important -----
            auto_open = false,  -- Automatically open images when buffer is loaded
            oil_preview = true, -- changes oil preview of images too
            backend = "auto",   -- auto / kitty / iterm / sixel
            resizeMode = "Fit", -- Fit / Stretch / Crop
            offset = "2x3",     -- that exmp is 2 cells offset x and 3 y.
            ttyimg = "local"    -- local / global
            ----- Less Important -----
        })
    end,
}
