" Setup Vundle plugins ---------------------------------------------- {{{
filetype off
set rtp+=~/.nvim/bundle/Vundle.vim
call vundle#begin('~/.nvim/bundle')

Plugin 'gmarik/Vundle.vim'

Plugin 'jaredmcateer/vim-atom-dark'
Plugin 'tpope/vim-surround.git'
Plugin 'Townk/vim-autoclose'
Plugin 'tpope/vim-commentary'
Plugin 'kien/ctrlp.vim'
Plugin 'Raimondi/delimitMate'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'bling/vim-airline'
Plugin 'Valloric/YouCompleteMe'
Plugin 'sjl/splice.vim'
Plugin 'scrooloose/syntastic'
Plugin 'othree/html5.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'brookhong/DBGPavim'

call vundle#end()
filetype plugin indent on
" }}}
" Basic Options ----------------------------------------------------- {{{
set encoding=utf-8
set modelines=0
set autoindent
set showmode
set showcmd
set hidden
set visualbell
set ruler
set backspace=indent,eol,start
set number
set relativenumber
set laststatus=2
set history=1000
set undofile
set undoreload=10000
set list
set listchars=tab:▸\ ,extends:❯,precedes:❮
set lazyredraw
set matchtime=3
set showbreak=↪
set splitbelow
set splitright
set autowrite
set autoread
set shiftround
set title
set colorcolumn=80,120

" Don't try to highlight lines longer than 400 chars
set synmaxcol=400

" Time out on keycodes but not mappsings
set notimeout
set ttimeout
set ttimeoutlen=10

" Better completion
set complete=.,w,b,u,t
set completeopt=longest,menuone,preview

" Save when losing focus
au FocusLost * :silent! wall

" Leader
let mapleader = ","
let maplocalleader = "\\"

" Trailing whitespace {{{
" Only shown when not in insert mode

augroup trailing
    au!
    au InsertEnter * :set listchars-=trail:⌴
    au InsertLeave * :set listchars+=trail:⌴
augroup END

" Remove trailing whitespace on save
autocmd FileType c,cpp,java,php,js,phtml,html autocmd BufWritePre * :%s/\s\+$//e

" }}}

" Wildmenu completion {{{
set wildmenu
set wildmode=list:longest

set wildignore+=.hg,.svn,.git
set wildignore+=*.jpg,*.jpeg,*.png,*.gif,*.bmp
set wildignore+=*.sw?
set wildignore+=*.DS_Store
set wildignore+=*.orig
" }}}
" Line Return {{{

" Make sure Vim returns to the same line when you reopen a file.
" Thanks, Amit
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

" }}}
" Tabs, spaces, wrapping {{{
set tabstop=4
set shiftwidth=2
set softtabstop=2
set expandtab
set nowrap
set textwidth=120
set formatoptions=qrn1j
set colorcolumn=80,120
" }}}
" Backups {{{
set backup
set noswapfile
set undodir=~/.nvim/tmp/undo//
set backupdir=~/.nvim/tmp/backup//
set directory=~/.nvim/tmp/swap//

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif
" }}}
" Color Scheme {{{
syntax on
colorscheme atom-dark-256
" }}}
" }}}
" Abbreviations ----------------------------------------------------- {{{
iabbrev funciton function
iabbrev functoin function
iabbrev retrun return
iabbrev reutnr return
" }}}
" Convience mappings ------------------------------------------------ {{{
noremap <F1> :checktime<cr>
inoremap <F1> <esc>:checktime<cr>

inoremap jj <esc>
" Tabs
nnoremap <leader>d :tabprev<cr>
nnoremap <leader>f :tabnext<cr>

" Highlight Group(s)
nnoremap <F8> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
                        \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
                        \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" "Uppercase word" mapping.
