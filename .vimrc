"shortcut for vimrc
noremap vrc :tabnew $MYVIMRC<CR>

set nocompatible
set bs=2
syntax on
set number
set hidden
set nowrap
set scrolloff=5
"indentation
set smartindent
set autoindent
"tabs
set expandtab
set tabstop=2
set shiftwidth=2
"code width
set textwidth=100
set linebreak
"gui
set guioptions-=lrbLRTm
"status line
"               buffer   file                      position     rel   HEX   ASCII
set statusline=%<[%02n]\ %F%(\ %m%h%w%y%r%)\ %a%=\ %8l,%c%V/%L\ (%P)\ [%08O:%02B]
set laststatus=2
set showcmd

"because seriously....
nnoremap Y y$

if has('persistent_undo')
  set undofile
  set undodir=${HOME}/.vim/undodir
  set undolevels=1000
  set undoreload=10000
endif

function! ToggleNumbers()
  set relativenumber!
endfunction

noremap <leader>n :call ToggleNumbers()<cr>

"__________________________________________"
noremap <leader>tb :e [Temporary buffer]<CR>:setlocal buftype=nofile bufhidden=hide noswapfile<CR>
noremap <leader>vtb :vs [Temporary buffer]<CR>:setlocal buftype=nofile bufhidden=hide noswapfile<CR>

"__________________________________________"
set hlsearch
set incsearch
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

"_____________custom mappings______________"
nnoremap ; :
nnoremap <space> ;
vnoremap ; :
vnoremap <space> ;

"autosource vimrc on leave
au BufWritePost $MYVIMRC :source $MYVIMRC

"_______________plug options_______________"
call plug#begin('~/.vim/bundle')
" My Plugs here:
"
" original repos on github
Plug 'tpope/vim-surround' | Plug 'tpope/vim-repeat'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/async.vim', {'for':['python', 'c', 'cpp', 'objc', 'objcpp']}
Plug 'prabirshrestha/asyncomplete-lsp.vim', {'for':['python', 'c', 'cpp', 'objc', 'objcpp']}
Plug 'prabirshrestha/vim-lsp', {'for':['python', 'c', 'cpp', 'objc', 'objcpp']}
Plug 'prabirshrestha/asyncomplete-ultisnips.vim'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'Shougo/denite.nvim'
Plug 'idanarye/vim-vebugger', {'for':['python', 'c', 'cpp', 'objc', 'objcpp']}
Plug 'amix/vim-2048'
Plug 'mileszs/ack.vim'
Plug 'altercation/vim-colors-solarized'

call plug#end()

if !exists('g:loaded_matchit')
  runtime! /macros/matchit.vim
endif

"_________________colorschemes_____________"
set t_Co=256
let g:solarized_termtrans = 1
colorscheme solarized
set background=dark
hi Folded guibg=#151515

hi ColorColumn ctermbg=red guibg=red
set cc=+1

"________________gnuplot___________________"
au BufNewFile,BufRead *.plt,.gnuplot setf gnuplot

"_____________c,c++,java,objc______________"
autocmd Filetype c,cpp,cs,java,objc set cindent
autocmd Filetype c,cpp,cs,java,objc set cst csto=0
autocmd Filetype c,cpp,cs,java,objc set cinkeys=0{,0},:,0#,!^F
autocmd FileType c,cpp,cs,java,objc set foldmethod=syntax

"_________________android__________________"
let g:EclimCompletionMethod = 'omnifunc'

"__________________python__________________"
autocmd FileType python set foldmethod=indent
autocmd FileType python map <F5> :!python %<CR>
autocmd FileType python setlocal tabstop=4
autocmd FileType python setlocal shiftwidth=4

"___________________lua____________________"
autocmd FileType lua set foldmethod=indent
autocmd FileType lua let g:lua_interpreter_path = "/idiap/temp/skayal/torch/install/bin/th"
autocmd FileType lua let g:lua_complete_omni = 1
autocmd FileType lua let g:lua_complete_keywords = 1
autocmd FileType lua let g:lua_complete_globals = 1
autocmd FileType lua let g:lua_complete_library = 1
autocmd FileType lua set tags=lua.tags

"__________________LaTeX___________________"
autocmd FileType tex setlocal spell
autocmd FileType tex setlocal spelllang=en_us
autocmd FileType tex nnoremap <F4> :w\|execute "silent !xelatex -interaction nonstopmode % >out.txt 2>err.txt"\|execute "silent  !gnome-open %<.pdf >>out.txt 2>>err.txt"<CR>

"___________________ag_____________________"
let g:ackprg = 'ag --vimgrep'

"________________lsp bindings______________"
autocmd FileType python,c,cpp,objc,objcpp nnoremap K :LspHover<CR>
autocmd Filetype python,c,cpp,objc,objcpp nnoremap <c-]> :LspDefinition<CR>

"_________asyncomplete tab expension_______"
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"

"___________asyncomplete C family__________"
if executable('clangd')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd']},
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
        \ })
endif

"____________asyncomplete python___________"
if executable('pyls')
  au User lsp_setup call lsp#register_server({
      \ 'name': 'pyls',
      \ 'cmd': {server_info->['pyls']},
      \ 'whitelist': ['python'],
      \ })
endif

"_________asyncomplete snippets___________"
call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
    \ 'name': 'ultisnips',
    \ 'whitelist': ['*'],
    \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
    \ }))

"_______________Ultisnips__________________"
let g:ycm_use_ultisnips_completer = 1
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

"________________vebugger__________________"
let g:vebugger_leader='<Leader>d'

"_______________Denite.vim__________________"
nnoremap <leader>f :Denite file_rec<CR>
nnoremap <leader>v :Denite -default-action=vsplit file_rec<CR>
nnoremap á :Denite buffer<CR>
nnoremap ó :Denite -default-action=vsplit buffer<CR>
nnoremap <leader>c :Denite quit<CR>
inoremap <leader>c <esc>:Denite quit<CR>

