" <Leader> key & waiting time
let mapleader = ','
set timeoutlen=2500

" Enable Scrolling
:set mouse=n

" Don't try to be vi compatible
set nocompatible

" Helps force plugins to load correctly when it is turned back on below
filetype off

" Turn on syntax highlighting
syntax on

" For plugins to load correctly
filetype plugin indent on

" Highlight cursor line underneath the cursor horizontally.
set cursorline

" Highlight cursor line underneath the cursor vertically.
set cursorcolumn

" Enable auto completion menu after pressing TAB.
set wildmenu

" Make wildmenu behave like similar to Bash completion.
set wildmode=list:longest,list:full

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" Security
set modelines=0

" Show line numbers
set number

" Show file stats
set ruler

" Blink cursor on error instead of beeping (grr)
set visualbell

" Encoding
set encoding=utf-8

" Whitespace
set wrap
set textwidth=79
set formatoptions=tcqrn1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim

" Move up/down editor lines
nnoremap j gj
nnoremap k gk

" Allow hidden buffers
set hidden

" Rendering
set ttyfast

" Status bar
set laststatus=2

" Last line
set showmode
set showcmd

" Searching
" --------------------
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
" Clear highlights on hitting ESC twice
nnoremap <esc><esc> :noh<return>

" Press the space bar to type the : character in command mode
nnoremap <space> :

" Plugins
" --------------------
call plug#begin()

" Colorscheme
Plug 'bluz71/vim-moonfly-colors', { 'as': 'moonfly' }

" FzF -> searching files
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Airline -> give better status bar
Plug 'vim-airline/vim-airline'

" JS
Plug 'pangloss/vim-javascript'
Plug 'elzr/vim-json'
Plug 'dmmulroy/tsc.nvim'
Plug 'mattn/emmet-vim'
Plug 'dense-analysis/ale'

" Helpers to code
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'HerringtonDarkholme/yats.vim'
Plug 'prettier/vim-prettier', { 'do': 'npm install' }
Plug 'tpope/vim-commentary'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'ryanoasis/vim-devicons'
Plug 'mhinz/vim-grepper'
Plug 'findango/vim-mdx'
Plug 'onsails/lspkind.nvim'

" Icons for FzF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'coreyja/fzf.devicon.vim'

call plug#end()


" COLORSCHEME CONF
" --------------------
colorscheme moonfly
let g:lightline = { 'colorscheme': 'moonfly' }
let g:moonflyCursorColor = v:true
let g:moonflyItalics = v:false
let g:moonflyNormalFloat = v:true
let g:moonflyTerminalColors = v:false
let g:moonflyTransparent = v:true
let g:moonflyUndercurls = v:false
let g:moonflyUnderlineMatchParen = v:true
let g:moonflyVirtualTextColor = v:true
let g:moonflyWinSeparator = 2
set fillchars=horiz:━,horizup:┻,horizdown:┳,vert:┃,vertleft:┨,vertright:┣,verthoriz:╋
augroup CustomHighlight
    autocmd!
    autocmd ColorScheme moonfly highlight Function guifg=#74b2ff gui=bold
augroup END

" FZF CONF
" --------------------
let g:fzf_layout = { 'down': '40%' }
nnoremap <Leader>F :call OpenFZFRecursivelyAtGitRoot()<CR>

function! OpenFZFRecursivelyAtGitRoot()
  " Get the root directory of the Git repository
  let git_root = system('git rev-parse --show-toplevel')

  " Trim any trailing newline characters
  let git_root = substitute(git_root, '\n$', '', '')

  " Check if git_root is empty (not in a Git repo)
  if empty(git_root)
    " If not in a Git repo, use the current working directory
    let git_root = getcwd()
  endif
echo git_root 
  " Open FZF and search for files recursively from the Git root directory
  call fzf#run({
        \ 'source': 'find . -type d -name node_modules -prune -o -type f -print',
        \ 'sink': 'e',
        \ 'dir': git_root,
        \ 'options': '--preview "cat {}"'
        \ })
endfunction

" COC CONF
" --------------------
" Remap keys for gotos
nnoremap <silent> gd :call CocAction('jumpDefinition', 'tabe')<CR>
nnoremap <silent> gy :call CocAction('jumpTypeDefinition', 'tabe')<CR>
nnoremap <silent> gi :call CocAction('jumpImplementation', 'tabe')<CR>
nnoremap <silent> gr :call CocAction('jumpReferences', 'tabe')<CR>
highlight CocError guifg=#FF0000

" GREPPER CONF
" --------------------
nnoremap <Leader>f :call ToggleGrepper()<CR>
nnoremap <leader>* :Grepper -tool ag -cword -noprompt<cr>
" Put the greeper on the repo level
let g:grepper_default_directory = system('git rev-parse --show-toplevel 2>/dev/null')


function! ToggleGrepper()
  if exists('g:grepper')
    " If vim-grepper is already active, close the quickfix window
    cclose
    unlet! g:grepper
  else
    " If vim-grepper is not active, open it
    Grepper -r -I --files-with-matches .
  endif
endfunction


" NERDTreeToggle
" --------------------
nnoremap <Leader>d :NERDTreeToggle<CR>
" Toggle NERDTree to display the current directory
nnoremap <Leader>D :NERDTreeToggle %:p:h<CR>

" ALE linter
" --------------------
let g:ale_fixers = {
    \ 'javascript': ['prettier', 'eslint'],
    \ 'javascript.jsx': ['prettier', 'eslint'],
    \ 'typescript': ['tslint', 'prettier', 'eslint'],
    \ 'typescript.tsx': ['tslint', 'prettier', 'eslint'],
    \ }

" Enable auto-fixing on save
let g:ale_fix_on_save = 1
let g:ale_fixers['*'] = ['prettier']


" LSP client
" -------------------
"set g:lsp_enable = 1

let g:lspkind_symbols = {
    \ 'Class' : ' ',
    \ 'Function' : ' ',
    \ 'Method' : ' ',
    \ 'Field' : 'ﰠ ',
    \ }

" Set the completion source to lspkind-nvim
set completeopt=menuone,noinsert,noselect
set completefunc=lspkind#complete

" Enable vim-prettier for JavaScript and JavaScript/JSX files
" --------------------
let g:prettier#quickfix_enabled = 0
let g:prettier#autoformat = 1


" General Leader Mapping
" --------------------
" Move to the next buffer using Leader + j
nnoremap <Leader>j :bnext<CR>
" Move to the previous buffer using Leader + k
nnoremap <Leader>k :bprev<CR>
" Open a vertical terminal with <leader>tv
nnoremap <Leader>tv :vnew +term<CR>
" Open a horizontal terminal with <leader>th
nnoremap <Leader>th :split +term<CR>
" Tabs
nmap <Leader>1 1gt
nmap <Leader>2 2gt
nmap <Leader>3 3gt
nmap <Leader>4 4gt
nmap <Leader>5 5gt
nmap <Leader>6 6gt
nmap <Leader>7 7gt
nmap <Leader>ct :tabc<CR>
nmap <Leader>cta :tabo<CR>