"
" This mapping allows you to press <c-u> in insert mode to convert the current
" word to uppercase.  It's handy when you're writing names of constants and
" don't want to use Capslock.
"
" To use it you type the name of the constant in lowercase.  While your
" cursor is at the end of the word, press <c-u> to uppercase it, and then
" continue happily on your way:
"
"                            cursor
"                            v
"     max_connections_allowed|
"     <c-u>
"     MAX_CONNECTIONS_ALLOWED|
"                            ^
"                            cursor
"
" It works by exiting out of insert mode, recording the current cursor location
" in the z mark, using gUiw to uppercase inside the current word, moving back to
" the z mark, and entering insert mode again.
"
" Note that this will overwrite the contents of the z mark.  I never use it, but
" if you do you'll probably want to use another mark.
inoremap <C-u> <esc>mzgUiw`za

" Keep the cursor in place while joining lines
nnoremap J mzJ`z<F37>

" Split line (sister to [J]oin lines)
" The normal use of S is covered by cc, so don't worry about shadowing it.
nnoremap S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w

" Sudo to write
cnoremap w!! w !sudo tee % >/dev/null

" Typos
command! -bang E e<bang>
command! -bang Q q<bang>
command! -bang W w<bang>
command! -bang QA qa<bang>
command! -bang Qa qa<bang>
command! -bang Wa wa<bang>
command! -bang WA wa<bang>
command! -bang Wq wq<bang>
command! -bang WQ wq<bang>

" Paste toggle
nnoremap <leader>p :set paste!<cr>

" Vundle Keys
nnoremap <leader>bi :PluginInstall<cr>
nnoremap <leader>bu :PluginUpdate<cr>
nnoremap <leader>bc :PluginClean<cr>
" }}}
" Quick Editing ----------------------------------------------------- {{{
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>eg :vsplit ~/.gitconfig<cr>
nnoremap <leader>eb :vsplit ~/.bashrc<cr>
nnoremap <leader>ea :vsplit ~/.bash_aliases<cr>
nnoremap <leader>et :vsplit ~/.tmux.conf<cr>

" }}}
" Searching and movement -------------------------------------------- {{{
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch

set scrolloff=3
set sidescroll=1
set sidescrolloff=10

set virtualedit+=block

noremap <silent> <leader><space> :noh<cr>:call clearmatches()<cr>

" Make D behave
nnoremap D d$

" Don't move on *
nnoremap <silent> * :let stay_star_view = winsaveview()<cr>*:call winrestview(stay_star_view)<cr>


set tags=tags;
" Jumping to tags.
"
" Basically, <c-]> jumps to tags (like normal) and <c-\> opens the tag in a new
" split instead.
"
" Both of them will align the destination line to the upper middle part of the
" screen.  Both will pulse the cursor line so you can see where the hell you
" are.  <c-\> will also fold everything in the buffer and then unfold just
" enough for you to see the destination line.
function! JumpToTag()
    execute "normal! \<c-]>mzzvzz15\<c-e>"
    execute "keepjumps normal! `z"
    Pulse
endfunction
function! JumpToTagInSplit()
    execute "normal! \<c-w>v\<c-]>mzzMzvzz15\<c-e>"
    execute "keepjumps normal! `z"
    Pulse
endfunction
nnoremap <c-]> :silent! call JumpToTag()<cr>
nnoremap <c-\> :silent! call JumpToTagInSplit()<cr>

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz
nnoremap <c-o> <c-o>zz<F37>

" Easier to type, and I never use the default behavior.
noremap H ^
noremap L $
vnoremap L g_

" Directional Keys {{{

" It's 2013.
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" Easy split navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

if has('nvim')
  tnoremap <C-h> <c-\><c-n><C-w>h
  tnoremap <C-j> <c-\><c-n><C-w>j
  tnoremap <C-k> <c-\><c-n><C-w>k
  tnoremap <C-l> <c-\><c-n><C-w>l
  au WinEnter *term://* call feedkeys('i')
endif

noremap <leader>v <C-w>v

" }}}
" List navigation {{{

nnoremap <left>  :cprev<cr>zvzz
nnoremap <right> :cnext<cr>zvzz
nnoremap <up>    :lprev<cr>zvzz
nnoremap <down>  :lnext<cr>zvzz

