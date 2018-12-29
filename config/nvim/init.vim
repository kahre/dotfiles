let plugDir="~/.local/share/nvim/plugged"

call plug#begin(plugDir)


" Usage
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-eunuch'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --rust-completer --go-completer --java-completer' }

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Lint
Plug 'w0rp/ale'

" Interface
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"" Colorschemes
Plug 'KKPMW/sacredforest-vim' 
Plug 'flazz/vim-colorschemes'

Plug 'octol/vim-cpp-enhanced-highlight'

call plug#end()

"autocmd vimenter * NERDTree

let g:ctrlp_working_path_mode = 'ra'
let g:ycm_autoclose_preview_window_after_insertion=1

let mapleader = "\<Space>"
nnoremap <leader>fed :vnew ~/.config/nvim/init.vim<enter>
"nnoremap <leader><leader> :update<enter>
nnoremap <leader>qq :qa<enter>
nnoremap <C-X>k :q<enter>
nnoremap <C-F> :CtrlP<enter>

" Snippets
let g:UltiSnipsSnippetDir=plugDir.'/vim_snippets/UltiSnips'

" Ale
nnoremap <C-A-L> :ALEFix<enter>
let g:ale_c_parse_compile_commands=1
let g:airline#extensions#ale#enabled=1
let g:ale_linters={
\   'cpp': ['clangtidy'],
\}
let g:ale_fixers={
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'cpp': ['clang-format'],
\}

" Move
nnoremap <C-h> <c-w>h
nnoremap <C-j> <c-w>j
nnoremap <C-k> <c-w>k
nnoremap <C-l> <c-w>l

" Standard stuff
set number
set expandtab
set tabstop=4
set shiftwidth=4

" Colour scheme stuff
let g:airline_theme = 'bubblegum'
colorscheme sacredforest
