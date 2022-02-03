--- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.cmd [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]]

-- ## Examples for configuration
-- vim.g.mapleader <global var is equivalent to> let g:mapleader
-- vim.o.enconding <global options is equivalent to> set encoding
-- vim.wo if for windows option
-- vim.bo if for buffer options
-- vim.fn.thisIsMyFun or vim.fn.["thisIsMyFun"] and calling it adding ().
-- vim.api is a collection of API functions.
-- vim.api.nvim_set_keymap(mode, keys, mapping, options)
-- mode: is n(normal) = nmap, i(insert) = imap
-- keys: combination of keys
-- mapping: what the keys do
-- options: are a table where you pass aditional settings.

local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager
  use 'tpope/vim-fugitive' -- Git commands in nvim
  use 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github
  use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines
  use 'ludovicchabant/vim-gutentags' -- Automatic tags management
  -- UI to select things (files, grep results, open buffers...)
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use 'mjlbach/onedark.nvim' -- Theme inspired by Atom
  use 'nvim-lualine/lualine.nvim' -- Fancier statusline
  -- Add indentation guides even on blank lines
  use 'lukas-reineke/indent-blankline.nvim'
  -- Add git related info in the signs columns and popups
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use 'nvim-treesitter/nvim-treesitter'
  -- Additional textobjects for treesitter
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
  use 'williamboman/nvim-lsp-installer' -- To isntall lsp servers using :LspInstall
  use {'tzachar/cmp-tabnine', run='./install.sh', requires = 'hrsh7th/nvim-cmp'} -- added by me coder
  use 'onsails/lspkind-nvim' -- added by me coder, to get some pictograms requiere change font of terminal.
  use 'windwp/nvim-autopairs' -- added by me coder to get auto close pairs
  use 'morhetz/gruvbox' -- added by me coder to get color schemes
  use 'EdenEast/nightfox.nvim' -- added by me coder to get some color schemes
  use 'aca/emmet-ls' -- added by me coder to get emmet working
  use 'ray-x/lsp_signature.nvim' -- added by me to see where you are inside parameters.
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for" file icon
    },
    config = function() require'nvim-tree'.setup {} end
  }
  use 'BurntSushi/ripgrep' -- added by me reading requirement from telescope.
  use 'mbbill/undotree' -- added by me
  use 'hrsh7th/cmp-buffer' -- added by me
  use 'ray-x/cmp-treesitter' --added by me to completion from treesitter source.
  use 'hrsh7th/cmp-nvim-lua' --added by me to completion from nvim_lua source
  use 'hrsh7th/cmp-path' -- added by me to completion from path source cmp
  use 'hrsh7th/cmp-calc' -- added by me to source cmp math calculation.
  use 'hrsh7th/cmp-emoji' -- added by me to source cmp emoji completion
  use 'kamykn/spelunker.vim' -- to check spell.
end)

--Set languages.
vim.o.spelllang='en,es'

--Set highlight on search
vim.o.hlsearch = false

--Make line numbers default
vim.wo.number = true

--Make relative nunmbers by me coder
vim.wo.relativenumber = true

--Enable mouse mode
vim.o.mouse = 'a'

--Enable break indent
vim.o.breakindent = true

--Save undo history
vim.opt.undofile = true

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set invert selection to avoid several colors select in visual mode.
vim.g.gruvbox_invert_selection = false
--Set colorscheme (onedark, gruvbox, nightfox)
vim.o.termguicolors = true
vim.cmd [[ colorscheme gruvbox ]]

-- Set completeopt to have a better completion experience 'menuone,noselect'
vim.o.completeopt = 'menuone,noselect'
-- vim.o.pumheight = 8 --popup menu height

--Added by me coder to have the cursor in a cross line and blinking.
--vim.o.cursorline = true
--vim.o.cursorcolumn = true

-- some options related to tab
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- by me
vim.o.splitright = true
vim.o.splitbelow = true

-- no wrap lines when small window width.
vim.wo.wrap = false

-- local variable
local _o = { noremap = true, silent = true }

--Set statusbar
require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'gruvbox',
    component_separators = '|',
    section_separators = '',
  },
}

--Enable Comment.nvim
require('Comment').setup()

--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', _o)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--Remap for dealing with word wrap. why is this code here, seems it does not work.
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true})
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true})

-- Highlight on yank
vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]

--Map blankline
vim.g.indent_blankline_char = '┊'
vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
vim.g.indent_blankline_show_trailing_blankline_indent = false

-- Gitsigns
require('gitsigns').setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
}

--gutentags added by me
--vim.g.gutentags_ctags_exclude = {'/node_modules/*'}

-- Telescope
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
    file_ignore_patterns = {'node_modules'},
     -- added by me to ignore search of tags in node_modules
  },
}

-- Enable telescope fzf native
require('telescope').load_extension 'fzf'

