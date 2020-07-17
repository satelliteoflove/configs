" Helps plugins load correctly
filetype plugin indent on

"Start plugin system.
call plug#begin()

" Autocompletion with CoC
" Use release branch
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Exuberant ctags in a sidebar.
Plug 'majutsushi/tagbar'

" File tree browser
Plug 'preservim/nerdtree'

" Code snippets
"Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Insert or delete brackets, parens, quotes in pair.
Plug 'jiangmiao/auto-pairs'

" Tab completion
"Plug 'ervandew/supertab'

" Surround
Plug 'tpope/vim-surround'

" Git integration
Plug 'tpope/vim-fugitive'

" Color themes
Plug 'flazz/vim-colorschemes'

" Like a TOC for code
Plug 'vim-scripts/taglist.vim'

" More ctag goodness
Plug 'xolox/vim-easytags'

" easytags requires vim-misc
Plug 'xolox/vim-misc'

" Cross-file search and replace
"Plug 'brooth/far.vim'

" supports .todo files
Plug 'aserebryakov/vim-todo-lists'

" Status bar mods
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Display git differences
Plug 'airblade/vim-gitgutter'

" Code refactoring
Plug 'apalmer1377/factorus'

Plug 'hashivim/vim-terraform'

" Syntax checking
Plug 'vim-syntastic/syntastic'

" Ansible syntax support
Plug 'pearofducks/ansible-vim'

" Markdown support
Plug 'gabrielelana/vim-markdown'

" Code folding for Python
"Plug 'tmhedberg/SimpylFold'

" Visualize vim undo tree
Plug 'simnalamburt/vim-mundo'

"Add Purpura theme
Plug 'yassinebridi/vim-purpura'

call plug#end()

" Configure basic behaviors.
set nocompatible
set fileformat=unix
set encoding=utf-8

" if hidden is not set, TextEdit might fail
set hidden

" Use system clipboard for copy/paste
set clipboard+=unnamedplus

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
set foldmethod=syntax

" Save view when file is saved, load view when file is loaded.
autocmd BufWinLeave * mkview
autocmd BufWinEnter * silent loadview
" the following line keeps the current working directory from being saved (and
" then loaded) in the view.
set viewoptions-=options

set title

" Indentation, tab stops
set ts=2
set autoindent
set expandtab
set shiftwidth=2

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

" Coc Settings
set statusline+=%{coc#status()}

" Use <Tab> for trigger completion
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" Don't set completeopt - Coc does this for you
"set completeopt=noinsert,menuone,preview
" Suppress annoying 'match x of y', 'The only match' and 'Pattern not found'
" messages.
set shortmess+=c
" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>

" tagbar config
nmap <F8> :TagbarToggle<CR>

"Vim-Ansible config
" Indentation reset after two newlines in insert-mode.
let g:ansible_unindent_after_newline = 1

" Let plugins show effects after 250ms, not 4s
set updatetime=250

" Set color scheme
colorscheme iceberg
"colorscheme purpura
"set termguicolors

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

" NERDTree hotkey
map <C-n> :NERDTreeToggle<CR>
