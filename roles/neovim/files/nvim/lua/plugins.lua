vim.cmd [[packadd packer.nvim]]
return require'packer'.startup {
  function(use)
    local function local_use(package)
      if type(package) == 'string' then
        package = {package}
      end
      local _, path = next(package)
      path = "~/code/"..path
      if vim.fn.isdirectory(vim.fn.expand(path)) == 1 then
        package[1] = path
        use(package)
      end
    end

    use {'wbthomason/packer.nvim', opt = true}

    use 'tpope/vim-commentary'
    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'
    use 'tpope/vim-eunuch'

    use {
      'tpope/vim-fugitive',
      config = function()
        map('<leader>gs', ':Gtabedit :<cr>')
        map('<leader>gh', ':Gtabedit @<cr>')
      end
    }

    -- XXX(vheon): try to remap the quit button to `gq` to be consistent with
    -- fugitive and dirfish
    use {
      'junegunn/gv.vim',
      config = function()
        map('<leader>gl', ':GV<cr>')
        map('<leader>gr', ':GV -20<cr>')
      end
    }

    use {
      'TimUntersberger/neogit',
      requires = {
        'nvim-lua/plenary.nvim',
        'sindrets/diffview.nvim'
      },
      config = function()
        require'neogit'.setup {
          disable_context_highlighting = false,
          integrations = { diffview = true }
        }
      end
    }

    use 'justinmk/vim-dirvish'

    -- XXX(vheon): I really like the abbreviation but it always gets in the way
    -- when I'm writing comments
    use {
      'tpope/vim-endwise',
      config = function()
        vim.g.endwise_abbreviations = 1
      end
    }

    use 'tpope/vim-unimpaired'
    use 'tpope/vim-abolish'
    use 'tpope/vim-rsi'

    -- XXX(andrea): this need a post-update hook to build the (or download a pre-built) binary!
    local_use 'ycm.nvim'
    -- use {
    --   'Valloric/YouCompleteMe',
    --   config = function()
    --     vim.g.ycm_confirm_extra_conf    = 0
    --     vim.g.ycm_complete_in_comments  = 1
    --     -- let g:ycm_global_ycm_extra_conf = g:dotvim.'/ycm_extra_conf.py'
    --     -- let g:ycm_extra_conf_vim_data   = [ '&filetype' ]
    --     -- let g:ycm_seed_identifiers_with_syntax = 1
    --     -- let g:ycm_filetype_blacklist = { 'help': 1 }
    --     vim.g.ycm_key_list_stop_completion = {''}
    --   end,
    --   run = './install.py'
    -- }

    use 'tpope/vim-scriptease'

    use 'pboettch/vim-cmake-syntax'
    use 'chikamichi/mediawiki.vim'
    use 'elixir-editors/vim-elixir'

    -- XXX(andrea): I'm still not sure about this one :/
    use {
      'romainl/vim-qf',
      config = function()
        vim.g.qf_window_bottom = 0
        vim.g.qf_loclist_window_bottom = 0
        vim.g.qf_auto_open_quickfix = 0
        vim.g.qf_auto_open_loclist = 0
        map('<Leader>q', '<Plug>(qf_qf_toggle_stay)', { noremap = false })
        map('<Leader>l', '<Plug>(qf_loc_toggle_stay)', { noremap = false })
      end
    }

    use {
      'wincent/ferret',
      config = function()
        vim.g.FerretMap = 0
        vim.g.FerretAutojump = 0
        map('<Leader>sw', ':Ack! -w <C-r><C-w><cr>', { silent = false })
      end
    }

    use { 'junegunn/fzf', run = './install --xdg --no-update-rc --no-key-bindings --no-completion' }
    use {
      'junegunn/fzf.vim',
      config = function()
        vim.g.fzf_layout = {
          window = {
            width = 0.99,
            height = 0.4,
            yoffset = 0.9
          }
        }
        map('<Leader>fg', ':GFiles<cr>')
        map('<Leader>ff', ':Files<cr>')
        map('<Leader>fb', ':Buffers<cr>')
        map('<Leader>ft', ':Tags<cr>')

        vim.g.fzf_colors = {
          fg =      {'fg', 'Normal'},
          bg =      {'bg', 'Comment'},
          hl =      {'fg', 'Comment'},
          ['fg+'] = {'fg', 'SignifySignChange', 'CursorColumn', 'Normal'},
          ['bg+'] = {'bg', 'CursorLineNr', 'CursorColumn'},
          ['hl+'] = {'fg', 'Statement'},
          info =    {'fg', 'PreProc'},
          border =  {'fg', 'Ignore'},
          prompt =  {'fg', 'Conditional'},
          pointer = {'fg', 'Exception'},
          marker =  {'fg', 'Keyword'},
          spinner = {'fg', 'Label'},
          header =  {'fg', 'Comment'}
        }
      end
    }

    use 'bakpakin/fennel.vim'

    use 'jvirtanen/vim-hcl'
    use 'pprovost/vim-ps1'

    use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate', -- XXX(andrea): we need to :TSInstall maintained on first install
      config = function()
        require'nvim-treesitter.configs'.setup {
          highlight = {
            enable = true
          },
          textobjects = {
            move = {
              enable = true,
              goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer",
              },
              goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
              },
              goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
              },
              goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
              },
            },
            select = {
              enable = true,
              keymaps = {
                ["i,"] = "@parameter.inner",
                ["a,"] = "@parameter.outer",
              }
            },
            swap = {
              enable = true,
              swap_next = {
                [">,"] = "@parameter.inner",
              },
              swap_previous = {
                ["<,"] = "@parameter.inner",
              },
            }
          }
        }
        end
    }
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'nvim-treesitter/playground'

    use {
      'neovim/nvim-lspconfig',
      config = function()
        local on_attach = function(_, bufnr)
          vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

          -- Mappings
          local opts = { buffer = bufnr }
          map('gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
          map('gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
          map('K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
          map('gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
          -- map('<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
          -- map('<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
          -- map('<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
          -- map('gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
          -- map('<leader>e', '<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>', opts)
        end
        local lspconfig = require'lspconfig'
        lspconfig.gopls.setup {
          on_attach = on_attach
        }
        lspconfig.yamlls.setup{}
      end
    }

    use 'khaveesh/vim-fish-syntax'

    use 'kyazdani42/nvim-web-devicons'

    use {
      'akinsho/nvim-toggleterm.lua',
      config = function()
        require("toggleterm").setup {
          direction = 'float',
          open_mapping = '<leader>t',
          insert_mappings = false,
          float_opts = {
            border = 'single'
          }
        }
      end
    }

    -- XXX(andrea): without the range feature this is not that great of idea
    -- for my use case. For now we will probably use either a port in lua of
    -- clang-format.py script or the python script directly (even though I
    -- don't want python configured in nvim at all.
    --
    -- use {
    --   'mhartington/formatter.nvim',
    --   config = function()
    --     require('formatter').setup {
    --       logging = false,
    --       filetype = {
    --         cpp = {
    --           function()
    --             return {
    --               exe = "clang-format-12",
    --               stdin = true
    --             }
    --           end
    --         }
    --       }
    --     }
    --     map('<Leader>gq', '<cmd>Format<cr><esc>', { mode = '', noremap = false })
    --   end
    -- }

    -- plugin to bundle all nvim settings for work
    -- local_use 'bigfixdev.nvim'
  end,
  config = {
    disable_commands = true,
    display = {
      non_interactive = #vim.api.nvim_list_uis() == 0,
      open_cmd = 'tabnew',
      keybindings = {
        quit = 'gq'
      }
    }
  }
}