" }}}

" }}}
" Folding ----------------------------------------------------------- {{{
" Make space toggle folds
nnoremap <Space> za
vnoremap <Space> za

" Make z0 recursively open whatever fold we're in
nnoremap z0 zcz0

" "Focus" the current line.  Basically:
"
" 1. Close all folds.
" 2. Open just the folds containing the current line.
" 3. Move the line to a little bit (15 lines) above the center of the screen.
" 4. Pulse the cursor line.  My eyes are bad.
"
" This mapping wipes out the z mark, which I never use.
nnoremap <leader>z mzzMzvzz15<c-e>`z:Pulse<cr>

function! MyFoldText() " {{{
  let line = getline(v:foldstart)

  let nucolwidth = &fdc + &number * &numberwidth
  let windowwidth = winwidth(0) - nucolwidth - 3
  let foldedlinecount = v:foldend - v:foldstart

  " expand tabs into spaces
  let onetab = strpart('          ', 0, &tabstop)
  let line = substitute(line, '\t', onetab, 'g')

  let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
  let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
  return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction " }}}
set foldtext=MyFoldText()
" }}}
" File-type specific ------------------------------------------------ {{{
" CSS & Sass {{{

  augroup ft_css
    au!
    au BufNewFile,BufRead *.scss setlocal filetype=sass
    au FileType sass,css setlocal filemarker={,}
    au FileType sass,css setlocal omnifunc=csscomplete#CompleteCSS
    au FileType sass,css setlocal iskeyword+=-

    " Use <leader>S to sort properties.  Turns this:
    "
    "     p {
    "         width: 200px;
    "         height: 100px;
    "         background: red;
    "
    "         ...
    "     }
    "
    " into this:

    "     p {
    "         background: red;
    "         height: 100px;
    "         width: 200px;
    "
    "         ...
    "     }
    au BufNewFile,BufRead *.less,*.css nnoremap <buffer> <localleader>S ?{<CR>jV/\v^\s*\}?$<CR>k:sort<CR>:noh<CR>

    " Make {<cr> insert a pair of brackets in such a way that the cursor is correctly
    " positioned inside of them AND the following code doesn't get unfolded.
    au BufNewFile,BufRead *.less,*.css inoremap <buffer> {<cr> {}<left><cr><space><space><space><space>.<cr><esc>kA<bs>
  augroup END

" }}}
" HTML {{{

  augroup ft_html
    au!
    au BufNewFile,BufRead *.phtml setlocal filetype=phtml
    au FileType html,phtml setlocal foldmethod=manual

     " Use <localleader>f to fold the current tag.
    au FileType html,phtml nnoremap <buffer> <localleader>f Vatzf

    " Indent tag
    au FileType html,phtml nnoremap <buffer> <localleader>= Vat=
  augroup END

" }}}
" Javascript {{{

  augroup ft_javascript
    au!

    au FileType javascript setlocal foldmethod=marker
    au FileType javascript setlocal foldmarker={,}
    au FileType javascript call MakeSpacelessBufferIabbrev('clog', 'console.log();<left><left>')

    " Make {<cr> insert a pair of brackets in such a way that the cursor is correctly
    " positioned inside of them AND the following code doesn't get unfolded.
    au Filetype javascript inoremap <buffer> {<cr> {}<left><cr><space><space><space><space>.<cr><esc>kA<bs>
    " }

    " Prettify a hunk of JSON with <localleader>p
    au FileType javascript nnoremap <buffer> <localleader>p ^vg_:!python -m json.tool<cr>
    au FileType javascript vnoremap <buffer> <localleader>p :!python -m json.tool<cr>
  augroup END

" }}}
" Markdown {{{

  augroup ft_markdown
    au!

    au BufNewFile,BufRead *.m*down setlocal filetype=markdown foldlevel=1

    " Use <localleader>1/2/3 to add headings.
    au Filetype markdown nnoremap <buffer> <localleader>1 yypVr=:redraw<cr>
    au Filetype markdown nnoremap <buffer> <localleader>2 yypVr-:redraw<cr>
    au Filetype markdown nnoremap <buffer> <localleader>3 mzI###<space><esc>`zllll
    au Filetype markdown nnoremap <buffer> <localleader>4 mzI####<space><esc>`zlllll

    au Filetype markdown nnoremap <buffer> <localleader>p VV:'<,'>!python -m json.tool<cr>
    au Filetype markdown vnoremap <buffer> <localleader>p :!python -m json.tool<cr>
  augroup END

  " }}}
