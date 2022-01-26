
let mapleader = ","

" Keybindings, mappings etc

" For quick file reloading, TODO: Remove once configured? 'source vimrc'
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>ee :e! ~/.vimrc<CR>

noremap <leader>f :Files<CR>

nmap <leader>w :w<CR>

" nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>

" set background=dark


" Vim Plug plugins
call plug#begin()

" Switch to a git root directory in vim if editing a tracked file
Plug 'airblade/vim-rooter'
Plug 'itchyny/lightline.vim'

" Color helper
Plug 'norcalli/nvim-colorizer.lua'

" Async linter
Plug 'w0rp/ale'

" get dat fuzzy finder yo
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" rls integration
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" nvim completion manager
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-racer'
Plug 'ncm2/ncm2-path'

Plug 'rust-lang/rust.vim'

" Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
Plug 'lervag/vimtex'
" Plug 'vim-pandoc/vim-pandoc'
" Plug 'vim-pandoc/vim-pandoc-syntax'

call plug#end()

" Settings

set ruler " not sure what this does
set relativenumber
set autoindent
set autoread
set smarttab
set expandtab
set shiftwidth=4
set tabstop=4
set encoding=utf-8
set hidden
set scrolloff=2

" permanent undo
set undodir=~/.vimdid
set undofile

syntax enable
filetype plugin indent on

" Color helpers
set termguicolors
lua require'colorizer'.setup()

" ncm2
autocmd BufEnter * call ncm2#enable_for_buffer()

set completeopt=noinsert,menuone,noselect

" suppress the annoying 'match x of y', 'The only match' and 'Pattern not found' messages
set shortmess+=c

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>

" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and select the item.
inoremap <expr> <CR> (pumvisible() ? "\<c-y>" : "\<CR>")

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Python
let g:python3_host_prog= '/usr/bin/python'

let g:rust_clip_command = 'xclip -selection clipboard'

let g:rustfmt_autosave = 1

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'tex': ['latexindent', 'textlint'],
\}

let g:ale_fix_on_save = 1

" Language Server
let g:LanguageClient_serverCommands = {
	\ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls']
\ }

" VimTeX
let g:vimtex_view_method = 'mupdf'
let g:vimtex_view_use_temp_files = 1

let g:vimtex_compiler_latexmk = {
    \ 'build_dir' : '.build',
    \ 'callback' : 1,
    \ 'continuous' : 1,
    \ 'executable' : 'latexmk',
    \ 'hooks' : [],
    \ 'options' : [
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ],
    \}

nmap <F5> <Plug>(lcn-menu)
" quickly swap between 2 files
nmap <leader>, <c-^><CR>

" Rust stuffs
nmap <leader>cr :Crun<CR>

" FZF stuffs
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)
