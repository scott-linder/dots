set colorcolumn=81,82
set fillchars=vert:│,fold:─,diff:─
set linebreak
set nojoinspaces
set t_Co=256
set wrap

set expandtab
set tabstop=8
set shiftwidth=4

set formatoptions+=2

set number
set relativenumber

set incsearch
set ignorecase
set smartcase

set modeline

set undofile

au TermOpen * setlocal nonumber norelativenumber
let $GIT_EDITOR = 'nvr -cc split --remote-wait'
au FileType gitcommit set bufhidden=delete

" Pick <C-j> as a consistent way to return to normal mode from anywhere. This
" doesn't seem to conflict with any control sequences in terminal emulators
" or common utilities, and it is on the home row.
inoremap <C-j> <C-\><C-n>
tnoremap <C-j> <C-\><C-n>
cnoremap <C-j> <C-\><C-n>

" Python
au FileType python setl nosmartindent

" Markdown
au BufRead,BufNewFile *.md setl filetype=markdown spell
au FileType markdown noremap <buffer> <Leader>r :!markdown "%" > "$(basename "%" .md).html"<cr><cr>

" Rust
au FileType rust noremap <buffer> <leader>r :tabedit<cr>:terminal cargo run<cr>
au FileType rust noremap <buffer> <leader>t :tabedit<cr>:terminal cargo test<cr>
au FileType rust noremap <buffer> <leader>b :tabedit<cr>:terminal cargo build<cr>
au FileType rust noremap <buffer> <leader>c :tabedit<cr>:terminal cargo clean<cr>

call plug#begin(stdpath('data') . '/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'antiagainst/vim-tablegen'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ntpeters/vim-better-whitespace'
Plug 'scott-linder/molokai'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'

call plug#end()

colorscheme molokai

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
