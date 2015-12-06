"NeoBundle settings{{{1
if 0 | endif
if has('vim_starting')
    if &compatible
        set nocompatible
    endif
    " Required:
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))
" Let NeoBundle manage NeoBundle
" Required:
    NeoBundleFetch 'Shougo/neobundle.vim'
    NeoBundle 'tpope/vim-surround'
    NeoBundle 'kana/vim-altercmd'
    NeoBundle 'Townk/vim-autoclose'
    NeoBundle 'thinca/vim-quickrun'
    NeoBundle 'nathanaelkane/vim-indent-guides'
    NeoBundle 'scrooloose/syntastic'
    NeoBundle 'tomtom/tcomment_vim'
    NeoBundleLazy 'tell-k/vim-autopep8',{
                \ "autoload" : { "filetypes" : ["python"] }}
    NeoBundleLazy 'davidhalter/jedi-vim',{
                \ "autoload" : { "filetypes" : ["python"] }}
    "NeoBundle 'jmcantrell/vim-virtualenv'
    "NeoBundle 'scrooloose/nerdtree'
call neobundle#end()
"NeoBundleCheck
"}}}1
" basic settings{{{1
filetype plugin indent on
colorscheme koehler
syntax on
runtime macros/matchit.vim
set foldmethod=indent
set foldlevel=0
set foldcolumn=3
set modeline
set modelines=3
set number
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set autoindent
set expandtab
set wildmenu
set smartcase
"set hls
set incsearch
set nrformats=
set ruler
set showmode
"}}}1
" remap settings{{{1
inoremap <C-f> <Right>
"inoremap <C-b> <Left>
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
noremap qr :QuickRun<CR>
"nnoremap / /\v
"}}}1
" altercmd settings{{{1
call altercmd#load()
"AlterCommand qr QuickRun
AlterCommand E Explore
" vim-indent-guides
let g:indent_guides_auto_colors=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd   ctermbg=110
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  ctermbg=140
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=1
let g:syntastic_check_on_wq = 0
"}}}1
"syntastic settings{{{1
"pep8,pyflakes
let g:syntastic_python_python_exec = '/Library/Frameworks/Python.framework/Versions/3.4/bin/python3'
let g:syntastic_python_checkers = ['pyflakes', 'pep8']

function! s:Exec()
    exe "!" . &ft . " %"        
:endfunction         
command! Exec call <SID>Exec() 
map <silent> <C-p> :call <SID>Exec()<CR>
"}}}1
"jedi-vim settings{{{1
let s:bundle = neobundle#get('jedi-vim')
function! s:bundle.hooks.on_source(bundle)
"let g:jedi#rename_command = '<Leader>R'
endfunction
"}}}1

" vim: foldmethod=marker
" vim: foldcolumn=3
" vim: foldlevel=0
