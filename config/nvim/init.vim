let plugDir="~/.local/share/nvim/plugged"

call plug#begin(plugDir)

"" General
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-eunuch'
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'danro/rename.vim'

"" Autocompletion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"" Lint
Plug 'w0rp/ale'

"" Interface
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'junegunn/goyo.vim'

"" Colorschemes
Plug 'KKPMW/sacredforest-vim'
Plug 'flazz/vim-colorschemes'
Plug 'nightsense/cosmic_latte'
Plug 'Nequo/vim-allomancer'

"" Syntax
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'cespare/vim-toml'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'tikhomirov/vim-glsl'
Plug 'ianks/vim-tsx'
Plug 'leafgarland/typescript-vim'
Plug 'udalov/kotlin-vim'

Plug 'jason0x43/vim-js-indent'

call plug#end()

"""""""""""""""
" Keybindings "
"""""""""""""""

let mapleader = "\<Space>"
nnoremap <leader>fed :vnew ~/.config/nvim/init.vim<enter>
set ignorecase
set smartcase

"nnoremap <leader><leader> :update<enter>
nnoremap <leader>qq :qa<enter>
nnoremap <C-X>k :q<enter>
nnoremap <C-F> :CtrlP<enter>
nnoremap <leader><leader> :CtrlP<enter>
nnoremap <leader>k :wq<enter>

" Move
nnoremap <C-h> <c-w>h
nnoremap <C-j> <c-w>j
nnoremap <C-k> <c-w>k
nnoremap <C-l> <c-w>l

nnoremap j gj
nnoremap k gk
""""""""""""""

" CtrlP
let g:ctrlp_working_path_mode = 'ra'

" CoC
let g:coc_global_extensions = ['coc-snippets','coc-json']

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Ale
nnoremap <C-A-L> :ALEFix<enter>
let g:ale_c_parse_compile_commands=1
let g:airline#extensions#ale#enabled=1
let g:ale_linters={
\   'cpp': ['clangtidy'],
\   'javascript': ['eslint'],
\   'typescript': ['eslint'],
\}
let g:ale_fixers={
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'cpp': ['clang-format'],
\   'rust': ['rustfmt'],
\   'javascript': ['prettier', 'eslint'],
\   'typescript': ['eslint'],
\   'cmake': ['cmakeformat']
\}

" Standard stuff
set number
set expandtab
set tabstop=4
set shiftwidth=4
set mouse=a

set wildmode=longest,list,full

" Colour scheme stuff
let g:airline_theme = 'bubblegum'
colorscheme sacredforest

function! HopToFromHFile()
    let ext=expand('%:e')
    let file=expand('%:p:r')
    silent write
    let editfile = ""
    if(ext == "c")
        let hfile = file.".h"
        if(filereadable(hfile))
            let editfile = hfile
        endif
    endif
    if(ext == "hpp")
        let cppfile = file.".cpp"
        if(filereadable(cppfile))
            let editfile = cppfile
        endif
    endif
    if(ext == "cpp")
        let hfile = file.".h"
        let hppfile = file.".hpp"
        if(filereadable(hppfile))
            let editfile=hppfile
        elseif(filereadable(hfile))
            let editfile=hfile
        endif
    endif
    if(ext == "h")
        let cfile = file.".c"
        let cppfile = file.".cpp"
        if(filereadable(cfile))
            let editfile=cfile
        elseif(filereadable(cppfile))
            let editfile=cppfile
        endif
    endif
    if(filereadable(editfile))
        execute 'edit ' . editfile
    else
        echo "Could not find a file to swap to"
    endif

endfunction

" Relative or absolute numbers
function! ToggleNumbers()
    if(&nu == 1)
        set nu!
        set rnu
    else
        set nornu
        set nu
    endif
endfunction

nnoremap <leader>h :call HopToFromHFile()<CR>
nnoremap <C-n> :call ToggleNumbers()<CR>

set clipboard+=unnamedplus
set splitright
