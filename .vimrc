call plug#begin()
Plug 'davidhalter/jedi'
Plug 'davidhalter/jedi-vim'
Plug 'godlygeek/tabular'
Plug 'ervandew/supertab'
Plug 'vim-ruby/vim-ruby'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'hynek/vim-python-pep8-indent'
Plug 'altercation/vim-colors-solarized'
Plug 'slim-template/vim-slim'
Plug 'avakhov/vim-yaml'
Plug 'skywind3000/asyncrun.vim'
Plug 'python-mode/python-mode'
Plug 'leafgarland/typescript-vim'
Plug 'fatih/vim-go'
Plug 'pangloss/vim-javascript'
Plug 'Yggdroot/indentLine'
Plug 'pearofducks/ansible-vim'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'hashivim/vim-terraform'
Plug 'glench/vim-jinja2-syntax'
Plug 'mitsuhiko/jinja2'
call plug#end()

syntax on
set nocompatible              " required
set laststatus=2
set expandtab    " Turn tab into spaces
set number       " Turn on numbering of lines
set showmatch    " Show matching brackets.
set matchtime=5  " Bracket blinking.
set noshowmode   " Shows vim mode
set list
set ruler
set backspace=indent,eol,start

autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2
autocmd FileType go setlocal expandtab shiftwidth=4 tabstop=4
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype javascript setlocal ts=4 sts=4 sw=4

let g:solarized_termcolors=256
if &diff
    colorscheme lucius
endif

function! Render_Only_File(...)
  let builder = a:1
  let context = a:2

  call builder.add_section('file', '!! %F')

  return 0   " the default: draw the rest of the statusline
  return -1  " do not modify the statusline
  return 1   " modify the statusline with the current contents of the builder
endfunction
call airline#add_inactive_statusline_func('Render_Only_File')
" Color Skin"
syntax enable
"set background=dark
"colorscheme solarized

"Python-mode
"Activate rope
"Keys:
"K             Show python docs
"<Ctrl-Space>  Rope autocomplete
"<Ctrl-c>g     Rope goto definition
"<Ctrl-c>d     Rope show documentation
"<Ctrl-c>f     Rope find occurrences
"<Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled)
"[[            Jump on previous class or function (normal, visual, operator modes)
"]]            Jump on next class or function (normal, visual, operator modes)
"[M            Jump on previous class or method (normal, visual, operator modes)
"]M            Jump on next class or method (normal, visual, operator modes)
map <C-n> :NERDTreeToggle<CR>
let g:pymode_rope = 0

" Documentation
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'

"Linting
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
" Auto check on save
let g:pymode_lint_write = 1

" Support virtualenv
let g:pymode_virtualenv = 1

" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_bind = '<leader>b'

" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1
let g:NERDTreeWinPos = "right"

" Don't autofold code
let g:pymode_folding = 0


" All of your Plugins must be added before the following line
filetype plugin indent on    " required
augroup vimrc_autocmds
    autocmd!
    " highlight characters past column 120
    autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType python match Excess /\%120v.*/
    autocmd FileType python set nowrap
augroup END

augroup javascript_folding
    au!
    au FileType javascript setlocal foldmethod=syntax
augroup END

" Quick run via <F5>
nnoremap <F5> :call <SID>compile_and_run()<CR>
nnoremap <silent> <F7> :NERDTree<CR>

augroup SPACEVIM_ASYNCRUN
    autocmd!
    " Automatically open the quickfix window
    autocmd User AsyncRunStart call asyncrun#quickfix_toggle(15, 1)
augroup END

function! s:compile_and_run()
    exec 'w'
    if &filetype == 'c'
        exec "AsyncRun! gcc % -o %<; time ./%<"
    elseif &filetype == 'cpp'
       exec "AsyncRun! g++ -std=c++11 % -o %<; time ./%<"
    elseif &filetype == 'java'
       exec "AsyncRun! javac %; time java %<"
    elseif &filetype == 'sh'
       exec "AsyncRun! time bash %"
    elseif &filetype == 'python'
       exec "AsyncRun! time python %"
    elseif &filetype = 'go'
       exec "AsyncRun! time go-run"
    endif
endfunction
