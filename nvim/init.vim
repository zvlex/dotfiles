if &compatible
  set nocompatible
end

"******************************
"" Plugins
"******************************
call plug#begin('~/.vim/plugged')

" Appearance
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mhinz/vim-startify'
Plug 'chriskempson/base16-vim'

Plug 'joshdick/onedark.vim'
Plug 'w0ng/vim-hybrid'
Plug 'the31k/vim-colors-tayra'

" Search files
Plug 'ctrlpvim/ctrlp.vim'

" Ruby
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-bundler'
Plug 'thoughtbot/vim-rspec'
Plug 'ecomba/vim-ruby-refactoring'
Plug 'tpope/vim-endwise'
Plug 'ngmy/vim-rubocop'

" JavaScript
Plug 'pangloss/vim-javascript'
Plug 'mustache/vim-mustache-handlebars'
Plug 'elzr/vim-json'

" Vue.js
Plug 'darthmall/vim-vue'

" React js
Plug 'mxw/vim-jsx'

" CoffeeScript
Plug 'kchmck/vim-coffee-script'

" Racket
Plug 'wlangstroth/vim-racket'

" Golang
Plug 'fatih/vim-go'
Plug 'nsf/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }

Plug 'Shougo/deoplete.nvim'
Plug 'zchee/deoplete-go', { 'do': 'make'}

" Elixir
Plug 'elixir-lang/vim-elixir'

" Crystal
Plug 'rhysd/vim-crystal'

" Markup
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-haml'
Plug 'slim-template/vim-slim'
Plug 'gorodinskiy/vim-coloresque'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/gv.vim'
Plug 'mattn/gist-vim'

" Auto-Complete
" Plug 'Valloric/YouCompleteMe'

" Ctags
Plug 'majutsushi/tagbar'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Etc
Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround' " easily delete, change and add such surroundings in pairs
Plug 'Raimondi/delimitMate' " auto-completion for quotes, parens, brackets
Plug 'tpope/vim-commentary'
Plug 'bronson/vim-trailing-whitespace'
Plug 'scrooloose/syntastic'
Plug 'rking/ag.vim'
Plug 'bogado/file-line'
Plug 'stephpy/vim-yaml'

Plug 'benmills/vimux'

call plug#end()

"******************************
"" Visual Settings
"******************************
syntax on

filetype plugin indent on

set number
set numberwidth=5

set showcmd
set ttyfast
set hidden

set ruler
set mouse=a

set wildmenu " visual autocomplete for command menu"

set fileformats=unix,dos,mac

" Fix slow scrolling!
" http://eduncan911.com/software/fix-slow-scrolling-in-vim-and-neovim.html
set lazyredraw
set cursorline!

set background=dark
colorscheme hybrid " tayra  onedark

set title
set titleold="Terminal"
set titlestring=%F

" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

" Fix backspace indent
set backspace=indent,eol,start

" Cyrillic mapping
set langmap=??????????????????????????????????????????????????????????????????????????????H????????????????????????????????????????????????????;`qwertyuiop[]asdfghjkl\\;'zxcvbnm\\,.~QWERTYUIOP{}ASDFGHJKL:\\"ZXCVBNM<>

"
set laststatus=2
set autoread

" Replace Tabs with Spaces
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent

" Do not create swap files
set nobackup
set noswapfile

" vim airline
let g:airline_theme = 'base16_default'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#hunks#enabled = 0

set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

" ctrlp.vim
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist)|(\.(swp|tox|ico|git|hg|svn|cache))$'
let g:ctrlp_use_caching = 0

" Emmet
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

" syntastic
let g:syntastic_always_populate_loc_list=1
let g:syntastic_error_symbol='???'
let g:syntastic_warning_symbol='???'
let g:syntastic_style_error_symbol = '???'
let g:syntastic_style_warning_symbol = '???'
let g:syntastic_auto_loc_list=1
let g:syntastic_aggregate_errors = 1

" Racket
let g:syntastic_enable_racket_racket_checker = 1

" GitGutter Turn off default keys
let g:gitgutter_map_keys = 0

" NERDTree
let NERDTreeShowHidden=1

" RSpec
let g:rspec_command = "!rspec --color --require spec_helper {spec}"

" AG
let g:ag_working_path_mode="r"

" Enable autocomplete
let g:deoplete#enable_at_startup = 1

" Let <Tab> also do completion
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" Close the documentation window when completion is done
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" Golang
set completeopt+=noinsert
set completeopt+=noselect

let g:python3_host_prog  = '/usr/bin/python3.5'
let g:python3_host_skip_check = 1

let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let g:syntastic_go_checkers = ['govet', 'errcheck', 'go']

"******************************
"" Autocmd Rules
"******************************
augroup vimrc-sync-fromstart
  autocmd!
  autocmd BufEnter * :syntax sync fromstart
augroup END

" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

" make/cmake
augroup vimrc-make-cmake
  autocmd!
  autocmd FileType make setlocal noexpandtab
  autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
augroup END

"
augroup vimrc-ruby
  autocmd!
  autocmd BufNewFile,BufRead *.rb,*.rbw,*.gemspec setlocal filetype=ruby
  autocmd FileType ruby set tabstop=2|set shiftwidth=2|set expandtab
augroup END

"******************************
"" Mappings
"******************************

" <Leader>
let mapleader=","

" Shell
set shell=/bin/zsh

" Split
noremap ,h :split<CR>
noremap ,v :vsplit<CR>

" NERDTree configuration
nnoremap <F3> :NERDTreeToggle<CR>

" Ctags
nmap <F8> :TagbarToggle<CR>

" no one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

" snippets
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<C-b>"
let g:UltiSnipsJumpBackwardTrigger="<C-z>"
let g:UltiSnipsEditSplit="vertical"

" RSpec.vim
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

" RuboCop
let g:vimrubocop_keymap = 0
nmap <Leader>r :RuboCop<CR>

" Emacs keybindings
" map <C-b> <Left>
" map <C-f> <Right>
" map <C-a> <Home> <S-I>
" map <C-e> <S-A>
" map <C-@> v

" imap <C-a> <Home>
" imap <C-e> <End>

"******************************
" Airline customizations
"******************************

" vim-airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

if !exists('g:airline_powerline_fonts')
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline_left_sep          = '???'
  let g:airline_left_alt_sep      = '??'
  let g:airline_right_sep         = '???'
  let g:airline_right_alt_sep     = '??'
  let g:airline#extensions#branch#prefix     = '???' "???, ???, ???
  let g:airline#extensions#readonly#symbol   = '???'
  let g:airline#extensions#linecolumn#prefix = '??'
  let g:airline#extensions#paste#symbol      = '??'
  let g:airline_symbols.linenr    = '???'
  let g:airline_symbols.branch    = '??? '
  let g:airline_symbols.paste     = '??'
  let g:airline_symbols.paste     = '??'
  let g:airline_symbols.paste     = '???'
  let g:airline_symbols.whitespace = '??'
else
  let g:airline#extensions#tabline#left_sep = '???'
  let g:airline#extensions#tabline#left_alt_sep = '???'

  " powerline symbols
  let g:airline_left_sep = '???'
  let g:airline_left_alt_sep = '???'
  let g:airline_right_sep = '???'
  let g:airline_right_alt_sep = '???'
  let g:airline_symbols.branch = '???'
  let g:airline_symbols.readonly = '???'
  let g:airline_symbols.linenr = '???'
endif
