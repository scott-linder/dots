set colorcolumn=81,82
set fillchars=vert:│,fold:─,diff:─
set linebreak
set showbreak=\ ↳\ 
set t_Co=256
set wrap

set expandtab
set tabstop=8
set shiftwidth=4

set nojoinspaces
set formatoptions+=2

set number

set incsearch
set ignorecase
set smartcase

set modeline

set undofile

set hidden

au TermOpen * setlocal nonumber
let $GIT_EDITOR = 'nvr -cc split --remote-wait'
au FileType gitcommit set bufhidden=delete

" Pick <C-j> as a consistent way to return to normal mode from anywhere. This
" doesn't seem to conflict with any control sequences in terminal emulators
" or common utilities, and it is on the home row.
inoremap <C-j> <C-\><C-n>
tnoremap <C-j> <C-\><C-n>
cnoremap <C-j> <C-\><C-n>
nnoremap <C-j> <C-\><C-n>

nnoremap <leader> :w<CR>

call plug#begin(stdpath('data') . '/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'antiagainst/vim-tablegen'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'moll/vim-bbye'
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

" Bbye
nnoremap <leader>q :Bdelete<cr>

" CoC
inoremap <silent><expr> <c-space> coc#refresh()
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
