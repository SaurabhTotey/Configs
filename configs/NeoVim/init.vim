let g:polyglot_disabled=['sensible', 'autoindent']
call plug#begin()
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'simnalamburt/vim-mundo'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'chaoren/vim-wordmotion'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'sheerun/vim-polyglot'
Plug 'scrooloose/syntastic'
Plug 'valloric/youcompleteme'
Plug 'vim-airline/vim-airline'
Plug 'joshdick/onedark.vim'
Plug 'luochen1990/rainbow'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux-focus-events'
call plug#end()

"Everything should be done in UTF8
scriptencoding utf-8
set encoding=utf-8
set fileencoding=utf-8

"Detect filetypes, but use tabs that appear as 4 spaces and backspaces that work on everything: I always always always want hard tabs for indentation
"It's quite annyoing that polyglot_disabled autoindent doesn't disable this for each file type
filetype on
filetype indent off
filetype plugin indent off
set noexpandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set backspace=2
let g:rust_recommended_style=0
let g:python_recommended_style=0

"Use relative line numberings for easier movement
set relativenumber

"Don't wrap long lines
set nowrap

"Create undo and swap files for easier editing and store them in /tmp
set undofile
set undodir=/tmp
set directory=/tmp

"Update the buffer when the file changes from some outside location
set autoread

"Keep 8 lines of context (8 lines above and 8 lines below) when scrolling whenever possible
set scrolloff=8

"Indent automatically when creating new lines
set smartindent

"Show the mode at the bottom
set showmode

"Shows a highlight on the line and column where the cursor is
set cursorline
set cursorcolumn

"Always show a status line
set laststatus=2

"Show a ruler at the bottom and draw a color line at column 120 which is a long ways in
set ruler
set colorcolumn=120

"Smoother drawing
set ttyfast

"Reduce timeout duration to make escape feel snappier
set timeoutlen=1000
set ttimeoutlen=5

"Show whitespace characters
set list
set listchars=tab:▸\ ,eol:¬\,trail:⎵\,extends:→\,precedes:←

"Exclude the trailing newline when using $ to select to the end of the line
vnoremap $ $h

"Syntax highlighting
syntax on

"Beep and flash on error
set errorbells
set visualbell

"Make searches case-insensitive unless they have uppercase letters
set ignorecase
set smartcase

"Show the best match as a search string is being typed
set incsearch

"Replace all matches in a line for substitutions if the \g is present
set gdefault

"Highlight searches
set hlsearch

"Show matching braces when a brace is inserted
set showmatch

"New splits should go below and to the right
set splitbelow splitright

"Set the colorscheme and airline theme to OneDark
set termguicolors
colorscheme onedark
let g:airline_theme='onedark'

"Override background color to use transparency
hi Normal guibg=NONE ctermbg=NONE

"Rainbow parentheses for easier distinction between matching sets
let g:rainbow_active=1

"Keep the NERDTree preview a certain size
let g:NERDTreeWinSize=40

"Open NERDTree when no arguments are specified or a directory argument is given
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | wincmd p | q | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') | execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | q | endif

"Close the YouCompleteMe previews automatically
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_autoclose_preview_window_after_insertion=1

"Stop airline for yelling about mixed indentation when using spaces for alignment
let g:airline#extensions#c_like_langs=['arduino', 'c', 'cpp', 'cuda', 'd', 'glsl', 'go', 'java', 'javascript', 'kotlin', 'ld', 'php', 'rust', 'scala']
let g:airline#extensions#whitespace#mixed_indent_algo=1

"Fix detection for shaders: .frag files are being interpretted as JavaScript for some reason
autocmd! BufNewFile,BufRead *.vert,*.tesc,*.tese,*.glsl,*.geom,*.frag,*.comp set filetype=glsl

"Enable airline integration with other plugins
let g:airline#extensions#fugitive#enabled=1
let g:airline#extensions#fzf#enabled=1
let g:airline#extensions#syntastic#enabled=1
let g:airline#extensions#ycm#enabled=1

"Allow vim-tmux-navigator to work from the NERDTree pane
let g:NERDTreeMapJumpNextSibling='<Nop>'
let g:NERDTreeMapJumpPrevSibling='<Nop>'

"Detect Syntastic errors on startup or save (but not exit) and put them in the error window, which opens when there are errors and closes when there aren't
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0

"Makes keybindings for common YCM commands
command! F :YcmCompleter FixIt
command! -nargs=1 R :YcmCompleter RefactorRename <args>
command! G :YcmCompleter GoTo
command! T :YcmCompleter GetType
command! D :YcmCompleter GetDoc