--Add leader shortcuts
vim.api.nvim_set_keymap('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], _o)
vim.api.nvim_set_keymap('n', '<leader>sf', [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]], _o)
vim.api.nvim_set_keymap('n', '<leader>sb', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], _o)
vim.api.nvim_set_keymap('n', '<leader>sh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], _o)
vim.api.nvim_set_keymap('n', '<leader>st', [[<cmd>lua require('telescope.builtin').tags()<CR>]], _o)
vim.api.nvim_set_keymap('n', '<leader>ss', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], _o)
vim.api.nvim_set_keymap('n', '<leader>sl', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], _o)
vim.api.nvim_set_keymap('n', '<leader>sc', [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]], _o)
vim.api.nvim_set_keymap('n', '<leader>?', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], _o)
vim.api.nvim_set_keymap('n', '<leader>sg', [[<cmd>lua require('telescope.builtin').git_files()<CR>]], _o) --by me coder

-- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'grc',
      node_decremental = 'grm',
    },
  },
  indent = {
    enable = true,
    --disable = {'javascript'}
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
}

-- LSP-INSTALLER
local lsp_installer = require('nvim-lsp-installer')
-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
    local opts = {}

    -- (optional) Customize the options passed to the server
    -- if server.name == "tsserver" then
    --     opts.root_dir = function() ... end
    -- end

    -- if server.name == 'html' then
    --   opts = { capabilities = capabilities }
    -- end

    if server.name == 'sumneko_lua' then
    opts = {
      settings = {
        Lua = {
          diagnostics = {
            globals = {'vim'}
          },
        }
      }
    }
    end

    -- This setup() function is exactly the same as lspconfig's setup function.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(opts)
end)


-- ## LSP-CONFIG
-- Mapping, see `:help vim.diagnostic.*` for documentation.
vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', _o)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', _o)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', _o)
vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', _o)

-- Use an on_attach function to only map the following tbl_keys
-- after the language server attaches to the current buffer.
local on_attach = function(_, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  --Mappings, see`:help vim.lsp.*` for documentation of any of the below functions.
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', _o)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', _o)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', _o)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', _o)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', _o)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', _o)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', _o)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', _o)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', _o)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', _o)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', _o)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', _o)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', _o) -- added as original code
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], _o) -- why is here?
  -- vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]] -- did not find why.
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver', 'sumneko_lua', 'html', 'eslint', 'cssls'}
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    },
    -- capabilities = capabilities, --testing if it is needed.
  }
end

-- ## LSP-CONFIG tsserver error handler.
-- require('lspconfig').typescript.setup({
--   handlers = {
--     ["textDocument/publishDiagnostics"] = function(_, _, params, client_id, _, config)
--       if params.diagnostics ~= nil then
--         local idx = 1
--         while idx <= #params.diagnostics do
--           if params.diagnostics[idx].code == 80001 then
--             table.remove(params.diagnostics, idx)
--           else
--             idx = idx + 1
--           end
--         end
--       end
--       vim.lsp.diagnostic.on_publish_diagnostics(_, _, params, client_id, _, config)
--     end,
--   },
-- })

-- ## TSSERVER config to avoid display somme errors in javascript.
require('lspconfig').tsserver.setup({
  handlers = {
    ["textDocument/publishDiagnostics"] = function(_, params, client_id, config) -- fixed by antonella coder
    -- List of errors  https://github.com/microsoft/TypeScript/blob/main/src/compiler/diagnosticMessages.json
        local ignore_codes = { 80001, 6133 }; -- others, see list above: {80001, 7016, 6133}
        if params.diagnostics ~= nil then
          local idx = 1
          while idx <= #params.diagnostics do
            if vim.tbl_contains(ignore_codes, params.diagnostics[idx].code) then
              table.remove(params.diagnostics, idx)
            else
              idx = idx + 1
            end
          end
        end
        vim.lsp.diagnostic.on_publish_diagnostics(_, params, client_id, config) -- fixed my antonella coder
      end,
  },
})

-- Example custom server
-- Make runtime files discoverable to the server
-- local runtime_path = vim.split(package.path, ';')
-- table.insert(runtime_path, 'lua/?.lua')
-- table.insert(runtime_path, 'lua/?/init.lua')
--
-- lspconfig.sumneko_lua.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   settings = {
--     Lua = {
--       runtime = {
--         -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
--         version = 'LuaJIT',
--         -- Setup your lua path
--         path = runtime_path,
--       },
--       diagnostics = {
--         -- Get the language server to recognize the `vim` global
--         globals = { 'vim' },
--       },
--       workspace = {
--         -- Make the server aware of Neovim runtime files
--         library = vim.api.nvim_get_runtime_file('', true),
--       },
--       -- Do not send telemetry data containing a randomized but unique identifier
--       telemetry = {
--         enable = false,
--       },
--     },
--   },
-- }

