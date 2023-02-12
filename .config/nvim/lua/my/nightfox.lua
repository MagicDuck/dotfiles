require('nightfox').setup({
    options = {
        -- colorblind = {
        --   enable = false,        -- Enable colorblind support
        --   simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
        --   severity = {
        --     protan = 0,          -- Severity [0,1] for protan (red)
        --     deutan = 0,          -- Severity [0,1] for deutan (green)
        --     tritan = 0,          -- Severity [0,1] for tritan (blue)
        --   },
        -- },
        styles = { -- Style to be applied to different syntax groups
            -- comments = "NONE", -- Value is any valid attr-list value `:help attr-list`
            -- conditionals = "NONE",
            -- constants = "NONE",
            -- functions = "NONE",
            -- keywords = "NONE",
            -- numbers = "NONE",
            -- operators = "NONE",
            -- strings = "NONE",
            -- types = "NONE",
            -- variables = "NONE",
        },
        inverse = { -- Inverse highlight for different types
            match_paren = false,
            visual = false,
            search = false,
        },
        module_default = true, -- Default enable value for modules
        -- modules = {             -- List of various plugins and additional options
        --   -- ...
        -- },
    },
    palettes = {
        dayfox = {
            comment = "#544D47"
        }
    },
    -- for all specs, :lua = require('nightfox.spec').load("dayfox")
    specs = {
        dayfox = {
            syntax = {
                commentBackground = "#F0E4DA"
            }
        }
    },
    groups = {
        -- Note: use :TSHighlightCapturesUnderCursor to figure out what what to change
        dayfox = {
            Comment = { bg = "syntax.commentBackground", fg = "palette.comment" },
            SpecialComment = { bg = "syntax.commentBackground", fg = "palette.comment" },
            TSComment = { bg = "syntax.commentBackground", fg = "palette.comment" },

            Todo = { bg = "syntax.commentBackground", fg = "#4C9E90", style = "bold" },
            ["@text.todo"] = { bg = "syntax.commentBackground", fg = "#4C9E90", style = "bold" },
            MyTodo = { bg = "syntax.commentBackground", fg = "#BE7E05", style = "bold" },

            CursorLine = { bg = "#F0E4DA" },

            TelescopeMatching = { fg = "#d05858", style = "bold" },
            SignatureMarkText = { fg = "#B4703E", style = "bold" }
        }
    },
})
vim.cmd([[set fillchars=diff:\ ,fold:\ ,vert:\│,eob:\ ,msgsep:‾]])
vim.cmd("colorscheme dayfox")
vim.cmd("set background=light")
