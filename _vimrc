" function! IncludePath(path)
"     define delimiter depends on platform
"     if has('win16') || has('win32') || has('win64')
"         let delimiter = ";"
"     else
"         let delimiter = ":"
"     endif
"     let pathlist = split($PATH, delimiter)
"     if isdirectory(a:path) && index(pathlist, a:path) == -1
"         let $PATH=a:path.delimiter.$PATH
"     endif
" endfunction

" ~/.pyenv/shims を $PATH に追加する
" これを行わないとpythonが正しく検索されない
" IncludePath(expand("~/.pyenv/shims"))
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
    NeoBundle 'altercation/vim-colors-solarized'
    NeoBundle 'tpope/vim-surround'
    NeoBundle 'kana/vim-altercmd'
    " NeoBundle 'Townk/vim-autoclose'
    NeoBundle 'thinca/vim-quickrun'
    NeoBundle 'nathanaelkane/vim-indent-guides'
    NeoBundle 'scrooloose/syntastic'
    NeoBundle 'tomtom/tcomment_vim'
    NeoBundleLazy 'tell-k/vim-autopep8',{
          \ "autoload": {
          \   "filetypes": ["python", "python3", "djangohtml"]
          \ }}
    NeoBundleLazy 'davidhalter/jedi-vim',{
          \ "autoload": {
          \   "filetypes": ["python", "python3", "djangohtml"]
          \ }}
    NeoBundleLazy "lambdalisue/vim-pyenv", {
          \ "depends": ['davidhalter/jedi-vim'],
          \ "autoload": {
          \   "filetypes": ["python", "python3", "djangohtml"]
          \ }}
    " NeoBundle 'jmcantrell/vim-virtualenv'
    " Neobundle 'scrooloose/nerdtree'
call neobundle#end()
"neobundlecheck
"}}}1
" basic settings{{{1
filetype plugin indent on
" colorscheme koehler
syntax enable
set background=light
let g:solarized_termcolors=256
colorscheme solarized
runtime macros/matchit.vim
set foldmethod=indent
set foldlevel=1
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
inoremap <c-f> <right>
"inoremap <c-b> <left>
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>
noremap qr :QuickRun<cr>
"nnoremap / /\v
"}}}1
" altercmd settings{{{1
call altercmd#load()
AlterCommand E Explore
"}}}1
" vim-indent-guides{{{1
let g:indent_guides_auto_colors=0
autocmd vimenter,colorscheme * :hi indentguidesodd   ctermbg=110
autocmd vimenter,colorscheme * :hi indentguideseven  ctermbg=140
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=1
let g:syntastic_check_on_wq = 0
"}}}1
"syntastic settings{{{1
"pep8,pyflakes
let g:syntastic_python_python_exec = '/library/frameworks/python.framework/versions/3.4/bin/python3'
let g:syntastic_python_checkers = ['pyflakes', 'pep8']

function! s:Exec()
    exe "!" . &ft . " %"        
:endfunction         
command! Exec call <sid>Exec() 
map <silent> <c-p> :call <sid>Exec()<cr>
"}}}1
"quickrun settings{{{1
let g:quickrun_config = {
            \   "_" : {
            \       "outputter/buffer/split" : ":botright",
            \       "outputter/buffer/close_on_empty" : 1
            \   },
            \}
"}}}1
"jedi-vim settings{{{1
let s:bundle = neobundle#get('jedi-vim')
function! s:bundle.hooks.on_source(bundle)
"let g:jedi#rename_command = '<leader>r'
let g:jedi#auto_vim_configuration = 0
let g:jedi#popup_select_first = 0
endfunction
"}}}1
"vim-pyenv settings{{{1
let s:bundle = neobundle#get('vim-pyenv')
function! s:bundle.hooks.on_source(bundle)
if jedi#init_python()
    function! s:jedi_auto_force_py_version() abort
        let major_version = pyenv#python#get_internal_major_version()
        call jedi#force_py_version(major_version)
    endfunction
    augroup vim-pyenv-custom-augroup
        autocmd! *
        autocmd User vim-pyenv-activate-post   call s:jedi_auto_force_py_version()
        autocmd User vim-pyenv-deactivate-post call s:jedi_auto_force_py_version()
    augroup END
endif
endfunction
"}}}1
"autopep8 settings{{{1
let s:bundle = neobundle#get('vim-autopep8')
function! s:bundle.hooks.on_source(bundle)
let g:autopep8_disable_show_diff=1
endfunction
"}}}}

" vim: foldmethod=marker
" vim: foldcolumn=3
" vim: foldlevel=0
