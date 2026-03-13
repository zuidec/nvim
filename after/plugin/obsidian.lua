local obsidian = require('obsidian')
--
-- Compatibility: Lua-5.1
function split(str, pat)
   local t = {}  -- NOTE: use {n = 0} in Lua-5.0
   local fpat = "(.-)" .. pat
   local last_end = 1
   local s, e, cap = str:find(fpat, 1)
   while s do
      if s ~= 1 or cap ~= "" then
         table.insert(t, cap)
      end
      last_end = e+1
      s, e, cap = str:find(fpat, last_end)
   end
   if last_end <= #str then
      cap = str:sub(last_end)
      table.insert(t, cap)
   end
   return t
end

obsidian.setup({
    -- A list of workspace names, paths, and configuration overrides.
    -- If you use the Obsidian app, the 'path' of a workspace should generally be
    -- your vault root (where the `.obsidian` folder is located).
    -- When obsidian.nvim is loaded by your plugin manager, it will automatically set
    -- the workspace to the first workspace in the list whose `path` is a parent of the
    -- current markdown file being edited.

    legacy_commands = false,
    workspaces = {
        {
            name = "personal",
            path = "~/notes/personal",
        },
        {
            name = "school",
            path = "~/notes/school",
            -- Optional, override certain settings.
            overrides = {
                --notes_subdir = "notes",
            },
        },
        {
            name = "no-vault",
            path = function()
                -- alternatively use the CWD:
                -- return assert(vim.fn.getcwd())
                return assert(vim.fs.dirname(vim.api.nvim_buf_get_name(0)))
            end,
            overrides = {
                notes_subdir = vim.NIL,  -- have to use 'vim.NIL' instead of 'nil'
                new_notes_location = "current_dir",
                templates = {
                    subdir = vim.NIL,
                },
                frontmatter = {
                    enabled = false
                },
            },
        },
    },

    -- Alternatively - and for backwards compatibility - you can set 'dir' to a single path instead of
    -- 'workspaces'. For example:
    -- dir = "~/vaults/work",

    -- Optional, if you keep notes in a specific subdirectory of your vault.
    --notes_subdir = "notes",

    -- Optional, set the log level for obsidian.nvim. This is an integer corresponding to one of the log
    -- levels defined by "vim.log.levels.*".
    log_level = vim.log.levels.INFO,

    daily_notes = {
        -- Optional, if you keep daily notes in a separate directory.
        --    folder = "notes/dailies",
        -- Optional, if you want to change the date format for the ID of daily notes.
        date_format = "%Y-%m-%d",
        -- Optional, if you want to change the date format of the default alias of daily notes.
        alias_format = "%B %-d, %Y",
        -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
        template = nil
    },

    -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
    completion = {
        -- Set to false to disable completion.
        nvim_cmp = true,
        -- Trigger completion at 2 chars.
        min_chars = 2,
    },


    -- Where to put new notes. Valid options are
    --  * "current_dir" - put new notes in same directory as the current buffer.
    --  * "notes_subdir" - put new notes in the default notes subdirectory.
    new_notes_location = "current_dir",

    -- Optional, customize how note IDs are generated given an optional title.
    ---@param title string|?
    ---@return string
    --note_id_func = function(title)
    --  -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
    --  -- In this case a note with the title 'My new note' will be given an ID that looks
    --  -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
    --  local suffix = ""
    --  if title ~= nil then
    --    -- If title is given, transform it into valid file name.
    --    suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
    --  else
    --    -- If title is nil, just add 4 random uppercase letters to the suffix.
    --    for _ = 1, 4 do
    --      suffix = suffix .. string.char(math.random(65, 90))
    --    end
    --  end
    --  return tostring(os.time()) .. "-" .. suffix
    --end,

    note_id_func = function(title)
        local suffix = ""
        if title ~= nil then
            -- If title is given, transform it into valid file name.
            suffix = title:gsub(" ", "_"):gsub("[^A-Za-z0-9_]", ""):lower()
        else
            -- If title is nil, just add 4 random uppercase letters to the suffix.
            for _ = 1, 4 do
                suffix = suffix .. string.char(math.random(65, 90))
            end
        end
        return suffix
    end,

    -- Optional, customize how note file names are generated given the ID, target directory, and title.
    ---@param spec { id: string, dir: obsidian.Path, title: string|? }
    ---@return string|obsidian.Path The full path to the new note.
    note_path_func = function(spec)
        local path = spec.dir / tostring(spec.id)
        return path:with_suffix(".md")
    end,

    -- Either 'wiki' or 'markdown'.
    link = {
        style = "wiki",
    },

    -- Optional, customize the default name or prefix when pasting images via `:ObsidianPasteImg`.
    ---@return string
    --image_name_func = function()
    --  -- Prefix image names with timestamp.
    --  return string.format("%s-", os.time())
    --end,


    -- Optional, boolean or a function that takes a filename and returns a boolean.
    -- `true` indicates that you don't want obsidian.nvim to manage frontmatter.
    frontmatter = {
        enabled = true,
        -- func = require('obsidian.builtin').frontmatter,
        func = function(note)
            -- Add the title of the note as an alias.
            if note.title then
                local alias_list = split(note.title, " ")
                for k,v in pairs(alias_list) do
                    print(k,v)
                    note:add_alias(v)
                end
            end

            local out = { id = note.id, aliases = note.aliases, tags = note.tags }

            -- `note.metadata` contains any manually added fields in the frontmatter.
            -- So here we just make sure those fields are kept in the frontmatter.
            if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
                for k, v in pairs(note.metadata) do
                    out[k] = v
                end
            end

            return out
        end,
        sort = {'id','aliases','tags'}
    },


    -- Optional, for templates (see below).
    --templates = {
    --  subdir = "templates",
    --  date_format = "%Y-%m-%d",
    --  time_format = "%H:%M",
    --  -- A map for custom variables, the key should be the variable and the value a function
    --  substitutions = {},
    --},

    open = {
        func = function(uri)
            vim.ui.open(uri, {cmd = {'open', '-a', "/Applications/Obsidian.app"} })
        end
    },

    picker = {
    -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
        name = "telescope.nvim",
        -- Optional, configure key mappings for the picker. These are the defaults.
        -- Not all pickers support all mappings.
        mappings = {
            -- Create a new note from your query.
            new = "<C-x>",
            -- Insert a link to the selected note.
            insert_link = "<C-l>",
        },
    },

    -- Optional, sort search results by "path", "modified", "accessed", or "created".
    -- The recommend value is "modified" and `true` for `sort_reversed`, which means, for example,
    -- that `:ObsidianQuickSwitch` will show the notes sorted by latest modified time
    search = {
        sort_by = "modified",
        sort_reversed = true,
    },

    -- Optional, determines how certain commands open notes. The valid options are:
    -- 1. "current" (the default) - to always open in the current window
    -- 2. "vsplit" - to open in a vertical split if there's not already a vertical split
    -- 3. "hsplit" - to open in a horizontal split if there's not already a horizontal split
    open_notes_in = "current",

    -- Optional, define your own callbacks to further customize behavior.
    callbacks = {
    --  -- Runs at the end of `require("obsidian").setup()`.
        post_setup = function(client)
            vim.keymap.set('n', '<leader><cr>', '<cmd>Obsidian toggle_checkbox<cr>', {
                buffer = true,
                desc = 'Toggle checkbox',
            })
            vim.keymap.set('n', '<cr>',
                function()
                    if require 'obsidian'.util.cursor_on_markdown_link(nil,nil,true) then
                        return '<cmd>Obsidian follow_link<CR>'
                    end
                    return nil
                end,
                { buffer = true, expr = true}
            )
        end,

    --  -- Runs anytime you enter the buffer for a note.
    --  enter_note = function(note) end,

    --  -- Runs anytime you leave the buffer for a note.
    --  leave_note = function(client, note) end,

    --  -- Runs right before writing the buffer for a note.
    --  pre_write_note = function(client, note) end,

    --  -- Runs anytime the workspace is set/changed.
    --  post_set_workspace = function(client, workspace) end,
    },

    checkbox = {
        order = { " ","x",">","/","~" },
        create_new = false,
    },

    -- Optional, configure additional syntax highlighting / extmarks.
    -- This requires you have `conceallevel` set to 1 or 2. See `:help conceallevel` for more details.
    ui = {
        enable = false,  -- set to false to disable all additional syntax features, needed for use with render-markdown.nvim
        update_debounce = 200,  -- update delay after a text change (in milliseconds)
        -- Define how various check-boxes are displayed
        -- Use bullet marks for non-checkbox lists.
        bullets = { char = "•", hl_group = "ObsidianBullet" },
        external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
        -- Replace the above with this if you don't have a patched font:
        -- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
        reference_text = { hl_group = "ObsidianRefText" },
        highlight_text = { hl_group = "ObsidianHighlightText" },
        tags = { hl_group = "ObsidianTag" },
        block_ids = { hl_group = "ObsidianBlockID" },
        hl_groups = {
            -- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
            ObsidianTodo = { bold = true, fg = "#f78c6c" },
            ObsidianDone = { bold = true, fg = "#89ddff" },
            ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
            ObsidianTilde = { bold = true, fg = "#ff5370" },
            ObsidianBullet = { bold = true, fg = "#89ddff" },
            ObsidianRefText = { underline = true, fg = "#c792ea" },
            ObsidianExtLinkIcon = { fg = "#c792ea" },
            ObsidianTag = { italic = true, fg = "#89ddff" },
            ObsidianBlockID = { italic = true, fg = "#89ddff" },
            ObsidianHighlightText = { bg = "#75662e" },
        },
    },

    -- Specify how to handle attachments.
    attachments = {
        -- The default folder to place images in via `:ObsidianPasteImg`.
        -- If this is a relative path it will be interpreted as relative to the vault root.
        -- You can always override this per image by passing a full path to the command instead of just a filename.
        folder = "assets/imgs",  -- This is the default
        -- A function that determines the text to insert in the note when pasting an image.
        -- It takes two arguments, the `obsidian.Client` and an `obsidian.Path` to the image file.
        -- This is the default implementation.
        ---@param client obsidian.Client
        ---@param path obsidian.Path the absolute path to the image file
        ---@return string
        img_text_func = function(client, path)
            path = client:vault_relative_path(path) or path
            return string.format("![%s](%s)", path.name, path)
        end,
    },
    footer = {
        enabled = false
    }
})
