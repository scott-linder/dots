"" Plug

call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'antiagainst/vim-tablegen'
Plug 'dag/vim-fish'
Plug 'elixir-editors/vim-elixir'
Plug 'embear/vim-localvimrc'
Plug 'gerw/vim-latex-suite'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mattn/emmet-vim'
Plug 'mhinz/vim-mix-format'
Plug 'neomake/neomake'
Plug 'ntpeters/vim-better-whitespace'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'rhysd/vim-clang-format'
Plug 'scott-linder/molokai'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'vim-scripts/a.vim'
Plug 'vimoutliner/vimoutliner'
call plug#end()

"" VIM

" Looks
set t_Co=256
colorscheme molokai
set fillchars=vert:│,fold:─,diff:─
set nohlsearch

" Lines
set colorcolumn=81,82
set nojoinspaces
set wrap
set linebreak

" Tabs
set expandtab
set tabstop=8
set shiftwidth=4

" Paragraphs
set formatoptions+=2

" Numbers
set number
set relativenumber

" Search
set incsearch
set ignorecase
set smartcase

" Modeline
set modeline

" Context
set scrolloff=2

" Remember last lines
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif

" Persistent undo
if isdirectory($HOME . '/.vim/undo') == 0
    :silent !mkdir -p ~/.vim/undo >/dev/null 2>&1
endif
set undodir=~/.vim/undo//
set undofile

" Pick <C-j> as a consistent way to return to normal mode from anywhere. This
" doesn't seem to conflict with any control sequences in terminal emulators
" or common utilities, and it is on the home row.
inoremap <C-j> <C-\><C-n>
tnoremap <C-j> <C-\><C-n>
cnoremap <C-j> <C-\><C-n>

" Terminal
:tnoremap <Esc> <C-\><C-n>

"" Plugins

" A
let g:alternateExtensions_cc = "hh"
let g:alternateExtensions_hh = "cc"

" Latex-Suite
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"
let g:tex_comment_nospell = 1
let g:Tex_Folding = 0
let g:Tex_CompileRule_pdf = 'pdflatex -interaction=nonstopmode $*'
let g:Tex_FormatDependancy_pdf = 'pdf'
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_MultipleCompileFormats = 'pdf'
let g:Tex_ViewRule_pdf = 'evince'

" NERDTree
nmap <C-n> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen = 1

"" Filetype

" Python
au FileType python setl nosmartindent

" Markdown
au BufRead,BufNewFile *.md setl filetype=markdown spell
au FileType markdown noremap <buffer> <Leader>r :!markdown "%" > "$(basename "%" .md).html"<cr><cr>

" R
au FileType r noremap <buffer> <leader>r :!clear && R --vanilla <% \| less<cr>
au FileType r noremap <buffer> <leader>p :!evince Rplots.pdf >/dev/null 2>&1 &<cr>

" Rust
au FileType rust noremap <buffer> <leader>r :tabedit<cr>:terminal cargo run<cr>
au FileType rust noremap <buffer> <leader>t :tabedit<cr>:terminal cargo test<cr>
au FileType rust noremap <buffer> <leader>b :tabedit<cr>:terminal cargo build<cr>
au FileType rust noremap <buffer> <leader>c :tabedit<cr>:terminal cargo clean<cr>

" VimOutliner
au FileType votl set tabstop=2
au FileType votl set shiftwidth=2
au FileType votl set noexpandtab

" ClangFormat
"au FileType c,cpp nnoremap <buffer><Leader>f :<C-u>ClangFormat<CR>
au FileType c,cpp vnoremap <buffer><Leader>f :ClangFormat<CR>

" FZF
" Enable preview window in :Files
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
" Enable preview window in :Rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)
nnoremap <C-o> :Buffers<cr>
nnoremap <C-p> :Files<cr>

" NeoMake
call neomake#configure#automake('w')

" localvimrc
let g:localvimrc_persistent = 2

" terminal
au TermOpen * setlocal nonumber norelativenumber
let $GIT_EDITOR = 'nvr -cc split --remote-wait'
au FileType gitcommit set bufhidden=delete
tnoremap <A-e> <C-\><C-n>

" alt+{hjkl} to navigate windows
:tnoremap <A-h> <C-\><C-N><C-w>h
:tnoremap <A-j> <C-\><C-N><C-w>j
:tnoremap <A-k> <C-\><C-N><C-w>k
:tnoremap <A-l> <C-\><C-N><C-w>l
:inoremap <A-h> <C-\><C-N><C-w>h
:inoremap <A-j> <C-\><C-N><C-w>j
:inoremap <A-k> <C-\><C-N><C-w>k
:inoremap <A-l> <C-\><C-N><C-w>l
:nnoremap <A-h> <C-w>h
:nnoremap <A-j> <C-w>j
:nnoremap <A-k> <C-w>k
:nnoremap <A-l> <C-w>l

" ctrl+alt+{hl} to navigate tabs
:tnoremap <C-A-h> <C-\><C-N> :tabprevious<CR>
:tnoremap <C-A-l> <C-\><C-N> :tabnext<CR>
:inoremap <C-A-h> <C-\><C-N> :tabprevious<CR>
:inoremap <C-A-l> <C-\><C-N> :tabnext<CR>
:nnoremap <C-A-h> :tabprevious<CR>
:nnoremap <C-A-l> :tabnext<CR>

" elixir
au FileType elixir nnoremap <Leader>f :MixFormat<CR>
