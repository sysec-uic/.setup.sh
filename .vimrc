" Basic Settings
set nocompatible            " Disable compatibility with old Vim
set backspace=indent,eol,start  " Make backspace behave like modern editors
set clipboard=unnamedplus   " Use system clipboard
set encoding=utf-8          " Ensure UTF-8 encoding
set fileencoding=utf-8      " File encoding

" Interface
set number                  " Show line numbers
set relativenumber          " Enable relative line numbers
set cursorline              " Highlight the current line
set showcmd                 " Show partial commands in the last line
set showmatch               " Highlight matching parentheses
set wildmenu                " Enhanced command-line completion
set title                   " Show file title in terminal title
set ruler                   " Show cursor position

" Appearance
set background=dark         " Optimize for dark terminal themes
syntax on                   " Enable syntax highlighting
set termguicolors           " Enable 24-bit color in supported terminals
set laststatus=2            " Always show status line
set signcolumn=yes          " Always show the sign column

" Tabs and Indentation
set tabstop=4               " Number of spaces per tab
set shiftwidth=4            " Number of spaces for autoindent
set expandtab               " Use spaces instead of tabs
set autoindent              " Auto-indent new lines

" Search
set hlsearch                " Highlight search matches
set incsearch               " Incremental search
set ignorecase              " Ignore case in search...
set smartcase               " ...unless uppercase is used

" Scrolling and Splits
set scrolloff=8             " Keep 8 lines visible above/below cursor
set sidescrolloff=8         " Keep 8 columns visible left/right of cursor
set splitbelow              " Open horizontal splits below
set splitright              " Open vertical splits to the right

" Enable automatic text wrapping
set wrap               " Enable wrapping of lines longer than the screen width
set textwidth=80       " Automatically insert line breaks at 80 characters
set formatoptions+=t   " Auto-wrap text when typing
set linebreak          " Break lines at word boundaries instead of mid-word
set showbreak=>>       " Add a visual indicator for wrapped lines
set colorcolumn=80     " Show a vertical line at column 80
highlight ColorColumn ctermbg=darkgrey guibg=lightgrey

" Remember last cursor position
if has("autocmd")
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
endif

" Undo and Backup
"set undofile                " Enable persistent undo
"set backup                  " Enable backups
"set backupdir=~/.vim/backup " Set backup directory
"set directory=~/.vim/swap   " Set swap file directory

" Better Navigation
nnoremap <C-j> :cnext<CR>   " Jump to the next search match
nnoremap <C-k> :cprev<CR>   " Jump to the previous search match
set timeoutlen=500          " Shorten timeout for key sequences

" Plugin Support
filetype plugin indent on   " Enable filetype detection, plugins, and indentation

" Folding
set foldmethod=syntax       " Enable syntax-based folding
set foldlevelstart=99       " Open folds by default

" Key Mappings
nnoremap <Space> :noh<CR>   " Clear search highlighting with Space
nnoremap <C-n> :Ex<CR>      " File Explorer with Ctrl-n

" Performance
set lazyredraw              " Improve performance for macros and scripts
set ttyfast                 " Faster rendering in terminal

" Plugins (Example for Vim-Plug or similar plugin managers)
call plug#begin('~/.vim/plugged')

" Example plugins
Plug 'preservim/nerdtree'        " File explorer
Plug 'junegunn/fzf.vim'          " Fuzzy finder
Plug 'tpope/vim-fugitive'        " Git integration
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Enhanced syntax highlighting
Plug 'airblade/vim-gitgutter'    " Git diff signs in the gutter
Plug 'vim-airline/vim-airline'   " Status line
Plug 'vivien/vim-linux-coding-style'
Plug 'dr-kino/cscope-maps'
"Plug 'ycm-core/YouCompleteMe', { 'do': './install.py' }

call plug#end()

" NERDTree keybinding
nnoremap <C-t> :NERDTreeToggle<CR>

" Airline themes (optional)
let g:airline_theme = 'dark'

" Custom Colorscheme (set your preferred theme)
colorscheme desert  " Replace with your favorite theme
