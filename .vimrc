set nocompatible   	" Disable vi-compatibility
set t_Co=256        " Use 256 Colors in terminal

" Color Settings
syntax on
filetype plugin indent on
set background=dark

if (has('termguicolors'))
  set termguicolors
endif

let g:material_terminal_italics = 1
let g:material_theme_style='darker'
colorscheme material
set encoding=utf8


" VIM PLUG """""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')
Plug 'https://github.com/fatih/vim-go.git'
Plug 'https://github.com/sheerun/vim-polyglot.git'
Plug 'https://github.com/JamshedVesuna/vim-markdown-preview.git'
Plug 'https://github.com/pangloss/vim-javascript.git'
Plug 'https://github.com/ycm-core/YouCompleteMe.git'
Plug 'https://github.com/preservim/nerdtree.git'
Plug 'https://github.com/itchyny/lightline.vim.git'
call plug#end()
""""""""""""""""""""""""""""""""""""""
" Put your non-Plugin stuff after this line


let mapleader=','
set tabstop=4                   " a tab is four spaces
set smarttab
set tags=tags
set softtabstop=4               " when hitting <BS>, pretend like a tab is removed, even if spaces
set expandtab                   " expand tabs by default (overloadable per file type later)
set shiftwidth=4                " number of spaces to use for autoindenting
set shiftround                  " use multiple of shiftwidth when indenting with '<' and '>'
set autoindent                  " always set autoindenting on
set copyindent                  " copy the previous indentation on autoindenting
set number                      " always show line numbers
set relativenumber              " current line position shows relative distance to other lines
set ignorecase                  " ignore case when searching
set smartcase                   " ignore case if search pattern is all lowercase,
set noerrorbells                " don't beep
set splitbelow                  " create split below when doing horizontal split
set splitright                  " create split on right when doing a vertical split
set incsearch

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END
"set nowrap
"set timeout timeoutlen=200 ttimeoutlen=100

" Group all swp files and backups into a dir
set noswapfile
set nobackup
set nowritebackup

" NERDTree stuff
autocmd BufEnter * lcd %:p:h
nmap <C-n> :NERDTreeToggle<CR>
let NERDTreeMapOpenInTab='n'
"""""""""""""""""""""""""""""

" Quality of life shortcuts
inoremap jj <ESC>
nmap <leader>w :w<cr>
nmap <leader>q :q<cr>
map <C-t> <esc>:tabnew<space>
noremap <C-w> <esc>:saveas<space> 
nnoremap <leader>cd :cd %:p:h<cr>:pwd<cr>
nnoremap <leader>pd :pwd<cr>
""""""""""""""""""""""""""""""""""""""""


"clojure
"au VimEnter * RainbowParenthesesToggle
"au Syntax * RainbowParenthesesLoadRound
"au Syntax * RainbowParenthesesLoadSquare
"au Syntax * RainbowParenthesesLoadBraces
"au Filetype clojure nmap <c-c><c-k> :Require<cr>
"""""""""""""""""""""""""""""""""""""""""""""""

let g:lightline = { 'colorscheme': 'material_vim' }

set laststatus=2
"" air-line
"let g:airline_powerline_fonts = 1
"
"if !exists('g:airline_symbols')
"    let g:airline_symbols = {}
"endif
"
"let g:airline_symbols.branch = ''
"let g:airline_symbols.readonly = ''
"let g:airline_symbols.linenr = ''
"let g:airline_theme = 'papercolor'
""""""""""""""""""""""""""""""""""


"add semicolon in normal mode
nmap ;; A;<esc>
"""""""""""""""""""""""""""""


" Open splits
nnoremap vs :vsplit<cr>
nnoremap sp :split<cr>
" Resize vsplit;
nnoremap ;h :vertical resize +5<cr>
nnoremap ;l :vertical resize -5<cr>
nnoremap ;k :resize +5<cr>
nnoremap ;j :resize -5<cr>
nnoremap <leader>1 <c-w>=
nnoremap <leader>2 <C-h>:vertical resize 120<cr>

:inoremap <C-v> <ESC>"+pa
:vnoremap <C-c> "+y
:vnoremap <C-d> "+d


"typos
command! Q q " Bind :Q to :q
command! Qa qa
command! Wq wq

set mouse+=a
if &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif



inoremap <C-l> <Space><Space>


let g:ycm_autoclose_preview_window_after_completion=1

let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_arguments = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_format_strings = 1

let g:python_highlight_all = 1
