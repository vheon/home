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

    use {
      'mhartington/oceanic-next',
      config = function()
        vim.g.oceanic_next_terminal_bold = 1
        vim.g.oceanic_next_terminal_italic = 1
        vim.cmd [[colorscheme OceanicNext]]
      end
    }

    use 'tpope/vim-commentary'
    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'
    use 'tpope/vim-eunuch'

    use {
      'tpope/vim-fugitive',
      config = function()
        nnoremap('<leader>gs', ':Gtabedit :<cr>')
        nnoremap('<leader>gh', ':Gtabedit @<cr>')
      end
    }

    -- XXX(vheon): try to remap the quit button to `gq` to be consistent with
    -- fugitive and dirfish
    use {
      'junegunn/gv.vim',
      config = function()
        nnoremap('<leader>gl', ':GV<cr>')
        nnoremap('<leader>gr', ':GV -20<cr>')
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

    -- XXX(andrea): This could probably be replaced with nvim-treesitter-textobjects
    -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects#text-objects-swap
    -- use 'PeterRincker/vim-argumentative'

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

    -- XXX(vheon): is this still needed with treesitter??
    -- use 'vim-jp/cpp-vim'
    -- use 'octol/vim-cpp-enhanced-highlight'
    use 'pboettch/vim-cmake-syntax'

    use 'chikamichi/mediawiki.vim'


    use 'elixir-editors/vim-elixir'

    use {
      'romainl/vim-qf',
      config = function()
        vim.g.qf_window_bottom = 0
        vim.g.qf_loclist_window_bottom = 0
        vim.g.qf_auto_open_quickfix = 0
        vim.g.qf_auto_open_loclist = 0
        nmap('<Leader>q', '<Plug>(qf_qf_toggle_stay)')
        nmap('<Leader>l', '<Plug>(qf_loc_toggle_stay)')
      end
    }

    use {
      'wincent/ferret',
      config = function()
        vim.g.FerretMap = 0
        vim.g.FerretAutojump = 0
        nnoremap('<Leader>sw', ':Ack! -w <C-r><C-w><cr>')
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
        local opts = { silent = true }
        nnoremap('<Leader>fg', ':GFiles<cr>', opts)
        nnoremap('<Leader>ff', ':Files<cr>', opts)
        nnoremap('<Leader>fb', ':Buffers<cr>', opts)
        nnoremap('<Leader>ft', ':Tags<cr>', opts)

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
    -- XXX(vheon): to activate??
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    -- require'nvim-treesitter.configs'.setup {
    --   highlight = {
    --     enable = true
    --   },
    --   textobjects = {
    --     move = {
    --       enable = true,
    --       goto_next_start = {
    --         ["]m"] = "@function.outer",
    --         ["]]"] = "@class.outer",
    --       },
    --       goto_next_end = {
    --         ["]M"] = "@function.outer",
    --         ["]["] = "@class.outer",
    --       },
    --       goto_previous_start = {
    --         ["[m"] = "@function.outer",
    --         ["[["] = "@class.outer",
    --       },
    --       goto_previous_end = {
    --         ["[M"] = "@function.outer",
    --         ["[]"] = "@class.outer",
    --       },
    --     },
    --     select = {
    --       enable = true,
    --       keymaps = {
    --         ["i,"] = "@parameter.inner",
    --       }
    --     }
    --   },
    -- }

    use 'nvim-treesitter/playground'

    use {
      'neovim/nvim-lspconfig',
      config = function()
        local on_attach = function(_, bufnr)
          vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

          -- Mappings
          local opts = { silent = true, buffer = bufnr }
          nnoremap('gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
          nnoremap('gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
          nnoremap('K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
          nnoremap('gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
          -- nnoremap('<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
          -- nnoremap('<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
          -- nnoremap('<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
          -- nnoremap('gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
          -- nnoremap('<leader>e', '<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>', opts)
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

    -- plugin to bundle all nvim settings for work
    -- local_use 'bigfixdev.nvim'
  end,
  config = {
    disable_commands = true,
    display = {
      open_cmd = 'tabnew',
      keybindings = {
        quit = 'gq'
      }
    }
  }
}

