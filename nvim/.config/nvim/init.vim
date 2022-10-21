call plug#begin('~/.config/nvim/plugged')
Plug 'sbdchd/neoformat'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'kabouzeid/nvim-lspinstall'
Plug 'hrsh7th/nvim-compe'
Plug 'altercation/vim-colors-solarized'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'francoiscabrol/ranger.vim'
call plug#end()

" Misc
set mouse=a
set cmdheight=2 " more info in cmd line for quick fix
set number " line numbers
set hidden " Allow unsaved buffers in background
set cursorline " Highlight current line


" Line numbers
"set number relativenumber

"augroup numbertoggle
"autocmd!
"autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
"autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
"augroup END
" Line

" Color
" let g:solarized_termcolors=256
set background=dark
colorscheme solarized

" Basic keys
nnoremap ; :| " map the ; to do the same as pressing SHIFT+;
let mapleader="," " map leader from \ to ,

" temp files
set nobackup " don't write backup files since I use git
set nowb " don't write backup files since I use git
set noswapfile " dont write swap files

" Search
set ignorecase " ignore case when searching
set smartcase " only use case if not all lower case in search
nmap <silent> ,/ :nohlsearch<CR>| " disable highlighting easily

" FZF
command! -bang Directories call fzf#run({'source': 'fd -H -t d -d 3', 'sink': 'cd', 'options': ['--preview', 'exa --color=always {}']})
let g:fzf_buffers_jump = 1 " Jump current window if open TODO
nnoremap <C-b> :Buffers<CR>
nnoremap <C-t> :Files<CR>
nnoremap <C-y> :Directories<CR>
nnoremap <C-f> :Rg 

" source for dictionary, current or other loaded buffers, see ':help cpt'
set cpt=.,k,w,b

" don't select the first item.
set completeopt=menu,menuone,noselect

" suppress annoy messages.
set shortmess+=I

set signcolumn=yes


"""" Terminal """"
nnoremap <leader>t :terminal<CR>
augroup neovim_terminal
autocmd!
autocmd TermEnter * :setlocal nonumber norelativenumber
autocmd TermOpen * :setlocal nonumber norelativenumber
autocmd TermOpen * :setlocal signcolumn=no
autocmd TermClose * :setlocal number norelativenumber
autocmd TermClose * :setlocal signcolumn=yes
autocmd TermOpen * startinsert
augroup END

" Maps ESC to exit terminal's insert mode
tnoremap <Esc> <C-\><C-n>

nnoremap <leader>r :Neoformat<CR>

"""NAVIGATION"""
" Use ctrl-[hjkl] to select the active split
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>
nmap <silent> <c-w>j :split<CR>
nmap <silent> <c-w>k :split<CR>
nmap <silent> <c-w>h :vsplit<CR>
nmap <silent> <c-w>l :vsplit<CR>

" Scroll page
nnoremap K <C-B> " page up
nnoremap J <C-F> " page down

nnoremap <leader>w/ :cd /<CR>
nnoremap <leader>w. :cd.. <CR>
nnoremap <leader>wc :cd 
nnoremap <leader>wH :cd /Users/pvilim/hacks/pvilim<CR>
nnoremap <leader>wh :cd /Users/pvilim/<CR>
nnoremap <leader>wd :cd /Users/pvilim/client/desktop<CR>
nnoremap <leader>wr :cd /Users/pvilim/client/desktop/rust/<CR>
nnoremap <leader>wn :cd /Users/pvilim/client/desktop/rust/nucleus<CR>
nnoremap <leader>ws :cd /Users/pvilim/server<CR>
nnoremap <leader>wg :cd /Users/pvilim/server/go/src<CR>
nnoremap <leader>wp :cd /Users/pvilim/server/configs/proto<CR>
nnoremap <leader>wm :cd /Users/pvilim/server/metaserver/metaservlets<CR>
nnoremap <leader>wi :cd /Users/pvilim/server/go/src/dropbox/devtools/image_builder<CR>
nnoremap <leader>wj :cd /Users/pvilim/server/metaserver/static/js/<CR>


