local snacks = require('snacks')


snacks.setup({

    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = false},
    dashboard = { enabled = false},
    explorer = { enabled = false},
    indent = { enabled = false},
    image = {
        enabled = true,
        formats = {
            "png",
            "jpg",
            "jpeg",
            "gif",
            "bmp",
            "webp",
            "tiff",
            "heic",
            "avif",
            "mp4",
            "mov",
            "avi",
            "mkv",
            "webm",
            "pdf",
            "icns",
        },
        force = true,
        doc = {
            enabled = true,
            inline = true,
            float = false,
            max_width = 80,
            max_height = 40,
        },
        img_dirs = {
            'assets', 'images', 'imgs', 'media'
        },
        convert = {
            notify = true
        }
    },
    input = { enabled = false},
    picker = { enabled = false},
    notifier = { enabled = false},
    quickfile = { enabled = false},
    scope = { enabled = false},
    scroll = { enabled = false},
    statuscolumn = { enabled = false},
    words = { enabled = false},

})
