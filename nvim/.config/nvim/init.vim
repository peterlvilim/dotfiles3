call plug#begin('~/.config/nvim/plugged')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'rust-lang/rust.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'nvim-lua/completion-nvim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'nvim-treesitter/nvim-treesitter',
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'
Plug 'Th3Whit3Wolf/one-nvim'
call plug#end()

" Misc
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
autocmd TermOpen * :setlocal nonumber norelativenumber
autocmd TermOpen * :setlocal signcolumn=no
autocmd TermClose * :setlocal number norelativenumber
autocmd TermClose * :setlocal signcolumn=yes
autocmd TermOpen * startinsert
"au BufEnter,BufWinEnter,WinEnter term://* :setlocal signcolumn=no
"au BufEnter,BufWinEnter,WinEnter term://* :setlocal nonumber norelativenumber
"au BufLeave term://* stopinsert
augroup END

" Maps ESC to exit terminal's insert mode
tnoremap <Esc> <C-\><C-n>

" autofmt
"let g:rustfmt_autosave = 1
nnoremap <leader>r :RustFmt<CR>

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
nnoremap <leader>wh :cd /Users/pvilim/<CR>
nnoremap <leader>wc :cd /Users/pvilim/client/desktop<CR>
nnoremap <leader>wr :cd /Users/pvilim/client/desktop/rust/<CR>
nnoremap <leader>wn :cd /Users/pvilim/client/desktop/rust/nucleus<CR>
nnoremap <leader>ws :cd /Users/pvilim/client<CR>


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
        let relative_filename = current_filename[len(project_dir) + 1:]
        return relative_filename
    else
        return expand('%:.')
    endif
endfunction

" Share system and nvim clipboard
set clipboard=unnamedplus

" lightline
set noshowmode " Not needed since in status line
let g:lightline = {
    \ 'colorscheme': 'solarized',
    \ 'tabline': {
    \   'left': [
    \             [ 'pwd', 'filename' ] ],
    \   'right': [['clock'] ],
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
    \ },
    \ }
let g:airline#extensions#tabline#enabled = 1
set showtabline=2 " always show tabline

"treesitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "rust",     -- one of "all", "language", or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { },  -- list of language that will be disabled
  },
}
EOF

lua <<EOF
local function setup_client(name, config)
  config.capabilities = vim.tbl_deep_extend("force", lsp_status.capabilities, config.capabilities or {})

  local custom_on_attach = config.on_attach
  config.on_attach = function(client, bufnr)

    local function set_keymap(mode, key, cmd)
      vim.api.nvim_buf_set_keymap(bufnr, mode, key, cmd, { noremap = true, silent = true })
    end
    set_keymap("n", "gd",         "<cmd>lua vim.lsp.buf.definition()<CR>")
    set_keymap("n", "gr",         "<cmd>lua vim.lsp.buf.references()<CR>")
    set_keymap("n", "gi",         "<cmd>lua vim.lsp.buf.implementation()<CR>")
    set_keymap("n", "gy",         "<cmd>lua vim.lsp.buf.type_definition()<CR>")
    set_keymap("n", "K",          "<cmd>lua vim.lsp.buf.hover()<CR>")
    set_keymap("n", "<C-k>",      "<cmd>lua vim.lsp.buf.signature_help()<CR>")
    set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
    set_keymap("n", "<leader>a",  "<cmd>lua vim.lsp.buf.code_action()<CR>")
    set_keymap("n", "<leader>e",  "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ focusable = false })<CR>")
    set_keymap("n", "<leader>q",  "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>")
    set_keymap("n", "[g",         "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>")
    set_keymap("n", "]g",         "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>")

    -- Invoke the custom `on_attach` function for the client, if needed
    if custom_on_attach then
      custom_on_attach(client, bufnr)
    end
  end

  nvim_lsp[name].setup(config)
end
EOF

imap <tab> <Plug>(completion_smart_tab)
imap <s-tab> <Plug>(completion_smart_s_tab)

source ~/.config/nvim/layout.vim
source ~/.config/nvim/terminal.vim
nnoremap <leader>q :source ~/.config/nvim/terminal.vim<CR>
