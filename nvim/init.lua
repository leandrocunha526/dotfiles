-- Configuração do gerenciador de plugins
vim.cmd([[
  call plug#begin()
]])
vim.fn['plug#']('joshdick/onedark.vim')
vim.fn['plug#']('preservim/nerdtree')
vim.fn['plug#']('ryanoasis/vim-devicons')
vim.fn['plug#']('Xuyuanp/nerdtree-git-plugin')
vim.fn['plug#']('sheerun/vim-polyglot')
vim.fn['plug#']('jiangmiao/auto-pairs')
vim.fn['plug#']('ap/vim-css-color')
vim.fn['plug#']('kien/ctrlp.vim')
vim.fn['plug#']('plasticboy/vim-markdown')
vim.fn['plug#']('airblade/vim-gitgutter')
vim.fn['plug#']('junegunn/fzf', { dir = '~/.fzf', ['do'] = './install --all' })
vim.fn['plug#']('junegunn/fzf.vim')
vim.fn['plug#']('dense-analysis/ale')
vim.fn['plug#']('neoclide/coc.nvim', { branch = 'release' })
vim.fn['plug#']('davidhalter/jedi-vim')
vim.fn['plug#']('neovim/nvim-lspconfig')
vim.fn['plug#']('williamboman/mason.nvim')
vim.fn['plug#']('williamboman/mason-lspconfig.nvim')
vim.fn['plug#']('hrsh7th/nvim-cmp')
vim.fn['plug#']('hrsh7th/cmp-nvim-lsp')
vim.fn['plug#']('rafamadriz/friendly-snippets')
vim.cmd([[
  call plug#end()
]])

-- Configuração geral
vim.cmd('colorscheme onedark')
vim.o.guifont = 'DejaVuSansMono Nerd Font 11'
vim.o.encoding = 'UTF-8'
vim.cmd('filetype indent on')
vim.cmd('filetype plugin on')
vim.cmd('filetype on')
vim.cmd('syntax on')
vim.o.number = true

-- Configuração do Airline
vim.g.airline_powerline_fonts = 1
vim.g['airline#extensions#tabline#enabled'] = 1

-- Configuração do NERDTree
vim.g.NERDTreeShowHidden = 1
vim.g.NERDTreeMinimalUI = 1
vim.g.NERDTreeDirArrows = 1
vim.g.NERDTreeIgnore = {}
vim.g.NERDTreeStatusline = ''

-- Mapeamentos
vim.api.nvim_set_keymap('n', '<leader>n', ':NERDTreeFocus<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-n>', ':NERDTree<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-t>', ':NERDTreeToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-f>', ':NERDTreeFind<CR>', { noremap = true, silent = true })

-- Configuração do ALE
vim.g.ale_fixers = { 'prettier', 'eslint' }
vim.g.ale_echo_msg_error_str = 'E'
vim.g.ale_echo_msg_warning_str = 'W'
vim.g.ale_echo_msg_format = '[%linter%] %s [%severity%]'
vim.g.ale_sign_error = '✘'
vim.g.ale_sign_warning = '⚠'

-- Configuração do Coc.nvim
vim.g.coc_global_extensions = {
  'coc-snippets',
  'coc-emmet',
  'coc-html',
  'coc-css',
  'coc-json',
  'coc-phpls',
  'coc-yaml',
  'coc-prettier',
  'coc-eslint'
}

vim.api.nvim_exec([[
function! ShowDocumentation()
  " Verifique se há clientes LSP ativos
  if luaeval('#vim.lsp.buf_get_clients() > 0')
    lua vim.lsp.buf.hover()
  else
    " Abra o :help como fallback
    let l:word = expand('<cword>') " Palavra sob o cursor
    execute 'help ' . l:word
  endif
endfunction
]], false)

-- Mapear a tecla '<C-k>' para chamar a função
vim.api.nvim_set_keymap('n', '<C-k>', ':call ShowDocumentation()<CR>', { noremap = true, silent = true })

-- Terminal
vim.cmd([[
function! OpenTerminal()
  split term://bash
  resize 10
endfunction
]])
vim.api.nvim_set_keymap('n', '<C-j>', ':call OpenTerminal()<CR>', { noremap = true, silent = true })

-- Navegação entre splits
local keymap_opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('t', '<A-h>', '<C-\\><C-n><C-w>h', keymap_opts)
vim.api.nvim_set_keymap('t', '<A-j>', '<C-\\><C-n><C-w>j', keymap_opts)
vim.api.nvim_set_keymap('t', '<A-k>', '<C-\\><C-n><C-w>k', keymap_opts)
vim.api.nvim_set_keymap('t', '<A-l>', '<C-\\><C-n><C-w>l', keymap_opts)
vim.api.nvim_set_keymap('n', '<A-h>', '<C-w>h', keymap_opts)
vim.api.nvim_set_keymap('n', '<A-j>', '<C-w>j', keymap_opts)
vim.api.nvim_set_keymap('n', '<A-k>', '<C-w>k', keymap_opts)
vim.api.nvim_set_keymap('n', '<A-l>', '<C-w>l', keymap_opts)

-- Configuração do NERDTree-git-plugin
vim.g.NERDTreeGitStatusIndicator = {
  Modified  = '✹',
  Staged    = '✚',
  Untracked = '✭',
  Renamed   = '➜',
  Unmerged  = '═',
  Deleted   = '✖',
  Dirty     = '✗',
  Clean     = '✔︎',
  Ignored   = '☒',
  Unknown   = '?'
}

-- Configurações adicionais
vim.o.list = true
vim.o.listchars = 'tab:>\\ ,trail:-,nbsp:+,eol:$'
vim.g.mapleader = ' '
vim.api.nvim_set_keymap('n', '<leader>sv', ':source ~/.config/nvim/init.lua<CR>', { noremap = true, silent = true })

-- Configurar Mason
require("mason").setup()

-- Configurar integração Mason-LSP
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "pyright", "clangd", "solargraph", "perlnavigator" },
    automatic_installation = true,
})

-- Configurar nvim-lspconfig
local lspconfig = require("lspconfig")

-- Configuração do servidor Lua (lua_ls como exemplo)
lspconfig.lua_ls.setup({
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" }, -- Evitar erros para `vim`
            },
        },
    },
})

-- Configuração do servidor Python (pyright como exemplo)
lspconfig.pyright.setup({})

-- Função para configurar atalhos após o LSP ser anexado
local on_attach = function(_, bufnr)
    local opts = { noremap = true, silent = true }

    -- Mapear teclas para funcionalidades do LSP
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
end

lspconfig.pyright.setup({
    on_attach = on_attach,
})

-- Importar o nvim-cmp
local cmp = require('cmp')

cmp.setup({
    snippet = {
        -- Configuração para snippets (usando LuaSnip)
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = {
        -- Configurar atalhos para navegação
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Confirmar com Enter
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },  -- Fonte do LSP
        { name = 'luasnip' },  -- Fonte de snippets
    }, {
        { name = 'buffer' },   -- Sugestões baseadas no buffer atual
        { name = 'path' },     -- Sugestões de caminho
    }),
})

-- Configuração para o autocompletar em modo de linha de comando
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'path' },
        { name = 'cmdline' },
    },
})

-- Configuração para integrar nvim-cmp com LSP
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Configurar o LSP com as capacidades estendidas
local lspconfig = require('lspconfig')
