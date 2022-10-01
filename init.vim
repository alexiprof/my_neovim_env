call plug#begin(stdpath('data').'/plugged')
    Plug 'tpope/vim-fugitive'
    Plug 'vimwiki/vimwiki'
    Plug 'mhinz/vim-rfc'
    Plug 'neovim/nvim-lspconfig'
	Plug 'hrsh7th/nvim-cmp'
	Plug 'hrsh7th/cmp-nvim-lsp'
	Plug 'saadparwaiz1/cmp_luasnip'
	Plug 'L3MON4D3/LuaSnip'
	Plug 'morhetz/gruvbox'
	Plug 'hsanson/vim-openapi'
	Plug 'alfredodeza/pytest.vim'
	Plug 'derekwyatt/vim-fswitch'
	Plug 'dense-analysis/ale'
	Plug 'majutsushi/tagbar'
	Plug 'jlanzarotta/bufexplorer'
	Plug 'scrooloose/nerdtree'
call plug#end()

let mapleader=","


set nocompatible

colorscheme gruvbox


let g:gruvbox_hls_cursor = 'bg0_h'

filetype plugin indent on   " autodetect file type
syntax on                   " syntax highlighting
scriptencoding utf-8
set encoding=utf-8
set termencoding=utf-8
set noswapfile                  " disable swap files
set autochdir                   " auto change current directory to file directory
set hidden                      " Allow buffer switching without saving
set history=1000
set number
set relativenumber

set tabpagemax=15               " Only show 15 tabs
set showtabline=2

set cursorline                  " Highlight current line

highlight clear SignColumn      " SignColumn should match background
highlight clear LineNr          " Current line number row will have same
                                " background color in relative mode
set laststatus=2                " always display statusline
set statusline=%<%n\ %F\ %m\ %r\ %y\ 0x%B,%b%=%l:%c\ %P

set backspace=indent,eol,start  " Backspace for dummies
set linespace=0                 " No extra spaces between rows
set showmatch                   " Show matching brackets/parenthesis
set incsearch                   " Find as you type search
set hlsearch                    " Highlight search terms
set winminheight=0              " Windows can be 0 line high
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then
                                " longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
set colorcolumn=81              " higlight column 81
set list!
set listchars=tab:·\ ,trail:.   " Highlight problematic whitespace
set fillchars+=vert:\ 
set vb t_vb=                    " No more beeps
set lazyredraw
set nofoldenable
set linebreak

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

set autoindent                  " Indent at the same level of the previous line
set shiftwidth=4                " Use indents of 4 spaces
set tabstop=4                   " An indentation every four columns
set softtabstop=4               " Let backspace delete indent
set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow                  " Puts new split windows to the bottom of the current

noremap <leader>hl :nohl<CR>
nmap j gj
nmap k gk

tnoremap <Esc> <C-\><C-n>

" Set C++ editing options
autocmd FileType cpp setlocal shiftwidth=0 tabstop=2 expandtab


"let g:vimwiki_list = [
"\ {
"\	'path': '$HOME/Yandex.Disk.localized/vimwiki',
"\	'path_html': '$HOME/Yandex.Disk.localized/vimwiki/wiki_html',
"\ }
"\ ]

let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_ext = '.md'
let g:vimwiki_syntax = 'markdown'
let g:vimwiki_global_ext = 0

vnoremap <C-c> :w !pbcopy<CR><CR> 

noremap <C-v> :r !pbpaste<CR><CR>

noremap <C-t> :Vexplore<CR><CR>

let g:netrw_banner = 0
"let g:netrw_liststyle = 3
"let g:netrw_browse_split = 4
"let g:netrw_altv = 0
""let g:netrw_winsize = 25
"augroup ProjectDrawer
"  autocmd!
"  autocmd VimEnter * :Vexplore
"augroup END


"" lsp
"let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
""set completeopt=menuone,noinsert,noselect


lua << EOF

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.server_capabilities.document_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.server_capabilities.document_range_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

-- Use a loop to conveniently both setup defined servers 
-- and map buffer local keybindings when the language server attaches
--local servers = { "pyright", "gopls", "rls" }
--for _, lsp in ipairs(servers) do
---  nvim_lsp[lsp].setup { on_attach = on_attach }
--end

-- clang setup
nvim_lsp.clangd.setup {
    cmd = { "clangd", "--background-index", "--clang-tidy", "-j=4" },
    on_attach = on_attach,
	capabilities = capabilities,
}

-- cmake-language-server
nvim_lsp.cmake.setup {
    on_attach = on_attach,
    cmd = { "cmake-language-server" },
	capabilities = capabilities,
}

nvim_lsp.pyright.setup = {
	on_attach = on_attach,
    capabilities = capabilities,
}

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
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
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

EOF
