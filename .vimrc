call plug#begin()
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'SirVer/ultisnips'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'ervandew/supertab'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --go-completer' }
Plug 'ntpeters/vim-better-whitespace'
Plug 'artur-shaik/vim-javacomplete2'
Plug 'google/vim-codefmt'
Plug 'google/vim-maktaba'
Plug 'google/vim-glaive'
Plug 'honza/vim-snippets'
Plug 'apalmer1377/factorus'
"Plug 'Shougo/deoplete.nvim'
"Plug 'zchee/deoplete-go', { 'do': 'make'}
call plug#end()
" the glaive#Install() should go after the "call vundle#end()"
call glaive#Install()
" Optional: Enable codefmt's default mappings on the <Leader>= prefix.
Glaive codefmt plugin[mappings]
Glaive codefmt google_java_executable="java -jar /home/huabing/tools/google-java-format-1.7-all-deps.jar"
" Tagbar"
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

" deoplete.nvim recommend
set completeopt+=noselect

" Run deoplete.nvim automatically
let g:deoplete#enable_at_startup = 1
" deoplete-go settings
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']

silent! nmap <F2> :NERDTreeToggle<CR>
silent! map <F3> :NERDTreeFind<CR>
silent! map <F4> :TagbarToggle<CR>

" Solve conflicts between ycm and ultisnip
"let g:ycm_key_list_select_completion=[]
"let g:ycm_key_list_previous_completion=[]

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
set encoding=utf-8

" configruation for Java
" javacomplete2
autocmd FileType java setlocal omnifunc=javacomplete#Complete
" To enable smart (trying to guess import option) inserting class imports with F4, add:
"nmap <F8> <Plug>(JavaComplete-Imports-AddSmart)
"imap <F8> <Plug>(JavaComplete-Imports-AddSmart)
"To enable usual (will ask for import option) inserting class imports with F5, add:
"nmap <F5> <Plug>(JavaComplete-Imports-Add)
"imap <F5> <Plug>(JavaComplete-Imports-Add)
"To add all missing imports with F6:
nmap <F6> <Plug>(JavaComplete-Imports-AddMissing)
imap <F6> <Plug>(JavaComplete-Imports-AddMissing)
"To remove all unused imports with F7:
nmap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)
imap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)

map <F5> :w<CR> :call CompileJava()<CR>
function CompileJava()
    let mp = &makeprg
    let ef = &errorformat
    let exeFile = expand("%:t")
    setlocal makeprg=javac\ %
    set efm=%A%f:%l:\ %m,%-Z%p^,%-C%.%#
    silent make %
    copen
    let &makeprg = mp
    let &errorformat = ef
endfunction


set tags=./tags,tags,/usr/lib/jvm/openjdk-8/tags;

