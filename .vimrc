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
set textwidth=79
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

"if muttator, map html new line
"au BufEnter mutt-ator-mail :imap ^M <br>^[o

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
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
"Bundle 'xolox/vim-lua-ftplugin'
"Bundle 'xolox/vim-lua-inspect.git'
Bundle 'Rip-Rip/clang_complete'
Bundle 'msanders/snipmate.vim'
Bundle 'ervandew/supertab'
"Bundle 'Valloric/YouCompleteMe'
Bundle 'vim-scripts/TaskList.vim'
Bundle 'vim-scripts/luarefvim'
Bundle 'kien/ctrlp.vim'
"Bundle 'ivanov/vim-ipython'
"Bundle 'artemave/slowdown.vim'
Bundle 'ervandew/screen'

" repos on vim.org
Bundle 'matchit.zip'
Bundle 'PreciseJump'
Bundle 'pythoncomplete'
Bundle 'Syntastic'

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
autocmd FileType c,cpp,cs,java,objc let g:clang_periodic_quickfix = 1
autocmd FileType c,cpp,cs,java,objc nnoremap <leader>q :call g:ClangUpdateQuickFix()<cr>
"autocmd FileType c,cpp,cs,java,objc let g:clang_exec = '/idiap/home/skayal/.vim/bundle/clang_complete/bin/clang'
autocmd FileType c,cpp,cs,java,objc let g:clang_use_library = 1
"autocmd FileType c,cpp,cs,java,objc let g:clang_library_path = '/idiap/home/skayal/.vim/bundle/clang_complete/bin'
"autocmd FileType c,cpp,cs,java,objc let g:clang_library_path = '/idiap/home/skayal/lib'

"__________________python__________________"

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType python set foldmethod=indent
autocmd FileType python map <F5> :!python %<CR>
autocmd FileType python setlocal tabstop=4
autocmd FileType python setlocal shiftwidth=4
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

nnoremap <leader>e :call ToggleAutoEsc()<cr>
call ToggleAutoEsc()
"__________________________________________"

noremap à :buffers<CR>:b 
noremap ô :buffers<CR>:vertical sb 
noremap <C-n> :bp<CR>:buffers<CR>
noremap <C-p> :bn<CR>:buffers<CR>
noremap tb :e [Temporary buffer]<CR>:set buftype=nofile<CR>:set bufhidden=hide<CR>:setlocal noswapfile<CR>
noremap vtb :vs [Temporary buffer]<CR>:set buftype=nofile<CR>:set bufhidden=hide<CR>:setlocal noswapfile<CR>
noremap <leader>h :set hlsearch!<CR>

"________windows navigation mappings_______"
noremap <Left> <C-w>h
noremap <Down> <C-w>j
noremap <Up> <C-w>k
noremap <Right> <C-w>l
noremap <C-Left> <C-w>H
noremap <C-Down> <C-w>J
noremap <C-Up> <C-w>K
noremap <C-Right> <C-w>L

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
nnoremap <space> ;
vnoremap ; :
vnoremap <space> ;
"_________________colorschemes_____________"
colorscheme murphy
hi Folded guibg=#151515

hi ColorColumn ctermbg=darkgray guibg=darkgray
set cc=+1

if !has("gui_running")
  colorscheme zellner
  set background=dark
  set t_Co=256
endif

"_________________slowdown vim_____________"
let g:slow_down_max_delay_ms = 300 " default is 200


set tags+=tags;
noremap <C-F12> :!ctags -R --sort=yes --c++-kinds=+pl --fields=+iaS --extra=+q .<CR>

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

noremap <leader>n :call ToggleNumbers()<cr>

noremap vrc :tabnew $MYVIMRC<CR>
