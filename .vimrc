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
set nowrap
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
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
Bundle 'Valloric/YouCompleteMe'
Bundle 'rdnetto/YCM-Generator'
Bundle 'SirVer/ultisnips'
Bundle 'honza/vim-snippets.git'
Bundle 'vim-scripts/luarefvim'
Bundle 'Shougo/unite.vim'
Bundle 'Shougo/vimproc.vim'
Bundle 'idanarye/vim-vebugger'
Bundle 'scrooloose/syntastic'
Bundle 'amix/vim-2048'
Bundle 'mileszs/ack.vim'

" repos on vim.org
Bundle 'matchit.zip'
Bundle 'PreciseJump'

filetype plugin indent on     " required!

"___________________ag_____________________"
let g:ackprg = 'ag --vimgrep'

"_____________c,c++,java,objc______________"

autocmd Filetype c,cpp,cs,java,objc set cindent
autocmd Filetype c,cpp,cs,java,objc set cst csto=0
autocmd Filetype c,cpp,cs,java,objc set cinkeys=0{,0},:,0#,!^F
autocmd FileType c,cpp,cs,java,objc set foldmethod=syntax
autocmd FileType c,cpp,cs,java,objc set tags=~/.vim/Tags/stl.tags
autocmd FileType c,cpp,cs,java,objc nnoremap <F5> :wa<CR>:!mkdir -p build<CR>:cd build<CR>:!cmake ..<CR>:make<CR>:cd ..<CR>:redraw!<CR>:cwindow<CR>

"_________________android__________________"
let g:EclimCompletionMethod = 'omnifunc'

"__________________python__________________"

autocmd FileType python set foldmethod=indent
autocmd FileType python map <F5> :!python %<CR>
autocmd FileType python setlocal tabstop=4
autocmd FileType python setlocal shiftwidth=4
autocmd FileType python nnoremap <F4> :execute "silent !pep8 % > .pep8_error_file" \|cfile .pep8_error_file \|cwindow \|execute "silent !rm .pep8_error_file" \|redraw!<cr>
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

"__________________LaTeX___________________"
autocmd FileType tex setlocal spell
autocmd FileType tex setlocal spelllang=en_us
autocmd FileType tex nnoremap <F4> :w\|execute "silent !pdflatex -interaction nonstopmode % >out.txt 2>err.txt"\|execute "silent  !gnome-open %<.pdf >>out.txt 2>>err.txt"<CR>

"___________toggle auto-escape_____________"
let s:on = 0

function! ToggleAutoEsc()
   let &updatetime = 5000
   let s:on = !s:on
   exec "au".((s:on)?"":"!") "CursorHoldI *" ((s:on)?"stopinsert":"")
endfunction

nnoremap <leader>e :call ToggleAutoEsc()<cr>
"call ToggleAutoEsc()
"___________YouCompleteMe Goto_____________"
autocmd Filetype c,cpp,objc,objcpp,python nnoremap <c-]> :YcmCompleter GoToDefinitionElseDeclaration<CR>
autocmd BufWinEnter * call UnfoldPreview()

function! UnfoldPreview()
  if &pvw
    setlocal nofoldenable
  endif
endfunction
"__________________________________________"
let g:ycm_use_ultisnips_completer = 1
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
"__________________________________________"
noremap tb :e [Temporary buffer]<CR>:set buftype=nofile<CR>:set bufhidden=hide<CR>:setlocal noswapfile<CR>
noremap vtb :vs [Temporary buffer]<CR>:set buftype=nofile<CR>:set bufhidden=hide<CR>:setlocal noswapfile<CR>
noremap <leader>h :set hlsearch!<CR>
nnoremap / :set hlsearch<CR>/

"________windows navigation mappings_______"
nnoremap OD <c-w>h
nnoremap OB <c-w>j
nnoremap OA <c-w>k
nnoremap OC <c-w>l
nnoremap Od <c-w>H
nnoremap Ob <c-w>J
nnoremap Oa <c-w>K
nnoremap Oc <c-w>L

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

"________________vebugger__________________"
let g:vebugger_leader='vd'
"_______________unite.vim__________________"
nnoremap <leader>f :Unite -start-insert file_rec/async<CR>
nnoremap <leader>v :Unite -start-insert -default-action=vsplit file_rec/async<CR>
nnoremap à :Unite -start-insert buffer<CR>
nnoremap ô :Unite -start-insert -default-action=vsplit buffer<CR>
nnoremap <leader>c :UniteClose default<CR>
inoremap <leader>c <esc>:UniteClose default<CR>

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


set tags+=tags;
noremap <C-F12> :!ctags -R --sort=yes --c++-kinds=+pl --fields=+iaS --extra=+q .<CR>

au BufNewFile,BufRead *.plt,.gnuplot setf gnuplot

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
