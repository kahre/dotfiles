let plugDir="~/.local/share/nvim/plugged"

call plug#begin(plugDir)

" Usage
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-eunuch'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --rust-completer --go-completer --java-completer' }

"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'
"Plug 'ervandew/supertab'

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

"""""""""""""""
" Keybindings "
"""""""""""""""

let mapleader = "\<Space>"
nnoremap <leader>fed :vnew ~/.config/nvim/init.vim<enter>

"nnoremap <leader><leader> :update<enter>
nnoremap <leader>qq :qa<enter>
nnoremap <C-X>k :q<enter>
nnoremap <M-l> :YcmCompleter FixIt<enter>
nnoremap <C-F> :CtrlP<enter>
nnoremap <leader><leader> :CtrlP<enter>
nnoremap <leader>k :wq<enter>

" Move
nnoremap <C-h> <c-w>h
nnoremap <C-j> <c-w>j
nnoremap <C-k> <c-w>k
nnoremap <C-l> <c-w>l

""""""""""""""

" CtrlP
let g:ctrlp_working_path_mode = 'ra'

" AutoComplete & Snippets
" let g:UltiSnipsSnippetDir=plugDir.'/vim_snippets/UltiSnips'
let g:ycm_autoclose_preview_window_after_insertion=1

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

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

" Standard stuff
set number relativenumber
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

let g:ycm_global_ycm_extra_conf = "~/.config/nvim/ycm_extra_conf.py"
