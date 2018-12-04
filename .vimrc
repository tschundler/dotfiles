"execute pathogen#infect()
set number

set encoding=utf-8

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set splitbelow
set splitright

" Yank to clipboard over ssh with \y
map <Leader>y <Plug>(operator-poweryank-osc52)

" Enable folding
"set foldmethod=indent
set foldlevel=99
nnoremap <space> za

let g:SimpylFold_docstring_preview=1

set shiftwidth=0    " Use tabstop
set softtabstop=-1  " Use shiftwidth

au BufNewFile,BufRead *.py
    \ setlocal tabstop=4 |
    \ setlocal textwidth=79 |
    \ setlocal expandtab |
    \ setlocal autoindent |
    \ setlocal fileformat=unix

au BufNewFile,BufRead *.js,*.html,*.css
    \ setlocal tabstop=2

"au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" python with virtualenv support
if has('python3')
python3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  exec(open(activate_this).read(), dict(__file__=activate_this))
EOF
endif

let python_highlight_all = 1
set showmatch

let g:airline_theme='papercolor'
let g:airline_powerline_fonts = 1
set ttimeoutlen=10

" Set the working directory to wherever the open file lives
set autochdir

" NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Mouse
set mouse=a

" Context aware line-lumbers from https://jeffkreeftmeijer.com/vim-number/
:set number relativenumber

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

" Common Settings Above Here

" End Stuff

filetype plugin indent on
syntax on

" EOF
