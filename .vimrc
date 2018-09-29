set nocompatible   	" Disable vi-compatibility
set t_Co=256        " Use 256 Colors in terminal
"set termguicolors
" Put your non-Plugin stuff after this line
execute pathogen#infect()
" Color Settings
syntax on
filetype plugin indent on
set background=dark
"colorscheme monokai
set encoding=utf8



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
set ignorecase                  " ignore case when searching
set smartcase                   " ignore case if search pattern is all lowercase,
set noerrorbells                " don't beep
set splitbelow                  " create split below when doing horizontal split
set splitright                  " create split on right when doing a vertical split
set incsearch
set nowrap
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


" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
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



"""LATEX
    "spellcheck
    autocmd FileType tex set spell spelllang=en_us
    autocmd FileType tex set wrap
	" Word count:
	autocmd FileType tex map <F3> :w !detex \| wc -w<CR>
	autocmd FileType tex inoremap <F3> <Esc>:w !detex \| wc -w<CR>
	" Compile document using xelatex:
	autocmd FileType tex nnoremap <F5> :!xelatex<space><c-r>%<Enter>
	" Code snippets
	autocmd FileType tex inoremap ;fr \begin{frame}<Enter>\frametitle{}<Enter><Enter><++><Enter><Enter>\end{frame}<Enter><Enter><++><Esc>6kf}i
	autocmd FileType tex inoremap ;fi \begin{fitch}<Enter><Enter>\end{fitch}<Enter><Enter><++><Esc>3kA
	autocmd FileType tex inoremap ;exe \begin{exe}<Enter>\ex<Space><Enter>\end{exe}<Enter><Enter><++><Esc>3kA
	autocmd FileType tex inoremap ;em \emph{}<++><Esc>T{i
	autocmd FileType tex inoremap ;bf \textbf{}<++><Esc>T{i
	autocmd FileType tex vnoremap ; <ESC>`<i\{<ESC>`>2la}<ESC>?\\{<Enter>a
	autocmd FileType tex inoremap ;it \textit{}<++><Esc>T{i
	autocmd FileType tex inoremap ;ct \textcite{}<++><Esc>T{i
	autocmd FileType tex inoremap ;cp \parencite{}<++><Esc>T{i
	autocmd FileType tex inoremap ;glos {\gll<Space><++><Space>\\<Enter><++><Space>\\<Enter>\trans{``<++>''}}<Esc>2k2bcw
	autocmd FileType tex inoremap ;x \begin{xlist}<Enter>\ex<Space><Enter>\end{xlist}<Esc>kA<Space>
	autocmd FileType tex inoremap ;ol \begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><Enter><++><Esc>3kA\item<Space>
	autocmd FileType tex inoremap ;ul \begin{itemize}<Enter><Enter>\end{itemize}<Enter><Enter><++><Esc>3kA\item<Space>
	autocmd FileType tex inoremap ;li <Enter>\item<Space>
	autocmd FileType tex inoremap ;ref \ref{}<Space><++><Esc>T{i
	autocmd FileType tex inoremap ;tab \begin{tabular}<Enter><++><Enter>\end{tabular}<Enter><Enter><++><Esc>4kA{}<Esc>i
	autocmd FileType tex inoremap ;ot \begin{tableau}<Enter>\inp{<++>}<Tab>\const{<++>}<Tab><++><Enter><++><Enter>\end{tableau}<Enter><Enter><++><Esc>5kA{}<Esc>i
	autocmd FileType tex inoremap ;can \cand{}<Tab><++><Esc>T{i
	autocmd FileType tex inoremap ;con \const{}<Tab><++><Esc>T{i
	autocmd FileType tex inoremap ;v \vio{}<Tab><++><Esc>T{i
	autocmd FileType tex inoremap ;a \href{}{<++>}<Space><++><Esc>2T{i
	autocmd FileType tex inoremap ;sc \textsc{}<Space><++><Esc>T{i
	autocmd FileType tex inoremap ;chap \chapter{}<Enter><Enter><++><Esc>2kf}i
	autocmd FileType tex inoremap ;sec \section{}<Enter><Enter><++><Esc>2kf}i
	autocmd FileType tex inoremap ;ssec \subsection{}<Enter><Enter><++><Esc>2kf}i
	autocmd FileType tex inoremap ;sssec \subsubsection{}<Enter><Enter><++><Esc>2kf}i
	autocmd FileType tex inoremap ;st <Esc>F{i*<Esc>f}i
	autocmd FileType tex inoremap ;beg \begin{DELRN}<Enter><++><Enter>\end{DELRN}<Enter><Enter><++><Esc>4k0fR:MultipleCursorsFind<Space>DELRN<Enter>c
	autocmd FileType tex inoremap ;up <Esc>/usepackage<Enter>o\usepackage{}<Esc>i
	autocmd FileType tex nnoremap ;up /usepackage<Enter>o\usepackage{}<Esc>i
	autocmd FileType tex inoremap ;tt \texttt{}<Space><++><Esc>T{i
	autocmd FileType tex inoremap ;bt {\blindtext}
	autocmd FileType tex inoremap ;nu $\varnothing$
	autocmd FileType tex inoremap ;col \begin{columns}[T]<Enter>\begin{column}{.5\textwidth}<Enter><Enter>\end{column}<Enter>\begin{column}{.5\textwidth}<Enter><++><Enter>\end{column}<Enter>\end{columns}<Esc>5kA
	autocmd FileType tex inoremap ;rn (\ref{})<++><Esc>F}i

"""LATEX Logical symbols
	autocmd FileType tex inoremap ;m $$<Space><++><Esc>2T$i
	autocmd FileType tex inoremap ;M $$$$<Enter><Enter><++><Esc>2k$hi
	autocmd FileType tex inoremap ;neg {\neg}
	autocmd FileType tex inoremap ;V {\vee}
	autocmd FileType tex inoremap ;or {\vee}
	autocmd FileType tex inoremap ;L {\wedge}
	autocmd FileType tex inoremap ;and {\wedge}
	autocmd FileType tex inoremap ;ra {\rightarrow}
	autocmd FileType tex inoremap ;la {\leftarrow}
	autocmd FileType tex inoremap ;lra {\leftrightarrow}
	autocmd FileType tex inoremap ;fa {\forall}
	autocmd FileType tex inoremap ;ex {\exists}
	autocmd FileType tex inoremap ;dia	{\Diamond}
	autocmd FileType tex inoremap ;box	{\Box}
	autocmd FileType tex inoremap ;gt	{\textgreater}
autocmd FileType tex inoremap ;lt	{\textless}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
