" Helps plugins load correctly
filetype plugin indent on

"Start plugin system.
call plug#begin()

" Autocompletion with Deoplete
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'deoplete-plugins/deoplete-jedi'
"Plug 'davidhalter/jedi'
"
" Autocompletion with CoC
" Use release branch
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Code snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Tab completion
"Plug 'ervandew/supertab'

" Color themes
Plug 'flazz/vim-colorschemes'

" Like a TOC for code
Plug 'vim-scripts/taglist.vim'

" More ctag goodness
Plug 'xolox/vim-easytags'

" easytags requires vim-misc
Plug 'xolox/vim-misc'

" Cross-file search and replace
Plug 'brooth/far.vim'

" Status bar mods
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Display git differences
Plug 'airblade/vim-gitgutter'

" Code refactoring
Plug 'apalmer1377/factorus'

" Syntax checking
Plug 'vim-syntastic/syntastic'

" Ansible syntax support
Plug 'pearofducks/ansible-vim'

" Markdown support
Plug 'gabrielelana/vim-markdown'

" Code folding
Plug 'tmhedberg/SimpylFold'

call plug#end()

" Configure basic behaviors.
set nocompatible
set fileformat=unix
set encoding=utf-8

" if hidden is not set, TextEdit might fail
set hidden

" better display for messages
set cmdheight=2

" Set split defaults to right and bottom
set splitbelow
set splitright

" Syntax highlighting
syntax enable
syntax on

" Line numbers
set number
set relativenumber

" Code folding
set foldcolumn=3

" Save view when file is saved, load view when file is loaded.
autocmd BufWinLeave * mkview
autocmd BufWinEnter * silent loadview
" the following line keeps the current working directory from being saved (and
" then loaded) in the view.
set viewoptions-=options

set title

" Indentation, tab stops
set ts=4
set autoindent
set expandtab
set shiftwidth=4

set cursorline
set ruler
set showmatch

" Text wrap column
set tw=79
set cc=+1

" always show signcolumns
set signcolumn=yes

" Persistent undo
set undodir=~/.vim/undodir
set undofile

" Key remappings
nnoremap <esc> :noh<return><esc>


" Plugin Configurations

" Deoplete Configs
"let g:deoplete#enable_at_startup = 1

" Don't set completeopt - Coc does this for you
"set completeopt=noinsert,menuone,preview
" Suppress annoying 'match x of y', 'The only match' and 'Pattern not found'
" messages.
set shortmess+=c
" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>

"Vim-Ansible config
" Indentation reset after two newlines in insert-mode.
let g:ansible_unindent_after_newline = 1

" Let plugins show effects after 250ms, not 4s
set updatetime=250

" Set color scheme
colorscheme zenburn

" Define SimpylFold behavior.
let g:SimpylFold_docstring_preview = 1

" Configure airline status bar
let g:airline_powerline_fonts=1
let g:airline_theme='wombat'

" Let vim-gitgutter work better with large files
let g:gitgutter_max_signs=10000

" Syntastic general settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Syntastic PHP settings
let g:syntastic_php_checkers = ['php', 'phpcs']
let g:syntastic_php_phpcs_exec = '/usr/bin/phpcs'
let g:syntastic_php_phpcs_args = '--standard=psr2 --error-severity=1 --warning-severity=0'

" Syntastic checker selection
let g:syntastic_python_checkers = ['flake8']