" Nginx {{{

  augroup ft_nginx
    au!

    au BufRead,BufNewFile /etc/nginx/conf/*                      set ft=nginx
    au BufRead,BufNewFile /etc/nginx/sites-available/*           set ft=nginx
    au BufRead,BufNewFile /usr/local/etc/nginx/sites-available/* set ft=nginx
    au BufRead,BufNewFile vhost.nginx                            set ft=nginx

    au FileType nginx setlocal foldmethod=marker foldmarker={,}
  augroup END

" }}}
" Puppet {{{

  augroup ft_puppet
    au!

    au Filetype puppet setlocal foldmethod=marker
    au Filetype puppet setlocal foldmarker={,}
  augroup END

" }}}
" PHP {{{
  augroup ft_php
    au!
    au FileType php,phtml setlocal tabstop=8
    au FileType php,phtml setlocal shiftwidth=4
    au FileType php,phtml setlocal softtabstop=4
  augroup END
" }}}
" QuickFix {{{

  augroup ft_quickfix
    au!
    au Filetype qf setlocal colorcolumn=0 nolist nocursorline nowrap tw=0
  augroup END

" }}}
" Ruby {{{

  augroup ft_ruby
    au!
    au Filetype ruby setlocal foldmethod=syntax
    au BufRead,BufNewFile Capfile setlocal filetype=ruby
  augroup END

" }}}
" Standard In {{{

  augroup ft_stdin
    au!

    " Treat buffers from stdin (e.g.: echo foo | vim -) as scratch.
    au StdinReadPost * :set buftype=nofile
  augroup END

" }}}
" Vagrant {{{

  augroup ft_vagrant
    au!
    au BufRead,BufNewFile Vagrantfile set ft=ruby
  augroup END

" }}}
" Vim {{{

  augroup ft_vim
    au!

    au FileType vim setlocal foldmethod=marker
    au FileType help setlocal textwidth=78
    au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
  augroup END

" }}}
" YAML {{{

  augroup ft_yaml
    au!

    au FileType yaml set shiftwidth=2
  augroup END

" }}}
" XML {{{

  augroup ft_xml
    au!

    au FileType xml setlocal foldmethod=manual

    " Use <localleader>f to fold the current tag.
    au FileType xml nnoremap <buffer> <localleader>f Vatzf

    " Indent tag
    au FileType xml nnoremap <buffer> <localleader>= Vat=
  augroup END

" }}}
" }}}
" Plugin settings --------------------------------------------------- {{{
" Autoclose {{{

nmap <Leader>x <Plug>ToggleAutoCloseMappings

" }}}
" Commentary {{{

nmap <leader>c <Plug>CommentaryLine
xmap <leader>c <Plug>Commentary

" }}}
" Ctrl-P {{{

let g:ctrlp_jump_to_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_max_height = 20
let g:ctrlp_extensions = ['tag']

let g:ctrlp_map = '<leader>,'
nnoremap <leader>. :CtrlPTag<cr>
nnoremap <leader>E :CtrlP ../

let g:ctrlp_prompt_mappings = {
\ 'PrtSelectMove("j")':   ['<c-j>', '<down>', '<s-tab>'],
\ 'PrtSelectMove("k")':   ['<c-k>', '<up>', '<tab>'],
\ 'PrtHistory(-1)':       ['<c-n>'],
\ 'PrtHistory(1)':        ['<c-p>'],
\ 'ToggleFocus()':        ['<c-tab>'],
\ }

let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
  \ --ignore .git
  \ --ignore .svn
  \ --ignore .hg
  \ --ignore .DS_Store
  \ --ignore "**/*.pyc"
  \ --ignore msribbon
  \ --ignore node_modules
  \ --ignore test_out
  \ -g ""'

