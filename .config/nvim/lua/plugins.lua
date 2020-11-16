vim.cmd [[packadd packer.nvim]]

local function packer_define_default_commands()
  vim.cmd [[command! PackerInstall  lua require('packer').install()]]
  vim.cmd [[command! PackerUpdate   lua require('packer').update()]]
  vim.cmd [[command! PackerSync     lua require('packer').sync()]]
  vim.cmd [[command! PackerClean    lua require('packer').clean()]]
  vim.cmd [[command! PackerCompile  lua require('packer').compile()]]
end

local function nnoremap(lhs, rhs, opts)
  opts = opts or {}
  vim.tbl_extend('force', opts, { noremap = true })
  vim.api.nvim_set_keymap('n', lhs, rhs, opts)
end
local function nmap(lhs, rhs)
  vim.api.nvim_set_keymap('n', lhs, rhs, {})
end

local packer = require('packer')
-- I like to have settings and mappings regarding a plugin near its declaration
-- so that when I disable a plugin I don't miss the settings and mappings
-- behind causing problems. I've added a `init` key wrapping the configuration
-- in a function.
packer.set_handler('init', function(plugins, plugin, f)
  local disabled = plugin.disable or false
  if not disabled then
    f()
  end
end)
-- helper function to setup pure lua plugins. Using this we can write the setup
-- even if the plugin is still not installed. Look down below for
-- nvim-treesitter for an example.
-- XXX(andrea): should probably log something when the module is not found.
local function with_module(module, f)
  return function()
    local ok, module = pcall(require,module)
    if ok then
      f(module)
    end
  end
end
packer.init({ display = { open_cmd = 'tabnew' } })
packer.reset()

local use = packer.use
local function local_use(package)
  local path = nil
  if type(package) == "table" then
    _, path = next(package)
    path = "~/code/"..path
    if vim.fn.isdirectory(vim.fn.expand(path)) == 1 then
      package[1] = path
      use(package)
    end
  else
    path = "~/code/" .. package
    if vim.fn.isdirectory(vim.fn.expand(path)) == 1 then
      package = path
      use(package)
    end
  end
end

-- Packer can manage itself as an optional plugin
use {'wbthomason/packer.nvim', opt = true}

use 'mhartington/oceanic-next'

use 'tpope/vim-commentary'
use 'tpope/vim-surround'
use 'tpope/vim-repeat'
use 'tpope/vim-eunuch'

use {
  'tpope/vim-fugitive',
  init = function()
    nnoremap('<leader>gs', ':Gtabedit :<cr>')
    nnoremap('<leader>gh', ':Gtabedit @<cr>')
  end
}

use {
  'junegunn/gv.vim',
  init = function()
    nnoremap('<leader>gl', ':GV<cr>')
    nnoremap('<leader>gr', ':GV -20<cr>')
  end
}

use 'justinmk/vim-dirvish'

-- XXX(vheon): I really like the abbreviation but it always gets in the way
-- when I'm writing comments
use {
  'tpope/vim-endwise',
  init = function()
    vim.g.endwise_abbreviations = 1
  end
}

use 'tpope/vim-unimpaired'
use 'tpope/vim-abolish'
use 'tpope/vim-rsi'

use 'PeterRincker/vim-argumentative'

local_use { 'ycm.nvim', opt = true }

-- use {
--   'Valloric/YouCompleteMe',
--   init = function()
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

use 'vim-jp/cpp-vim'
use 'octol/vim-cpp-enhanced-highlight'
use 'pboettch/vim-cmake-syntax'

use 'chikamichi/mediawiki.vim'


use 'elixir-editors/vim-elixir'

use {
  'romainl/vim-qf',
  init = function()
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
  init = function()
    vim.g.FerretMap = 0
    vim.g.FerretAutojump = 0
    nnoremap('<Leader>sw', ':Ack! -w <C-r><C-w><cr>')
  end
}

use { 'junegunn/fzf', run = './install --all' }
use {
  'junegunn/fzf.vim',
  init = function()
    vim.g.fzf_layout = {
      window = {
        width = 0.99,
        height = 0.4,
        yoffset = 0.9
      }
    }
    nnoremap('<Leader>fg', ':GFiles<cr>', { silent = true })
    nnoremap('<Leader>ff', ':Files<cr>', { silent = true })
    nnoremap('<Leader>fb', ':Buffers<cr>', { silent = true })
    nnoremap('<Leader>ft', ':Tags<cr>', { silent = true })

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
  init = with_module('nvim-treesitter.configs', function(configs)
    configs.setup {
      highlight = {
        enable = true
      }
    }
  end)
}
use 'nvim-treesitter/playground'

use {
  'neovim/nvim-lspconfig',
  init = with_module('lspconfig', function(lspconfig)
    lspconfig.gopls.setup {
      cmd = { '/home/bigfix/go/bin/gopls' }
    }
  end)
}

-- plugin to bundle all nvim settings for work
local_use 'bigfixdev.nvim'

packer_define_default_commands()
