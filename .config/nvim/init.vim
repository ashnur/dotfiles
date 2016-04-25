let g:syntastic_shell = "/bin/zsh"
set background=dark
set encoding=utf-8 nobomb
scriptencoding utf-8
set t_Co=256
" set t_u7=

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

augroup vimrc
  autocmd!
augroup END

set modeline

set title
if !has('nvim')
  set lazyredraw                      " macros don't update display
endif

" no beeps or flashes
set visualbell t_vb=

" show context around current cursor position
set scrolloff=9999
set sidescrolloff=16

" set colorcolumn=80
set cursorline
set number

set synmaxcol=512                     " don't syntax highlight long lines
set showtabline=0                     " start OFF, toggle =2 to show tabline
set laststatus=2                      " always show all statuslines
" initial statusline in case you type before VimEnter

set noshowcmd                         " show incomplete commands (SLOW so off)
set noshowmode                        " don't show -- INSERT -- in cmdline

set mouse=a
if !has('nvim') | set ttymouse=xterm | endif

set notimeout
set ttimeout
set ttimeoutlen=10

let g:mapleader = " "

set browsedir=buffer                  " browse files in same dir as open file
set wildmenu                          " Enhanced command line completion.
set wildmode=list:longest,full        " Complete files using a menu AND list
set wildignorecase
set wildignore+=.git,.hg,.svn
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*,*.gem
set wildignore+=*.aux,*.out,*.toc
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest,*.rbc,*.class
set wildignore+=*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp
set wildignore+=*.avi,*.m4a,*.mp3,*.oga,*.ogg,*.wav,*.webm
set wildignore+=*.eot,*.otf,*.ttf,*.woff
set wildignore+=*.doc,*.pdf
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=*.swp,.lock,.DS_Store,._*

set fileformats=unix,mac,dos
set fileformat=unix

" From https://github.com/swizzard/dotfiles/blob/master/.vimrc
" Don't keep .viminfo information for files in temporary directories or shared
" memory filesystems; this is because they're used as scratch spaces for tools
" like sudoedit(8) and pass(1) and hence could present a security problem
if !has('nvim') && has('viminfo')
  augroup dkoviminfo
    autocmd!
    silent! autocmd vimrc BufNewFile,BufReadPre
        \ /tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*
        \ setlocal viminfo=
  augroup END
endif

" swap - useless
set noswapfile

