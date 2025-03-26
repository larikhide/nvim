function ColorMyPencils()

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.cmd [[highlight SignColumn ctermbg=NONE guibg=NONE]]
    vim.opt.fillchars:append({ eob = ' ' })
end

return {
    {
        'morhetz/gruvbox',
        lazy = false,    -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            -- load the colorscheme here
            -- vim.cmd([[colorscheme gruvbox]])
        end,
    },
    {
        'folke/tokyonight.nvim',
        lazy = false,    -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            -- load the colorscheme here
            vim.cmd([[colorscheme tokyonight]])
        end,
    },
    {
        'Mofiqul/dracula.nvim',
        lazy = false,    -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            -- load the colorscheme here
            -- vim.cmd([[colorscheme dracula-soft]])
        end,
    },
        {
        'romainl/Apprentice',
        lazy = false,    -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            -- load the colorscheme here
--            vim.cmd([[colorscheme apprentice]])
--            vim.cmd [[highlight SignColumn ctermbg=NONE guibg=NONE]]
--            vim.opt.fillchars:append({ eob = ' ' })
        end,
    }

}
