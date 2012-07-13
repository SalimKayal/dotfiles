set nocompatible
set bs=2
filetype plugin on
let $PAGER=''

syntax on
set number
set hidden
set hlsearch
set mouse=a
set smartindent
set autoindent
set expandtab
set tabstop=2
set shiftwidth=2
set textwidth=80
set formatoptions=cqt
set wrapmargin=6
set guioptions+=lrb
set guioptions-=lrb
set guioptions+=LRB
set guioptions-=LRB
set guioptions-=T
set guioptions-=m

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
autocmd FileType lua let g:lua_complete_omni = 1
autocmd FileType lua let g:lua_path = './?.lua;/remote/filer.gx/home.active/skayal/share/torch/lua/?.lua;/remote/filer.gx/home.active/skayal/share/torch/lua/?/init.lua;/remote/filer.gx/home.active/skayal/lib/torch/?.lua;/remote/filer.gx/home.active/skayal/lib/torch/?/init.lua'
autocmd FileType lua let g:lua_complete_keywords = 1
autocmd FileType lua let g:lua_complete_globals = 1
autocmd FileType lua let g:lua_complete_library = 1
autocmd FileType lua set tags=lua.tags
autocmd FileType lua map <F5> :!torch %<CR>
"__________________________________________"

map à :buffers<CR>:b 
map ô :wall <CR>
map <leader>t :e [Temporary buffer]<CR>:set buftype=nofile<CR>:set bufhidden=hide<CR>:setlocal noswapfile<CR>
map <leader>v :vs [Temporary buffer]<CR>:set buftype=nofile<CR>:set bufhidden=hide<CR>:setlocal noswapfile<CR>

colorscheme murphy
hi Folded guibg=#151515

set tags+=tags;
map <C-F12> :!ctags -R --sort=yes --c++-kinds=+pl --fields=+iaS --extra=+q .<CR>

au BufNewFile,BufRead *.plt,.gnuplot setf gnuplot

let g:pyclewn_args="-w bottom"

let g:SuperTabDefaultCompletionType = "context"

au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview

if !has("gui_running")
  colorscheme zellner
  set background=dark
  set t_Co=256
endif

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
