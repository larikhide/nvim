return {
  {
    'williamboman/mason.nvim',
    lazy = false,
    opts = {},
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    config = function()
      local cmp = require('cmp')

            cmp.setup({
                sources = {
                    {name = 'nvim_lsp'},
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),
                    ['<CR>'] = cmp.mapping.confirm({ select = true })
                }),
                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body)
                    end,
                },
            })
        end
    },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    cmd = {'LspInfo', 'LspInstall', 'LspStart'},
    event = {'BufReadPre', 'BufNewFile'},
    dependencies = {
      {'hrsh7th/cmp-nvim-lsp'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},
    },
    config = function()
      local lsp_defaults = require('lspconfig').util.default_config

      -- Add cmp_nvim_lsp capabilities settings to lspconfig
      -- This should be executed before you configure any language server
      lsp_defaults.capabilities = vim.tbl_deep_extend(
        'force',
        lsp_defaults.capabilities,
        require('cmp_nvim_lsp').default_capabilities()
      )

      -- LspAttach is where you enable features that only work
      -- if there is a language server active in the file
      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(event)
          local opts = {buffer = event.buf}

                    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
                    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
                    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
                    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
                    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
                    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
                    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
                    vim.keymap.set('n', '<S-F6>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
                    vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
                    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
                    vim.keymap.set("n", "<F2>", vim.diagnostic.goto_next)
                    vim.keymap.set("n", "<S-F2>", vim.diagnostic.goto_prev)

                    -- go to next error. if there is not an error then go to next hint
                    local M = {}

                    M.pos_equal = function (p1, p2)
                        local r1, c1 = unpack(p1)
                        local r2, c2 = unpack(p2)
                        return r1 == r2 and c1 == c2
                    end

                    M.goto_error_then_hint = function ()
                        local pos = vim.api.nvim_win_get_cursor(0)
                        vim.diagnostic.goto_next( {severity=vim.diagnostic.severity.ERROR, wrap = true} )
                        local pos2 = vim.api.nvim_win_get_cursor(0)
                        if ( M.pos_equal(pos, pos2)) then
                            vim.diagnostic.goto_next( {wrap = true} )
                        end
                    end

                    return M

            end,
      })

            require('mason-lspconfig').setup({
                ensure_installed = {
                    "lua_ls",
                    "gopls",
                },
                handlers = {
                    -- this first function is the "default handler"
                    -- it applies to every language server without a "custom handler"
                    function(server_name)
                        require('lspconfig')[server_name].setup({
                        })
                    end,

                    ["lua_ls"] = function()
                        local lspconfig = require("lspconfig")
                        lspconfig.lua_ls.setup {
                            capabilities = lsp_defaults.capabilities,
                            settings = {
                                Lua = {
                                    runtime = { version = "Lua 5.1" },
                                    diagnostics = {
                                        globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                                    }
                                }
                            }
                        }
                    end,

                    ["gopls"] = function()
                        local lspconfig = require("lspconfig")
                        lspconfig.gopls.setup({
                            capabilities = lsp_defaults.capabilities,
                            settings = {
                                gopls = {
                                    analyses = {
                                        unusedparams = true,
                                    },
                                    staticcheck = true,
                                    completeUnimported = true,
                                    usePlaceholders = true,
                                },
                            },
                        })
                    end,
                }
            })
        end
    }
}