" Return the root directory of the project that contains 'filename'. The root
" is detected by the presence of a file or directory named as the passed
" parameter 'project_marker'
function! GetProjectRoot(filename, project_marker)
  let path = fnamemodify(a:filename, ':p:h')
  let prev_path = ''
  while path !=# prev_path
    let marker_path = path . '/' . a:project_marker
    let type = getftype(marker_path)
    if type != ''
      return path
    endif
    let prev_path = path
    let path = fnamemodify(path, ':h')
  endwhile
  return ''
endfunction

" Return the name of the current file relative to the project root
function! GetNameRelativeToProjectRoot()
    let current_filename = expand('%:p')
    let project_marker = '.git'
    let project_dir = GetProjectRoot(current_filename, project_marker)
    if project_dir != ''
        let name = current_filename[len(project_dir) + 1:]
    else
        let name = expand('%:.')
    endif
    return get(b:,"term_title", name)
endfunction

" retrieve the LSP status so that we can show it in the lightline
function! LspStatus() abort
  if has("nvim-0.5") && luaeval("not vim.tbl_isempty(vim.lsp.buf_get_clients(0))")
    let l:msg = luaeval("require('lsp-status').status()")
    " lsp-status seems to double encode the % signs so fix that here
    let l:msg = substitute(l:msg, "%%", "%", "")
    " make sure that we don't overflow the line towards the left
    return l:msg[0:(winwidth(0) - 70)]
  else
    return ""
  endif
endfunction

" Share system and nvim clipboard
" On linux install xclip for clipboard support
set clipboard=unnamedplus

" lightline
set noshowmode " Not needed since in status line
let g:lightline = {
    \ 'colorscheme': 'solarized',
    \ 'tabline': {
    \   'left': [
    \             [ 'pwd', 'filename' ] ],
    \   'right': [[] ],
    \ },
    \ 'inactive': {
    \   'left': [
    \             [ 'readonly', 'filename', 'modified' ] ],
    \   'right': [ [ 'linenumber' ] ],
    \ },
    \ 'active': {
    \   'left': [
    \             [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'gutter' ],
    \             [ 'lsp_status' ],
    \             [ 'readonly', 'modified', 'filename'],
    \		  ],
    \   'right': [ [ 'linenumber' ] ],
    \ },
    \ 'component': {
\   'linenumber': '%l/%L:%c',
    \ },
    \ 'component_function': {
    \   'gitbranch': 'FugitiveHead',
    \   'gutter': 'HunkSummary',
    \   'pwd': 'getcwd',
    \   'filename': 'GetNameRelativeToProjectRoot',
    \   'lsp_status': 'LspStatus',
    \ },
    \ }
set showtabline=2 " always show tabline

"treesitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",     -- one of "all", "language", or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = {"node" },  -- list of language that will be disabled
  },
}

local nvim_lsp = require("lspconfig")
local lsp_status = require("lsp-status")
local function setup_client(name, config)
  -- config.capabilities = vim.tbl_deep_extend("force", lsp_status.capabilities, config.capabilities or {})

  local custom_on_attach = config.on_attach
  config.on_attach = function(client, bufnr)

    local function set_keymap(mode, key, cmd)
      vim.api.nvim_buf_set_keymap(bufnr, mode, key, cmd, { noremap = true, silent = true })
    end
    set_keymap("n", "gd",         "<cmd>lua vim.lsp.buf.definition()<CR>")
    -- set_keymap("n", "gr",         "<cmd>lua vim.lsp.buf.references()<CR>")
    set_keymap("n", "gi",         "<cmd>lua vim.lsp.buf.implementation()<CR>")
    set_keymap("n", "gy",         "<cmd>lua vim.lsp.buf.type_definition()<CR>")
    -- set_keymap("n", "K",          "<cmd>lua vim.lsp.buf.hover()<CR>")
    -- set_keymap("n", "<C-k>",      "<cmd>lua vim.lsp.buf.signature_help()<CR>")
    -- set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
    -- set_keymap("n", "<leader>a",  "<cmd>lua vim.lsp.buf.code_action()<CR>")
    set_keymap("n", "<leader>e",  "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ focusable = false })<CR>")
    -- set_keymap("n", "<leader>q",  "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>")
    set_keymap("n", "<leader>k",         "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>")
    set_keymap("n", "<leader>j",         "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>")

    -- Invoke the custom `on_attach` function for the client, if needed
    if custom_on_attach then
      custom_on_attach(client, bufnr)
    end
  end

  nvim_lsp[name].setup(config)
