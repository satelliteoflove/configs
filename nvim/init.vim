" Helps plugins load correctly
filetype plugin indent on

"Start plugin system.
call plug#begin()

" Autocompletion with CoC
" Use release branch
Plug 'neoclide/coc.nvim', {'branch': 'release'}

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

" Exuberant ctags in a sidebar.
Plug 'majutsushi/tagbar'

" More ctag goodness
Plug 'xolox/vim-easytags'

" easytags requires vim-misc
Plug 'xolox/vim-misc'

" Cross-file search and replace
"Plug 'brooth/far.vim'

" supports .todo files
"Plug 'aserebryakov/vim-todo-lists'

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
"Plug 'pearofducks/ansible-vim'

" Terraform folding support
Plug 'hashivim/vim-terraform'

" Markdown support
Plug 'gabrielelana/vim-markdown'

" Code folding for Python
"Plug 'tmhedberg/SimpylFold'

" Visualize vim undo tree
Plug 'simnalamburt/vim-mundo'

"Add Purpura theme
"Plug 'yassinebridi/vim-purpura'

"Add firenvim, a nvim client for Firefox
"Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

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
" fold by syntax, but also allow for manual fold creation
augroup vimrc
    au BufReadPre * setlocal foldmethod=indent
    au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END
" Support for folding terraform
au BufRead,BufNewFile *.tf setlocal filetype=terraform

" Save view when file is saved, load view when file is loaded.
autocmd BufWinLeave * mkview
autocmd BufWinEnter * silent loadview
" the following line keeps the current working directory from being saved (and
" then loaded) in the view.
set viewoptions-=options

set title

" Indentation, tab stops
"set ts=2
set ts=2
set autoindent
set expandtab
"set shiftwidth=2
set shiftwidth=2

set cursorline
set ruler
set showmatch

" Text wrap column
"set tw=79
set cc=+1

" always show signcolumns
set signcolumn=yes:5

" Persistent undo
set undodir=~/.vim/undodir
set undofile

" Key remappings
nnoremap <esc> :noh<return><esc>


" Plugin Configurations

" COC SETTINGS
"
" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Provide scrolling in the autocompletion pop-up windows
if has('nvim-0.4.3') || has('patch-8.2.0750')
          nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
          nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
          inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
          inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
endif

" TextEdit might fail if hidden is not set.
set hidden

" Give more space for displaying messages.
set cmdheight=2

" Fix an issue with signcolumn related to COC
set signcolumn=number

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Go import addition on write
autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)


" Suppress annoying 'match x of y', 'The only match' and 'Pattern not found'
" messages.
set shortmess+=c

" tagbar config
nmap <F8> :TagbarToggle<CR>

" Markdown tag support
let g:tagbar_type_markdown = {
  \ 'ctagstype'	: 'markdown',
  \ 'kinds'		: [
    \ 'c:chapter:0:1',
    \ 's:section:0:1',
    \ 'S:subsection:0:1',
    \ 't:subsubsection:0:1',
    \ 'T:l4subsection:0:1',
    \ 'u:l5subsection:0:1',
  \ ],
  \ 'sro'			: '""',
  \ 'kind2scope'	: {
    \ 'c' : 'chapter',
    \ 's' : 'section',
    \ 'S' : 'subsection',
    \ 't' : 'subsubsection',
    \ 'T' : 'l4subsection',
  \ },
  \ 'scope2kind'	: {
    \ 'chapter' : 'c',
    \ 'section' : 's',
    \ 'subsection' : 'S',
    \ 'subsubsection' : 't',
    \ 'l4subsection' : 'T',
  \ },
\ }


" Terraform tag support
let g:tagbar_type_tf = {
  \ 'ctagstype': 'tf',
  \ 'kinds': [
    \ 'r:Resource',
    \ 'R:Resource',
    \ 'd:Data',
    \ 'D:Data',
    \ 'v:Variable',
    \ 'V:Variable',
    \ 'p:Provider',
    \ 'P:Provider',
    \ 'm:Module',
    \ 'M:Module',
    \ 'o:Output',
    \ 'O:Output',
    \ 'f:TFVar',
    \ 'F:TFVar'
  \ ]
\ }

" Typescript tag support
let g:tagbar_type_typescript = {
  \ 'ctagstype': 'typescript',
  \ 'kinds': [
    \ 'c:classes',
    \ 'n:modules',
    \ 'f:functions',
    \ 'v:variables',
    \ 'v:varlambdas',
    \ 'm:members',
    \ 'i:interfaces',
    \ 'e:enums',
  \ ]
\ }


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
let g:gitgutter_max_signs=-1

" Configure commands to select next/previous hunk of changed code
"nmap ]h <Plug>(GitGutterNextHunk)
"nmap [h <Plug>(GitGutterPrevHunk)

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

" XML Folding
augroup XML
    autocmd!
    autocmd FileType xml setlocal foldmethod=indent foldlevelstart=0 foldminlines=0
augroup END