" }}}
" DBGPavim {{{
  let g:dbgPavimBreakAtEntry = 1
  let g:dbgPavimPathMap = [['/home/jared/projects/vagrant-apache/istock-src/', '/data/istock/']]
" }}}
" DelimitMate {{{

" }}}
" Fugitive {{{

nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gw :Gwrite<cr>
nnoremap <leader>ga :Gadd<cr>
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gco :Gcheckout<cr>
nnoremap <leader>gci :Gcommit<cr>
nnoremap <leader>gm :Gmove<cr>
nnoremap <leader>gr :Gremove<cr>
nnoremap <leader>gl :Shell git gl -18<cr>:wincmd \|<cr>

augroup ft_fugitive
    au!

    au BufNewFile,BufRead .git/index setlocal nolist
augroup END

" "Hub"
vnoremap <leader>H :Gbrowse<cr>
nnoremap <leader>H V:Gbrowse<cr>

" "(Upstream) Hub"
vnoremap <leader>u :Gbrowse @upstream<cr>
nnoremap <leader>u V:Gbrowse @upstream<cr>

" }}}
" HTML5 {{{

let g:event_handler_attributes_complete = 0
let g:rdfa_attributes_complete = 0
let g:microdata_attributes_complete = 0
let g:atia_attributes_complete = 0

" }}}
" Javascript Lib Syntax {{{
  let g:used_javascript_libs = 'underscore,jquery,angular,jasmine'
" }}}
" NERD Tree {{{

noremap  <F2> :NERDTreeToggle<cr>
inoremap <F2> <esc>:NERDTreeToggle<cr>
noremap  <F3> :NERDTreeFind<cr>
inoremap <F3> <esc>:NERDTreeFind<cr>

augroup ps_nerdtree
    au!

    au Filetype nerdtree setlocal nolist
    au Filetype nerdtree nnoremap <buffer> H :vertical resize -10<cr>
    au Filetype nerdtree nnoremap <buffer> L :vertical resize +10<cr>
    " au Filetype nerdtree nnoremap <buffer> K :q<cr>
augroup END

let NERDTreeHighlightCursorline = 1
let NERDTreeIgnore = ['.vim$', '\~$', '.*\.pyc$', 'pip-log\.txt$', 'whoosh_index',
                    \ 'xapian_index', '.*.pid', 'monitor.py', '.*-fixtures-.*.json',
                    \ '.*\.o$', 'db.db', 'tags.bak', '.*\.pdf$', '.*\.mid$',
                    \ '.*\.midi$']

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDChristmasTree = 1
let NERDTreeChDirMode = 2
let NERDTreeQuitOnOpen = 1
let NERDTreeMapJumpFirstChild = 'gK'

" }}}
" Airline {{{
  let g:airline_powerline_fonts = 1
" }}}
" Splice {{{

let g:splice_prefix = "-"

let g:splice_initial_mode = "grid"

let g:splice_initial_layout_grid = 0
let g:splice_initial_layout_loupe = 0
let g:splice_initial_layout_compare = 0
let g:splice_initial_layout_path = 0

let g:splice_initial_diff_grid = 1
let g:splice_initial_diff_loupe = 0
let g:splice_initial_diff_compare = 1
let g:splice_initial_diff_path = 0

let g:splice_initial_scrollbind_grid = 0
let g:splice_initial_scrollbind_loupe = 0
let g:splice_initial_scrollbind_compare = 0
let g:splice_initial_scrollbind_path = 0

let g:splice_wrap = "nowrap"

" }}}
" Syntastic {{{
  let g:syntastic_javascript_checkers = ['jshint', 'jscs']
  let g:syntastic_php_checkers = ['phplint', 'phpcs']
  let g:syntastic_php_phpcs_args="--report=csv --standard=PSR2"
  let g:syntastic_error_symbol = '☒'
  let g:syntastic_warning_symbol = '⚠'
  let g:syntastic_style_error_symbol = '✗'
  let g:syntastic_style_warning_symbol = '❗'