end

-- setup_client("tsserver" {})

setup_client("rust_analyzer", {
  root_dir = function(fname)
    local cargo_crate_dir = nvim_lsp.util.root_pattern("Cargo.toml")(fname)
    -- Make sure that we run `cargo metadata` in the current project dir
    -- rather that the dir from which nvim was initially launched.
    local cmd = "cargo metadata --no-deps --format-version 1"
    if cargo_crate_dir ~= nil then
      cmd = cmd .. " --manifest-path " .. nvim_lsp.util.path.join(cargo_crate_dir, "Cargo.toml")
    end
    local cargo_metadata = vim.fn.system(cmd)
    local cargo_workspace_dir = nil
    if vim.v.shell_error == 0 then
      cargo_workspace_dir = vim.fn.json_decode(cargo_metadata)["workspace_root"]
    end
    -- Order of preference:
    --   * Current workspace Cargo.toml
    --   * Current crate Cargo.toml
    --   * Rust project root (for non Cargo projects)
    --   * Current git repository
    return cargo_workspace_dir or
      cargo_crate_dir or
      nvim_lsp.util.root_pattern("rust-project.json")(fname) or
      nvim_lsp.util.find_git_ancestor(fname)
  end;
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        features = {"quince_tests"};
      };
      checkOnSave = {
        enable = true;
        -- Build out of tree so that we don't cause cargo lock contention
        extraArgs = { "--target-dir", "/tmp/rust-analyzer-check" };
      };
      procMacro = {
        enable = true;
      };
    };
  };
  capabilities = {
    textDocument = {
      completion = {
        completionItem = {
          -- We need snippets for compe to fully support rust-analyzer magic
          snippetSupport = true;
          resolveSupport = {
            properties = {
              "documentation";
              "detail";
              "additionalTextEdits";
            };
          };
        };
      };
    };
  };
})

 local compe = require("compe")

vim.o.completeopt = "menuone,noselect"

compe.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = "enable";
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;
  source = {
    buffer = false;
    path = true;
    nvim_lsp = true;
    nvim_lua = true;
  };
}

local check_back_space = function()
  local col = vim.fn.col(".") - 1
  if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
    return true
  else
    return false
  end
end
-- Use tab to navigate completion menu
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return vim.api.nvim_replace_termcodes("<C-n>", true, true, true)
  elseif check_back_space() then
    return vim.api.nvim_replace_termcodes("<Tab>", true, true, true)
  else
    return vim.fn["compe#complete"]()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return vim.api.nvim_replace_termcodes("<C-p>", true, true, true)
  else
    return vim.api.nvim_replace_termcodes("<S-Tab>", true, true, true)
  end
end
vim.api.nvim_set_keymap("i", "<C-j>", "v:lua.tab_complete()", { expr = true })
vim.api.nvim_set_keymap("s", "<C-j>", "v:lua.tab_complete()", { expr = true })
vim.api.nvim_set_keymap("i", "<C-k>", "v:lua.s_tab_complete()", { expr = true })
vim.api.nvim_set_keymap("s", "<C-k>", "v:lua.s_tab_complete()", { expr = true })

-- To confirm completion, specifically useful for snippets
vim.api.nvim_set_keymap("i", "<C-l>", "compe#confirm({ 'keys': '<CR>', 'select': v:true })", { expr = true })

-- To close the completion menu without making a selection
vim.api.nvim_set_keymap("i", "<C-h>", "compe#close({ 'keys': '<ESC>', 'select': v:true })", { expr = true })
EOF

if has('nvim')
  let $GIT_EDITOR = 'nvr -cc split --remote-wait'
endif
autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete


source ~/.config/nvim/layout.vim
source ~/.config/nvim/terminal.vim
nnoremap <leader>q :source ~/.config/nvim/terminal.vim<CR>