" backups
set backupskip=/tmp/*
" Make Vim able to edit crontab files again.
" set backupskip+=,/private/tmp/*"
" if has('mac')
"   augroup dkomac
"     autocmd!
"     autocmd vimrc   BufEnter  /private/tmp/crontab.*  setlocal backupcopy=yes
"   augroup END
" endif
" execute 'set backupdir=~/.tmp/backup//'
" set backup

" undo files
" double slash means create dir structure to mirror file's path
set undofile
set undolevels=1000
set undoreload=10000
execute 'set undodir=~/.tmp/undo//'

" ----------------------------------------------------------------------------
" Completion -- see also plugins/completion.vim
" ----------------------------------------------------------------------------

set complete-=i                       " don't complete includes
set complete-=t                       " don't complete tags
set completeopt-=preview              " don't open scratch preview
set completeopt+=menu,menuone         " show PUM, even for one thing

" @see <https://github.com/Valloric/YouCompleteMe/blob/master/autoload/youcompleteme.vim#L343>
" if has('patch-7.4.314')
"   set shortmess+=c                    " Disable "Pattern not found" messages
" endif


set splitbelow
set splitright
set fillchars=vert:│                  " Vertical sep for splits (unicode bar)

set hidden                            " remember undo after quitting


" reveal already opened files from the quickfix window instead of opening new
" buffers
set switchbuf=useopen

set nostartofline                     " don't jump to col1 on switch buffer

" ----------------------------------------------------------------------------
" Code folding
" ----------------------------------------------------------------------------

set nofoldenable
set foldcolumn=2
set foldlevel=99                      " show all folds by default
set foldlevelstart=99                 " show all folds by default

" ----------------------------------------------------------------------------
" Trailing whitespace
" ----------------------------------------------------------------------------

set list
set listchars=
set listchars+=tab:→\ 
set listchars+=trail:·
set listchars+=extends:»              " show cut off when nowrap
set listchars+=precedes:«
set listchars+=nbsp:⣿


" ----------------------------------------------------------------------------
" Diffing
" ----------------------------------------------------------------------------

" Note this is += since fillchars was defined in splits
set fillchars+=diff:⣿
set diffopt=vertical                  " Use in vertical diff mode
set diffopt+=filler                   " blank lines to keep sides aligned
set diffopt+=iwhite                   " Ignore whitespace changes

" ----------------------------------------------------------------------------
" Input auto-formatting (global defaults)
" Probably need to update these in after/ftplugin too since ftplugins will
" probably update it.
" ----------------------------------------------------------------------------

set formatoptions=
set formatoptions+=c                  " Auto-wrap comments using textwidth
set formatoptions+=r                  " Continue comments by default
set formatoptions-=o                  " do not continue comment using o or O
set formatoptions+=q                  " continue comments with gq
set formatoptions-=a                  " auto-gq on type in comments?
set formatoptions+=n                  " Recognize numbered lists
set formatoptions+=2                  " Use indent from 2nd line of a paragraph
set formatoptions-=l                  " break lines that are already long?
set formatoptions+=1                  " Break before 1-letter words
" Vim 7.4 only: no // comment when joining commented lines
if v:version >= 704 | set formatoptions+=j | endif

set nrformats-=octal                  " never use octal when <C-x> or <C-a>

" ----------------------------------------------------------------------------
" Whitespace
" ----------------------------------------------------------------------------

set nowrap
set nojoinspaces                      " J command doesn't add extra space

" ----------------------------------------------------------------------------
" Indenting - overridden by indent plugins
" ----------------------------------------------------------------------------

set autoindent                        " indent when creating newline


" for autoindent, use same spaces/tabs mix as previous line, even if
" tabs/spaces are mixed. Helps for docblock, where the block comments have a
" space after the indent to align asterisks
set copyindent


" Try not to change the indent structure on "<<" and ">>" commands. I.e. keep
" block comments aligned with space if there is a space there.
set preserveindent

" Smart detect when in braces and parens. Has annoying side effect that it
" won't indent lines beginning with '#'. Relying on syntax indentexpr instead.
set nosmartindent


" Global setting. I don't edit C-style code all the time so don't default to
" C-style indenting.
set nocindent

" ----------------------------------------------------------------------------
" Tabbing - overridden by editorconfig, after/ftplugin
" ----------------------------------------------------------------------------

set expandtab                         " default to spaces instead of tabs
set shiftwidth=2                      " softtabs are 2 spaces for expandtab

" Alignment tabs are two spaces, and never tabs. Negative means use same as
" shiftwidth (so the 2 actually doesn't matter).
set softtabstop=-2

" real tabs render width. Applicable to HTML, PHP, anything using real tabs.
" I.e., not applicable to JS.
set tabstop=2

" use multiple of shiftwidth when shifting indent levels.
" this is OFF so block comments don't get fudged when using ">>" and "<<"
set noshiftround

" When on, a <Tab> in front of a line inserts blanks according to
" 'shiftwidth'. 'tabstop' or 'softtabstop' is used in other places.
set smarttab

set backspace=indent,eol,start        " bs anything

" ----------------------------------------------------------------------------
" Match and search
" ----------------------------------------------------------------------------

set matchtime=1                       " tenths of a sec
set showmatch                         " briefly jump to matching paren?
set hlsearch
set incsearch
set wrapscan                          " Searches wrap around end of the file.
set ignorecase
set smartcase

" The Silver Searcher
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
endif


" ============================================================================
" Plugins: Disable distributed plugins
" To re-enable you have to comment them out (checks if defined, not if truthy)
" ============================================================================

let g:loaded_2html_plugin = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_gzip = 1
let g:loaded_LogiPat = 1
let g:loaded_tarPlugin = 1
let g:loaded_zipPlugin = 1




call plug#begin()

" let s:dko_use_colorv    = 1 " && (has('python') || has('python3'))

Plug 'jaxbot/semantic-highlight.vim'
Plug 'othree/yajs.vim'
Plug 'othree/es.next.syntax.vim'
Plug 'othree/jsdoc-syntax.vim'
Plug 'heavenshell/vim-jsdoc'
Plug 'Shougo/deoplete.nvim'
Plug '1995eaton/vim-better-javascript-completion'
" Plug 'marijnh/tern_for_vim', { 'do': 'npm install' }
" Plug 'othree/jspc.vim'
Plug 'moll/vim-node'
Plug 'benekastah/neomake'
Plug 'scwood/vim-hybrid'
Plug 'Mizuchi/vim-ranger'
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'moskytw/nginx-contrib-vim'
Plug 'JulesWang/css.vim'
\| Plug 'hail2u/vim-css3-syntax'
\| Plug 'cakebaker/scss-syntax.vim'

" ----------------------------------------
" Features
" ----------------------------------------

" Hex (et al) color highlighting
" if s:dko_use_colorv | Plug 'Rykka/colorv.vim'
" else                | Plug 'ap/vim-css-color'
" "else                | Plug 'chrisbra/Colorizer'
" endif

" Omnicompletion
Plug 'othree/csscomplete.vim'
Plug 'ingydotnet/yaml-vim'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-colorscheme-switcher'
Plug 'vim-scripts/zoom.vim'
Plug 'scrooloose/syntastic'

" themes
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'notpratheek/vim-luna'
Plug 'notpratheek/vim-sol'
Plug 'zandrmartin/vim-distill'
Plug 'freeo/vim-kalisi'
Plug 'easysid/mod8.vim'
Plug 'mhartington/oceanic-next'
call plug#end()

let g:airline_powerline_fonts = 1
let g:airline_theme = 'oceanicnext'


syntax on
colorscheme OceanicNext

" Neovim-qt Guifont command
command -nargs=? Guifont call rpcnotify(0, 'Gui', 'SetFont', "<args>") | let g:Guifont="<args>"
" Set the font to DejaVu Sans Mono:h13
Guifont Fira Code:h13

nmap <leader>.. :e .<CR>
nmap <leader>_d :e $MYVIMRC<CR>
nmap <leader>_r :so $MYVIMRC<CR>
nmap <leader>b] :bnext<CR>
nmap <leader>b[ :bprevious<CR>
nmap <Leader>sc :noh<CR>


set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']



