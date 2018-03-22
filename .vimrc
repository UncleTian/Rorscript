"no compatible with vi"
set nocompatible
"show line"
set number
" hide scroll"    
set guioptions-=r 
set guioptions-=L
set guioptions-=b

vnoremap <Leader>y "+y
nmap <Leader>p "+p

"hide top tag"
set showtabline=0
"set font"
set guifont=DejaVu_Sans_Mono:h14
set guifont=DejaVu\ Sans\ Mono\ 14
syntax on   "enable syntax"
syntax enable
set background=dark   "set background"
set termguicolors
colorscheme material-monokai
set nowrap  "set nowrap line"
set fileformat=unix "fileformat unix 'lf'"
set cindent     "indenct like C"
set autoindent
filetype indent on
filetype plugin on
set expandtab 
set tabstop=2   "set tab size 2"
set shiftwidth=2
set softtabstop=2

set showmatch   "show match parentheses"
set scrolloff=5     "5 rows from the top and bottom"
set laststatus=2    "Command line 2 lines"
set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1
set enc=utf8
set fencs=utf8,gbk,gb2312,gb18030      "file encoding"
set encoding=utf-8
set backspace=2
set mouse=a     "enable mouse"
set selection=exclusive
set selectmode=mouse,key
set clipboard=unnamed
set matchtime=5
set ignorecase      "ignore upper or lower case"
set incsearch
set hlsearch        "search high light"
set noexpandtab     "not allow expand table"
set whichwrap+=<,>,h,l
set autoread
set cursorline      " highlight current line"
set cursorcolumn        "highlight current column"
set nu
set cmdheight=5


"press F5 run python"
map <F5> :Autopep8<CR> :w<CR> :call RunPython()<CR>
function RunPython()
    let mp = &makeprg
    let ef = &errorformat
    let exeFile = expand("%:t")
    setlocal makeprg=python\ -u
    set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
    silent make %
    copen
    let &makeprg = mp
    let &errorformat = ef
endfunction


filetype on
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'Lokaltog/vim-powerline'
Plugin 'scrooloose/nerdtree'
Plugin 'Yggdroot/indentLine'
Plugin 'jiangmiao/auto-pairs'
Plugin 'tell-k/vim-autopep8'
Plugin 'scrooloose/nerdcommenter'
Plugin 'wakatime/vim-wakatime'
Plugin 'skielbasa/vim-material-monokai'
Plugin 'vim-syntastic/syntastic'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'derekwyatt/vim-fswitch'
Plugin 'google/vim-maktaba'
Plugin 'google/vim-codefmt'
Plugin 'google/vim-glaive'
Plugin 'Xuyuanp/nerdtree-git-plugin'
call vundle#end()

call glaive#Install()
Glaive codefmt google_java_executable="java -jar /path/to/google-java-format-VERSION-all-deps.jar"


"YouCompleteMe configuration"
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf=0
set completeopt=longest,menu
let g:ycm_path_to_python_interpreter='/usr/bin/python'
let g:ycm_python_binary_path='/usr/local/bin/python3'
let g:ycm_seed_identifiers_with_syntax=1
let g:ycm_complete_in_comments=1
let g:ycm_collect_identifiers_from_comments_and_strings = 0
let g:ycm_min_num_of_chars_for_completion=2
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_cache_omnifunc=0
let g:ycm_complete_in_strings = 1

"syntastic configuration"
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

autocmd InsertLeave * if pumvisible() == 0|pclose|endif

inoremap <expr> <CR>       pumvisible() ? '<C-y>' : '<CR>'     
inoremap <expr> <Down>     pumvisible() ? '\<C-n>' : '\<Down>'
inoremap <expr> <Up>       pumvisible() ? '\<C-p>' : '\<Up>'
inoremap <expr> <PageDown> pumvisible() ? '\<PageDown>\<C-p>\<C-n>' : '\<PageDown>'
inoremap <expr> <PageUp>   pumvisible() ? '\<PageUp>\<C-p>\<C-n>' : '\<PageUp>'

"NERDTree configuration""
nnoremap <F2> :NERDTreeToggle<CR>
"map <F2> :NERDTreeMirror<CR>":

let NERDTreeChDirMode=1
let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']
let NERDTreeWinSize=25
let NERDTreeShowFiles=1
let NERDTreeShowLineNumbers=1
let NERDTreeShowHidden=0
let NERDTreeHightCursorline=1
let NERDTreeAutoCenter=1
let NERDTreeChristmasTree=1

let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }


"autopep8 configuration"
let g:autopep8_disable_show_diff=1
let g:autopep8_max_line_length=79


let mapleader=','

map <F4> <leader>ci <CR>

"material-monokai configuration"
let g:materialmonokai_subtle_spell=1
let g:materialmonokai_italic=1

"Indent Guides configuration"
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1
nmap <silent> <Leader>i <Plug>IndentGuidesToggle

"vim-fswitch configuration"
nmap <silent> <Leader>sw :FSHere<cr>

"google format"
augroup autoformat_settings
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp,proto,javascript AutoFormatBuffer clang-format
  autocmd FileType dart AutoFormatBuffer dartfmt
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType gn AutoFormatBuffer gn
  autocmd FileType html,css,json AutoFormatBuffer js-beautify
  autocmd FileType java AutoFormatBuffer google-java-format
  autocmd FileType python AutoFormatBuffer yapf
  " Alternative: autocmd FileType python AutoFormatBuffer autopep8
augroup END