" }}}
" }}}
" Mini-plugins ------------------------------------------------------ {{{
" Stuff that should probably be broken out into plugins, but hasn't proved to be
" worth the time to do so just yet.

" Synstack {{{

  " Show the stack of syntax hilighting classes affecting whatever is under the
  " cursor.
  function! SynStack()
    echo join(map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")'), " > ")
  endfunc

  nnoremap <leader><F7> :call SynStack()<CR>

" }}}
" J {{{

function! s:JumpTo(dest)
  call system("tmux split-window -h 'j " . a:dest . "; and myctags &; and vim .'")
endfunction

command! -nargs=1 J call s:JumpTo(<f-args>)

" }}}
" Indent Guides {{{

  let g:indentguides_state = 0
  function! IndentGuides() " {{{
    if g:indentguides_state
      let g:indentguides_state = 0
      2match None
    else
      let g:indentguides_state = 1
      execute '2match IndentGuides /\%(\_^\s*\)\@<=\%(\%'.(0*&sw+1).'v\|\%'.(1*&sw+1).'v\|\%'.(2*&sw+1).'v\|\%'.(3*&sw+1).'v\|\%'.(4*&sw+1).'v\|\%'.(5*&sw+1).'v\|\%'.(6*&sw+1).'v\|\%'.(7*&sw+1).'v\)\s/'
    endif
  endfunction " }}}
  hi def IndentGuides guibg=#303030 ctermbg=234
  nnoremap <leader>I :call IndentGuides()<cr>

" }}}
" Block Colors {{{

  let g:blockcolor_state = 0
  function! BlockColor() " {{{
    if g:blockcolor_state
      let g:blockcolor_state = 0
      call matchdelete(77881)
      call matchdelete(77882)
      call matchdelete(77883)
      call matchdelete(77884)
      call matchdelete(77885)
      call matchdelete(77886)
    else
      let g:blockcolor_state = 1
      call matchadd("BlockColor1", '^ \{4}.*', 1, 77881)
      call matchadd("BlockColor2", '^ \{8}.*', 2, 77882)
      call matchadd("BlockColor3", '^ \{12}.*', 3, 77883)
      call matchadd("BlockColor4", '^ \{16}.*', 4, 77884)
      call matchadd("BlockColor5", '^ \{20}.*', 5, 77885)
      call matchadd("BlockColor6", '^ \{24}.*', 6, 77886)
    endif
  endfunction " }}}
  " Default highlights {{{
  hi def BlockColor1 guibg=#222222 ctermbg=234
  hi def BlockColor2 guibg=#2a2a2a ctermbg=235
  hi def BlockColor3 guibg=#353535 ctermbg=236
  hi def BlockColor4 guibg=#3d3d3d ctermbg=237
  hi def BlockColor5 guibg=#444444 ctermbg=238
  hi def BlockColor6 guibg=#4a4a4a ctermbg=239
  " }}}
  nnoremap <leader>B :call BlockColor()<cr>

" }}}
" Pulse Line {{{

  function! s:Pulse() " {{{
    redir => old_hi
    silent execute 'hi CursorLine'
    redir END
    let old_hi = split(old_hi, '\n')[0]
    let old_hi = substitute(old_hi, 'xxx', '', '')

    let steps = 8
    let width = 1
    let start = width
    let end = steps * width
    let color = 233

    for i in range(start, end, width)
      execute "hi CursorLine ctermbg=" . (color + i)
      redraw
      sleep 6m
    endfor
    for i in range(end, start, -1 * width)
      execute "hi CursorLine ctermbg=" . (color + i)
      redraw
      sleep 6m
    endfor

    execute 'hi ' . old_hi
  endfunction " }}}
  command! -nargs=0 Pulse call s:Pulse()

" }}}

" }}}
