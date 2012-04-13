set nocompatible
set bs=2
filetype plugin on
let $PAGER=''

syntax on
set number
set hidden
set hlsearch
set mouse=a
set cindent
set smartindent
set autoindent
set expandtab
set tabstop=2
set shiftwidth=2
set cinkeys=0{,0},:,0#,!^F
set foldmethod=indent
set guioptions+=lrb
set guioptions-=lrb
set guioptions+=LRB
set guioptions-=LRB
set guioptions-=T
set guioptions-=m

let mapleader="à"

map § :buffers<CR>:b 
map é :wall <CR>
map <leader>t :e [Temporary buffer]<CR>:set buftype=nofile<CR>:set bufhidden=hide<CR>:setlocal noswapfile<CR>
map <leader>v :vs [Temporary buffer]<CR>:set buftype=nofile<CR>:set bufhidden=hide<CR>:setlocal noswapfile<CR>

colorscheme murphy
hi Folded guibg=#151515

set tags=tags;
set tags+=~/.vim/Tags/stl.tags
map <C-F12> :!ctags -R --sort=yes --c++-kinds=+pl --fields=+iaS --extra=+q .<CR>

au BufNewFile,BufRead *.plt,.gnuplot setf gnuplot

let g:pyclewn_args="-w bottom"

" Disable auto popup, use <Tab> to autocomplete
let g:clang_complete_auto = 1
" Show clang errors in the quickfix window
let g:clang_complete_copen = 1
let g:clang_complete_snippets = 1
let g:clang_complete_snippets_engine = 'snipmate'
"let g:clang_complete_patterns = 1
let g:clang_periodic_quickfix = 1
let g:SuperTabDefaultCompletionType = "context"

"let OmniCpp_NamespaceSearch = 1
"let OmniCpp_GlobalScopeSearch = 1
"let OmniCpp_ShowAccess = 1
"let OmniCpp_MayCompleteDot = 1
"let OmniCpp_MayCompleteArrow = 1
"let OmniCpp_MayCompleteScope = 1
"let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]

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


"function! SuperCleverTab()
"    if strpart(getline('.'), 0, col('.') - 1) =~ '^\s*$'
"        return "\<Tab>"
"    else
"        if &omnifunc != ''
"            return "\<C-X>\<C-O>"
"        elseif &dictionary != ''
"            return "\<C-K>"
"        else
"            return "\<C-N>"
"        endif
"    endif
"endfunction
"
"inoremap <Tab> <C-R>=SuperCleverTab()<cr>
