" <leader>
let mapleader = ','

" Don't try to be vi compatible
set nocompatible

" Helps force plugins to load correctly when it is turned back on below
filetype off

" TODO: Load plugins here (pathogen or vundle)

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

" Helpers to code
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'HerringtonDarkholme/yats.vim'
Plug 'prettier/vim-prettier'
Plug 'tpope/vim-commentary'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'ryanoasis/vim-devicons'

" Icons for FzF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'coreyja/fzf.devicon.vim'

call plug#end()


" COLORSCHEME CONF
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
let g:fzf_layout = { 'down': '40%' }
nnoremap <leader>r :call SearchRelatedWord()<CR>

function! SearchRelatedWord()
  " Obtiene la palabra debajo del cursor
  let word_under_cursor = expand('<cword>')

  " Ejecuta la búsqueda en archivos del mismo directorio
  let cmd = 'grep -rl "\<'.word_under_cursor.'\>" '.expand('%:p:h')
  let result = system(cmd)

  " Abre la lista de resultados en fzf
  call fzf#run({
        \ 'source': split(result, "\n"),
        \ 'sink': 'e',
        \ 'options': '--preview "cat {}"'
        \ })
endfunction


" Map the F3 key to toggle :FILES in current directory
nnoremap <F3> :Files %:p:h

" COC.VIM CONF
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" NERDTreeToggle
nmap <F6> :NERDTreeToggle<CR>
" Open a file from NERDTree and keep it open when pressing "Shift + W"
autocmd FileType nerdtree nnoremap <buffer> <Esc><Esc> :NERDTreeToggle<CR>


