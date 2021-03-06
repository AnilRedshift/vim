set nocompatible
execute pathogen#infect()
call pathogen#helptags()
set t_Co=256
set runtimepath+=~/.vim/autoupload,~/.vim/bundle
set tabstop=4 
set softtabstop=4
set shiftwidth=4
set expandtab
filetype plugin indent on
set wrap
set mouse=a
set number
set title
set nocp
syntax enable
set background=dark
colorscheme solarized
set smartcase " ignore case if search pattern is all lowercase
set smarttab
set hlsearch " highlight search terms
set incsearch " show search terms as you type
let mapleader = ","

" quickly edit vimrc
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>rv :so $MYVIMRC<CR>
set modelines=0

function RunTests()
    let path_to_use = expand('%:h')
    let file_name = expand('%:t')
    let test_name = path_to_use . "/" . "test_" . file_name
    execute "! python -m unittest " . test_name
endfunction

set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>
set wrap
set textwidth=119
set formatoptions=qrn1
set colorcolumn=125

" set list
" set listchars=tab:>.
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
cmap w!! w !sudo tee % >/dev/null " Allows saving sudo files with w!!
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
set tags=./tags;/

au FileType python setlocal formatprg=autopep8\ -
set makeprg=python\ %
nmap <F4> :Bexec <CR>:wincmd k <CR>:bd!
nmap <F5> :call RunTests() <CR>
set autowrite
set completeopt=menu
" pymode settings
let g:pymode_folding = 0
let g:autopep8_max_line_length=120
let g:pymode_options_max_line_length=120
let g:pymode_lint_options_pylint = {'max-line-length': g:pymode_options_max_line_length}
let g:autopep8_aggressive=1
let g:autopep8_disable_show_diff=1
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_bind = '<leader>b'
let g:pymode_lint_message = 1
let g:pymode_rope = 1
let g:pymode_python = 'python3'
let g:virtualenv_directory = '/Users/anil.virtualenvs'

" command-t options
let g:RootIgnoreUseHome = 1
let g:RootIgnoreAgignore = 1
let g:CommandTTraverseSCM = 'pwd'

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

function! OpenFiles(search_string)
    let shellcmd = 'ag -l '.a:search_string
    let output = system(shellcmd)
    if v:shell_error
        return 1
    endif

    let lines = split(output)
    for line in lines
        execute 'edit' line
    endfor
endfunction

command! -nargs=1 OpenFilesCommand call OpenFiles(<f-args>)

map <leader>o :OpenFilesCommand 
