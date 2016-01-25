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
    NeoBundle 'Shougo/vimproc.vim', {
			    \ 'build' : {
			    \     'windows' : 'tools\\update-dll-mingw',
			    \     'cygwin' : 'make -f make_cygwin.mak',
			    \     'mac' : 'make',
			    \     'linux' : 'make',
			    \     'unix' : 'gmake',
			    \    },
			    \ }
    NeoBundle 'altercation/vim-colors-solarized'
    NeoBundle 'tpope/vim-surround'
    NeoBundle 'kana/vim-altercmd'
    " NeoBundle 'Townk/vim-autoclose'
    NeoBundle 'thinca/vim-quickrun'
    NeoBundle 'nathanaelkane/vim-indent-guides'
    NeoBundle 'scrooloose/syntastic'
    NeoBundle 'tomtom/tcomment_vim'
    NeoBundle 'fuenor/im_control.vim'
    NeoBundle 'Shougo/neocomplcache'
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
    NeoBundleLazy 'vim-jp/cpp-vim', {
                \ 'autoload' : {'filetypes' : 'cpp'}
                \ }
    NeoBundle 'Shougo/neosnippet'
    NeoBundleLazy 'osyo-manga/vim-marching', {
                \ 'autoload' : {'filetypes' : ['c', 'cpp']}
                \ }
    " NeoBundle 'jmcantrell/vim-virtualenv'
    " Neobundle 'scrooloose/nerdtree'
call neobundle#end()
"neobundlecheck
"}}}1
" basic settings{{{1
filetype plugin indent on
syntax enable
set background=light
let g:solarized_termcolors=256
colorscheme solarized
" colorscheme koehler
runtime macros/matchit.vim

set backspace=indent,eol,start
set foldmethod=marker
set modeline
set modelines=3
set number
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
"ctags settings{{{1
autocmd BufWritePost *.h call system("ctags -R")
autocmd BufWritePost *.c call system("ctags -R")
autocmd BufWritePost *.cpp call system("ctags -R")
"}}}
" altercmd settings{{{1
call altercmd#load()
AlterCommand E Explore
"}}}1
" neocomplete settings{{{1
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Enable heavy features.
" Use camel case completion.
"let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
"let g:neocomplcache_enable_underbar_completion = 1

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplcache_enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplcache_enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_force_omni_patterns')
  let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_force_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_force_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_force_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplcache_force_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
if !exists('g:neocomplete#force_omni_input_patterns')
	let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.cpp =
	\ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
" }}}1
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
let g:jedi#rename_command = '<leader>r'
let g:jedi#auto_vim_configuration = 0
let g:jedi#popup_select_first = 0
let g:jedi#use_tabs_not_buffers = 1
let g:jedi#popup_on_dot = 0
let g:jedi#show_call_signatures = "2"
autocmd FileType python setlocal completeopt-=preview
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
"im_control settings{{{1
if has('mac')
  if has('gui_running')
    let IM_CtrlMode = 4
  else
    let IM_CtrlMode = 1

    function! IMCtrl(cmd)
      let cmd = a:cmd
      if cmd == 'On'
        let res = system('osascript -e "tell application \"System Events\" to keystroke (key code {104})" > /dev/null 2>&1')
      elseif cmd == 'Off'
        let res = system('osascript -e "tell application \"System Events\" to keystroke (key code {102})" > /dev/null 2>&1')
      elseif cmd == 'Toggle'
        let res = system('osascript -e "tell application \"System Events\" to keystroke (key code {55, 49})" > /dev/null 2>&1')
      endif
      return ''
    endfunction
  endif

  " 「日本語入力固定モード」のMacVimKaoriya対策を無効化
  " let IM_CtrlMacVimKaoriya = 0
  " ctrl+jで日本語入力固定モードをOnOff
  inoremap <silent> <UP> <C-^><C-r>=IMState('FixMode')<CR>
endif
"}}}1
"cpp-path settings{{{
augroup cpp-path
	autocmd!
	autocmd FileType cpp setlocal path=.,/opt/intel//compilers_and_libraries_2016.1.111/mac/mkl/include,/usr/local/Cellar/eigen/3.2.6/include,/usr/local/Cellar/boost/1.57.0/include,.,/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/../include/c++/v1,/usr/local/include,/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/../lib/clang/7.0.2/include,/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include,/usr/include,/System/Library/Frameworks,/Library/Frameworks,/usr/local/opt
augroup END
"}}}
