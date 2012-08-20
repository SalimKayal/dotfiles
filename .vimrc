set nocompatible
set bs=2
let $PAGER=''

set ofu=syntaxcomplete#Complete
syntax on
set number
set hidden
set hlsearch
set incsearch
"set mouse=a
set scrolloff=5
set smartindent
set autoindent
set expandtab
set tabstop=2
set shiftwidth=2
set linebreak
set showcmd
set guioptions+=lrb
set guioptions-=lrb
set guioptions+=LRB
set guioptions-=LRB
set guioptions-=T
set guioptions-=m
"               buffer   file                      position     rel   HEX   ASCII
set statusline=%<[%02n]\ %F%(\ %m%h%w%y%r%)\ %a%=\ %8l,%c%V/%L\ (%P)\ [%08O:%02B]

"autosource vimrc on leave
au BufWritePost $MYVIMRC :source $MYVIMRC

"______________vundle options______________"
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
"set rtp+=~/.vim/bundle/pyclewn
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
Bundle 'tpope/vim-fugitive'
Bundle 'xolox/vim-lua-ftplugin'
Bundle 'xolox/vim-lua-inspect.git'
Bundle 'Rip-Rip/clang_complete'
Bundle 'msanders/snipmate.vim'
Bundle 'ervandew/supertab'
Bundle 'vim-scripts/TaskList.vim'
Bundle 'vim-scripts/luarefvim'

" repos on vim.org
Bundle 'matchit.zip'
Bundle 'PreciseJump'
Bundle 'pythoncomplete'

"to avoid cleaning
Bundle 'pyclewn'
Bundle 'pyclewn-bin'

filetype plugin indent on     " required!

"_____________c,c++,java,objc______________"

autocmd Filetype c,cpp,cs,java,objc set cindent
autocmd Filetype c,cpp,cs,java,objc set cst csto=0
autocmd Filetype c,cpp,cs,java,objc set cinkeys=0{,0},:,0#,!^F
autocmd FileType c,cpp,cs,java,objc set foldmethod=syntax
autocmd FileType c,cpp,cs,java,objc set tags=~/.vim/Tags/stl.tags
" Disable auto popup, use <Tab> to autocomplete
autocmd FileType c,cpp,cs,java,objc let g:clang_complete_auto = 1
" Show clang errors in the quickfix window
autocmd FileType c,cpp,cs,java,objc let g:clang_complete_copen = 1
autocmd FileType c,cpp,cs,java,objc let g:clang_complete_snippets = 1
autocmd FileType c,cpp,cs,java,objc let g:clang_complete_snippets_engine = 'snipmate'
"let g:clang_complete_patterns = 1
"let g:clang_periodic_quickfix = 1

"__________________python__________________"

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType python set foldmethod=indent
autocmd FileType python map <F5> :!python %<CR>
"___________________lua____________________"
autocmd FileType lua set foldmethod=indent
autocmd FileType lua let g:lua_compiler_name = '/idiap/home/skayal/bin/luac'
autocmd FileType lua let g:lua_complete_omni = 0
autocmd FileType lua let g:lua_path = './?.lua;/remote/filer.gx/home.active/skayal/share/torch/lua/?.lua;/remote/filer.gx/home.active/skayal/share/torch/lua/?/init.lua;/remote/filer.gx/home.active/skayal/lib/torch/?.lua;/remote/filer.gx/home.active/skayal/lib/torch/?/init.lua'
autocmd FileType lua let g:lua_complete_keywords = 1
autocmd FileType lua let g:lua_complete_globals = 1
autocmd FileType lua let g:lua_complete_library = 1
autocmd FileType lua set tags=lua.tags
autocmd FileType lua map <F5> :!torch %<CR>
"___________toggle auto-escape_____________"
let s:on = 0

function! ToggleAutoEsc()
   let &updatetime = 5000
   let s:on = !s:on
   exec "au".((s:on)?"":"!") "CursorHoldI *" ((s:on)?"stopinsert":"")
endfunction

nmap <leader>e :call ToggleAutoEsc()<cr>
call ToggleAutoEsc()
"__________________________________________"

map à :buffers<CR>:b 
map ô :buffers<CR>:vertical sb 
map <C-h> :bp<CR>
map <C-l> :bn<CR>
map tb :e [Temporary buffer]<CR>:set buftype=nofile<CR>:set bufhidden=hide<CR>:setlocal noswapfile<CR>
map vtb :vs [Temporary buffer]<CR>:set buftype=nofile<CR>:set bufhidden=hide<CR>:setlocal noswapfile<CR>

"________windows navigation mappings_______"
map <Left> <C-w>h
map <Down> <C-w>j
map <Up> <C-w>k
map <Right> <C-w>l
map <C-Left> <C-w>H
map <C-Down> <C-w>J
map <C-Up> <C-w>K
map <C-Right> <C-w>L

"_______navigation mapping for dvorak______"
nnoremap q h
nnoremap Q H
nnoremap h x
nnoremap H X
nnoremap x l
nnoremap X L
nnoremap l q
nnoremap L Q
vnoremap q h
vnoremap Q H
vnoremap h x
vnoremap H X
vnoremap x l
vnoremap X L
vnoremap l q
vnoremap L Q

"_____________custom mappings______________"
nnoremap ; :
nnoremap ;; ;
vnoremap ; :
vnoremap ;; ;
"_________________colorschemes_____________"
colorscheme murphy
hi Folded guibg=#151515

if !has("gui_running")
  colorscheme zellner
  set background=dark
  set t_Co=256
endif

set tags+=tags;
map <C-F12> :!ctags -R --sort=yes --c++-kinds=+pl --fields=+iaS --extra=+q .<CR>

au BufNewFile,BufRead *.plt,.gnuplot setf gnuplot

let g:pyclewn_args="-w bottom"

let g:SuperTabDefaultCompletionType = "context"

au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview

function! ToggleNumbers()
  if &nu == 1
    set rnu
  elseif &rnu == 1
    set nu
  else
    set nu
  endif
endfunction

map <leader>n :call ToggleNumbers()<cr>

map vrc :tabnew $MYVIMRC<CR>