-- tabnine setup (it was enable with name = 'cmp_tabnine' in sources.
local tabnine = require('cmp_tabnine.config')
tabnine:setup({
	max_lines = 1000;
	max_num_results = 20;
	sort = true;
	run_on_every_keystroke = true;
	snippet_placeholder = '..';
	ignored_file_types = { -- default is not to ignore
		-- uncomment to ignore in lua:
		-- lua = true
	};
})

-- luasnip setup
local luasnip = require('luasnip')

-- lspkind
--local lspkind = require('lspkind')

local source_mapping = {
	nvim_lsp = "[LSP]",
	nvim_lua = "[Lua]",
	buffer = "[Buffer]",
  luasnip = "[LuaSnip]",
	path = "[Path]",
	cmp_tabnine = "[TN]",
  calc = "[calc]",
  emoji = "[emoji]",
  treesitter = "[TSitter]",
  crates = "[crates]",
}

-- compare to rank tab nine
local compare = require('cmp.config.compare')

-- ## luasnip
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- nvim-cmp setup
local cmp = require('cmp')

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  experimental = {ghost_text = true, native_menu = false},
  documentation = {
    border = {"╭", "─", "╮", "│", "╯", "─", "╰", "│"}
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    -- ['<Tab>'] = function(fallback)
    --   if cmp.visible() then
    --     cmp.select_next_item()
    --   elseif luasnip.expand_or_jumpable() then
    --     luasnip.expand_or_jump()
    --   else
    --     fallback()
    --   end
    -- end,
    -- ['<S-Tab>'] = function(fallback)
    --   if cmp.visible() then
    --     cmp.select_prev_item()
    --   elseif luasnip.jumpable(-1) then
    --     luasnip.jump(-1)
    --   else
    --     fallback()
    --   end
    -- end,

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }), -- added from nvim-vmp luasnip example

  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'nvim_lua'},
    { name = 'buffer'},
    { name = 'luasnip' },
    { name = 'path'}, -- added by me
    { name = 'cmp_tabnine'}, -- line added by me, needed.
    { name = 'calc'}, -- added by me
    { name = 'emoji'}, -- added by me
    { name = 'treesitter'}, -- added by me
    { name = 'crates'},
    },-- added by me
  option = {
        get_bufnrs = function()
          local bufs = {}
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            bufs[vim.api.nvim_win_get_buf(win)] = true
          end
          return vim.tbl_keys(bufs)
        end
    }, -- block added by me
	formatting = {
		format = function(entry, vim_item)
			--vim_item.kind = lspkind.presets.default[vim_item.kind]
			local menu = source_mapping[entry.source.name]
			if entry.source.name == 'cmp_tabnine' then
				if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
					menu = entry.completion_item.data.detail .. ' ' .. menu
				end
				vim_item.kind = ''
			end
			vim_item.menu = menu
			return vim_item
		end
	},
  sorting = {
    priority_weight = 2,
    comparators = {
      require('cmp_tabnine.compare'),
      compare.offset,
      compare.exact,
      compare.score,
      compare.recently_used,
      compare.kind,
      compare.sort_text,
      compare.length,
      compare.order,
    },
  },

})

-- nvim-autopairs
require('nvim-autopairs').setup{}

-- lsp signatures
require('lsp_signature').setup()

-- nvim-tree
--vim.cmd('let g:nvim_tree_highlight_opened_files = 1') -- line not working, it is changing icon's colors
--require('nvim-tree').setup{} -- line not working, it is changing icon's colors
vim.cmd('nnoremap <leader>n :NvimTreeToggle<CR>')
vim.cmd('nnoremap <leader>r :NvimTreeRefresh<CR>')
-- vim.cmd('nnoremap <leader>f :NvimTreeFindFile<CR>') --conflict  with keybinding.

-- undotree
vim.cmd('nnoremap <leader>u :UndotreeToggle<CR>')

-- old files shortcut to navigation
vim.cmd('nnoremap <leader>h :wincmd h<CR>')
vim.cmd('nnoremap <leader>j :wincmd j<CR>')
vim.cmd('nnoremap <leader>k :wincmd k<CR>')
vim.cmd('nnoremap <leader>l :wincmd l<CR>')

-- Keep cursor in center while you go to next search.
vim.cmd('nnoremap n nzzzv')
vim.cmd('nnoremap N Nzzzv')

-- keep cursor while you concatenate.
vim.cmd('nnoremap J mzJ`z')

-- undo breakpoints to undo by parts.
vim.cmd('inoremap , ,<c-g>u')
vim.cmd('inoremap . .<c-g>u')
vim.cmd('inoremap ! !<c-g>u')
vim.cmd('inoremap ? ?<c-g>u')

-- ## Moving text in visual mode.
vim.cmd("vnoremap J :m '>+1<CR>gv=gv")
vim.cmd("vnoremap K :m '<-2<CR>gv=gv")

-- Moving text in insert mode.
vim.cmd("inoremap <C-j> <esc>:m .+1<CR>==")
vim.cmd("inoremap <C-k> <esc>:m .-2<CR>==")

-- Moving text in normal mode.(if put j conflict with window move up and down)
vim.cmd('nnoremap <leader>J :m.+1<CR>==')
vim.cmd('nnoremap <leader>K :m.-2<CR>==')

-- Paste overwriting a text, it works on visual mode.
vim.cmd('xnoremap <leader>p "_dP')

-- Adding a new line on visual mode
vim.cmd('nnoremap <leader>o :<C-u>call append(line("."),repeat([""],v:count1))<CR>')

--vim.opt.autoindent = true
-- vim: ts=2 sts=2 sw=2 et
