" Setup plugins ----------------------------------------------------- {{{
call plug#begin('~/.config/nvim/plugged')

" "Plug 'jaredmcateer/vim-atom-dark'
"Plug 'edkolev/tmuxline.vim'
"Plug 'evanmiller/nginx-vim-syntax'
"Plug 'freeo/vim-kalisi'
"Plug 'guns/xterm-color-table.vim'
"Plug 'idanarye/vim-merginal'
"Plug 'moll/vim-node'
"Plug 'nathanaelkane/vim-indent-guides'
"Plug 'tmux-plugins/vim-tmux'

"Plug 'easymotion/vim-easymotion'
Plug 'Raimondi/delimitMate'
Plug 'Shougo/deoplete.nvim'
Plug 'Shougo/neosnippet.vim'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'albfan/ag.vim'
Plug 'albfan/vim-timelapse'
Plug 'ap/vim-css-color'
Plug 'benekastah/neomake'
Plug 'bling/vim-airline'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'digitaltoad/vim-pug'
Plug 'ekalinin/Dockerfile.vim'
Plug 'endel/vim-github-colorscheme'
Plug 'honza/vim-snippets'
Plug 'joshdick/onedark.vim'
Plug 'junegunn/vim-easy-align'
Plug 'kergoth/vim-hilinks'
Plug 'majutsushi/tagbar'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'ternjs/tern_for_vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-ctrlspace/vim-ctrlspace'
Plug 'wellle/targets.vim'

call plug#end()

" }}}
" Basic Options ----------------------------------------------------- {{{
filetype plugin indent on
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
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
set conceallevel=2
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'
set showtabline=0
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
autocmd FileType c,cpp,java,php,js,json,ejs,phtml,html autocmd BufWritePre * :%s/\s\+$//e

" }}}

" Wildmenu completion {{{
set wildmenu
set wildmode=longest:list,full

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
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set nowrap
set textwidth=120
set formatoptions=qrn1j
set colorcolumn=100,120
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
try
  set background=dark
  colorscheme onedark
  hi Comment guifg=#bada55
catch /^Vim\%((\a\+)\)\=:E185/
endtry

" }}}
" }}}
" Abbreviations ----------------------------------------------------- {{{
function! EatChar(pat)
    let c = nr2char(getchar(0))
    return (c =~ a:pat) ? '' : c
endfunction
function! MakeSpacelessIabbrev(from, to)
    execute "iabbrev <silent> ".a:from." ".a:to."<C-R>=EatChar('\\s')<CR>"
endfunction
function! MakeSpacelessBufferIabbrev(from, to)
    execute "iabbrev <silent> <buffer> ".a:from." ".a:to."<C-R>=EatChar('\\s')<CR>"
endfunction

iabbrev funciton function
iabbrev functoin function
iabbrev retrun return
iabbrev reutnr return
cabbr <expr> %% expand('%:p:h')
" }}}
" Convience mappings ------------------------------------------------ {{{
nmap <leader>q cs"'
noremap <F1> :checktime<cr>
inoremap <F1> <esc>:checktime<cr>

noremap <leader>t :call DiffToggle()<cr>

function! DiffToggle()
  if &diff
    diffoff
  else
    diffthis
  endif
:endfunction

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
nnoremap J mzJ`z

" Split line (sister to [J]oin lines)
" The normal use of S is covered by cc, so don't worry about shadowing it.
nnoremap S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w

" Sudo to write
cnoremap w!! w !sudo tee % >/dev/null

" Show Highlighting groups for current word
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

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

" Vim-plug Keys
nnoremap <leader>bi :PlugInstall<cr>
nnoremap <leader>bu :PlugUpdate<cr>
nnoremap <leader>bc :PlugClean<cr>

" }}}
" Quick Editing ----------------------------------------------------- {{{
fu! OpenInSplitIfBufferDirty(file)
    if line('$') == 1 && getline(1) == ''
        exec 'e' a:file
    else
        exec 'vsp' a:file
    endif
endfu
nnoremap <leader>ev :call OpenInSplitIfBufferDirty($MYVIMRC)<cr>
nnoremap <leader>eg :call OpenInSplitIfBufferDirty("~/.gitconfig")<cr>
nnoremap <leader>eb :call OpenInSplitIfBufferDirty("~/.bashrc")<cr>
nnoremap <leader>ea :call OpenInSplitIfBufferDirty("~/.bash_aliases")<cr>
nnoremap <leader>et :call OpenInSplitIfBufferDirty("~/.tmux.conf")<cr>

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
nnoremap <silent> & :%s///gn<cr>

" Open file under cursor in new split
nnoremap gf <c-w>vgf

set tags=./tags,tags,jsctags;
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

" Open new split
noremap <leader>v <C-w>v
noremap <leader>s <C-w>s

if has('nvim')
  tnoremap <Esc> <c-\><c-n>
  tnoremap <C-h> <c-\><c-n><C-w>h
  tnoremap <C-j> <c-\><c-n><C-w>j
  tnoremap <C-k> <c-\><c-n><C-w>k
  tnoremap <C-l> <c-\><c-n><C-w>l
  au WinEnter *term://* call feedkeys('i')
endif

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
"   asciidoc {{{
  augroup ft_asciidoc
    au!
    au BufNewFile,BufRead *.adoc setlocal filetype=asciidoc

    au FileType asciidoc setlocal wrap linebreak nolist
    au FileType asciidoc setlocal synmaxcol=1000
  augroup END
"   }}}
"   CSS & Sass {{{

  augroup ft_css
    au!
    au BufNewFile,BufRead *.scss setlocal filetype=sass
    au FileType less,sass,css setlocal foldmarker={,}
    au FileType less,sass,css setlocal omnifunc=csscomplete#CompleteCSS
    au FileType less,sass,css setlocal iskeyword+=-

    au FileType less,css,sass setlocal tabstop=4
    au FileType less,css,sass setlocal shiftwidth=4
    au FileType less,css,sass setlocal softtabstop=4
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

"   }}}
"   HTML {{{

  augroup ft_html
    au!
    au BufNewFile,BufRead *.phtml setlocal filetype=phtml
    au FileType html,phtml setlocal foldmethod=manual

     " Use <localleader>f to fold the current tag.
    au FileType html,phtml nnoremap <buffer> <localleader>f Vatzf

    " Indent tag
    au FileType html,phtml nnoremap <buffer> <localleader>= Vat=
  augroup END

"   }}}
"   Javascript {{{

  augroup ft_javascript
    au!

    au FileType javascript,js,json setlocal tabstop=2
    au FileType javascript,js,json setlocal shiftwidth=2
    au FileType javascript,js,json setlocal softtabstop=2
    au BufNewFile,BufRead /home/jared/arterys/bitterheart/* setlocal tabstop=2 shiftwidth=2 softtabstop=2

    " autocmd BufReadPost,BufWritePost  *.js %substitute/^\( \+\)\1/\1/e
    " autocmd BufWritePre               *.js %substitute/^ \+/&&/e

    " Add es5 extension
    au BufNewFile,BufRead *.es6 setlocal filetype=javascript
    " Add eslint extension
    au BufNewFile,BufRead .eslintrc setlocal filetype=javascript
    " Add jscs extension
    au BufNewFile,BufRead .jscsrc setlocal filetype=json

    au FileType javascript setlocal foldmethod=marker
    au FileType javascript setlocal foldmarker={,}
    au FileType javascript call MakeSpacelessBufferIabbrev('clog', 'console.log();<left><left>')

    " Make {<cr> insert a pair of brackets in such a way that the cursor is correctly
    " positioned inside of them AND the following code doesn't get unfolded.
    au Filetype javascript inoremap <buffer> {<cr> {}<left><cr><space><space>.<cr><esc>kA<bs>
    au Filetype javascript inoremap <buffer> [<cr> []<left><cr><space><space>.<cr><esc>kA<bs>
    " }

    " Prettify a hunk of JSON with <localleader>p
    au FileType javascript nnoremap <buffer> <localleader>p ^vg_:!python -m json.tool<cr>
    au FileType javascript vnoremap <buffer> <localleader>p :!python -m json.tool<cr>
    "au FilterWritePre * if &diff | colorscheme github | set conceallevel=0 | endif

    " Wrap a variable with ${} for string templates
    vmap <leader>] S}i$<esc>
  augroup END

"   }}}
"   Markdown {{{

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

"   }}}
"   Nginx {{{

  augroup ft_nginx
    au!

    au BufRead,BufNewFile /etc/nginx/conf/*                      set ft=nginx
    au BufRead,BufNewFile /etc/nginx/sites-available/*           set ft=nginx
    au BufRead,BufNewFile /usr/local/etc/nginx/sites-available/* set ft=nginx
    au BufRead,BufNewFile vhost.nginx                            set ft=nginx

    au FileType nginx setlocal foldmethod=marker foldmarker={,}
  augroup END

"   }}}
"   Puppet {{{

  augroup ft_puppet
    au!

    au Filetype puppet setlocal foldmethod=marker
    au Filetype puppet setlocal foldmarker={,}
  augroup END

"   }}}
"   PHP {{{
  augroup ft_php
    au!
    au FileType php,phtml setlocal tabstop=8
    au FileType php,phtml setlocal shiftwidth=4
    au FileType php,phtml setlocal softtabstop=4
    " Make {<cr> insert a pair of brackets in such a way that the cursor is correctly
    " positioned inside of them AND the following code doesn't get unfolded.
    au Filetype php inoremap <buffer> {<cr> {}<left><cr><space><space><space><space>.<cr><esc>kA<bs>
    au Filetype php inoremap <buffer> [<cr> []<left><cr><space><space><space><space>.<cr><esc>kA<bs>
  augroup END
"   }}}
"   QuickFix {{{


  augroup ft_quickfix
    au!
    au Filetype qf setlocal colorcolumn=0 nolist nocursorline nowrap tw=0
  augroup END

"   }}}
"   Ruby {{{

  augroup ft_ruby
    au!
    au Filetype ruby setlocal foldmethod=syntax
    au BufRead,BufNewFile Capfile setlocal filetype=ruby
  augroup END

"   }}}
"   snippets {{{
  augroup ft_snippet
    au!
    au BufRead,BufNewFile *.snippets set ft=snippets
    au BufRead,BufNewFile *.snippets set syntax=javascript
    au FileType snippets setlocal noexpandtab
    au FileType snippets setlocal copyindent
    au FileType snippets setlocal preserveindent
    au FileType snippets setlocal softtabstop=0
    au FileType snippets setlocal tabstop=2
    au FileType snippets setlocal shiftwidth=2
  augroup END
"   }}}
"   Standard In {{{

  augroup ft_stdin
    au!

    " Treat buffers from stdin (e.g.: echo foo | vim -) as scratch.
    au StdinReadPost * :set buftype=nofile
  augroup END

"   }}}
"   Vagrant {{{

  augroup ft_vagrant
    au!
    au BufRead,BufNewFile Vagrantfile set ft=ruby
  augroup END

"   }}}
"   Vim {{{

  augroup ft_vim
    au!

    au FileType vim setlocal foldmethod=marker
    au FileType help setlocal textwidth=78
    au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
  augroup END

"   }}}
"   YAML {{{

  augroup ft_yaml
    au!

    au FileType yaml set shiftwidth=2
  augroup END

"   }}}
"   XML {{{

  augroup ft_xml
    au!

    au FileType xml setlocal foldmethod=manual

    " Use <localleader>f to fold the current tag.
    au FileType xml nnoremap <buffer> <localleader>f Vatzf

    " Indent tag
    au FileType xml nnoremap <buffer> <localleader>= Vat=
  augroup END

"   }}}
" }}}
" Plugin settings --------------------------------------------------- {{{
"   ag {{{
"   }}}
"   Airline {{{
  let g:airline_powerline_fonts = 1
  let g:airline_theme = 'onedark'
"   }}}
"   Commentary {{{

nmap <leader>c <Plug>CommentaryLine
xmap <leader>c <Plug>Commentary

"   }}}
"   Ctrl-P {{{

let g:ctrlp_jump_to_buffer = 'ET'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_max_height = 20
let g:ctrlp_extensions = ['tag']
let g:ctrlp_follow_symlinks = 1

let g:ctrlp_map = '<leader>,'
nnoremap <leader>. :CtrlPTag<cr>
nnoremap <leader>E :CtrlP ../<cr>

let g:ctrlp_prompt_mappings = {
\ 'PrtSelectMove("j")':   ['<c-j>', '<down>', '<s-tab>'],
\ 'PrtSelectMove("k")':   ['<c-k>', '<up>', '<tab>'],
\ 'PrtHistory(-1)':       ['<c-n>'],
\ 'PrtHistory(1)':        ['<c-p>'],
\ 'ToggleFocus()':        ['<c-tab>'],
\ 'AcceptSelection("t")': [''],
\ 'AcceptSelection("e")': ['<cr>', '<2-LeftMouse>', '<c-t>'],
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
  \ --ignore eigen
  \ --ignore **/mocha/lib
  \ --ignore chef-solo
  \ --ignore chef
  \ --ignore back-end
  \ --ignore bower_components
  \ --ignore cache
  \ --ignore docker
  \ --ignore vision
  \ --ignore end-to-end-testing
  \ -g ""'

"   }}}
"   CtrlSpace {{{
  let g:CtrlSpaceDefaultMappingKey = "<C-space> "
  let g:CtrlSpaceSymbols = { "File": "◯", "CTab": "▣", "Tabs": "▢" }
  if executable("ag")
      let g:CtrlSpaceGlobCommand = 'ag -l --nocolor -g ""'
  endif
"   }}}
"   DBGPavim {{{
  let g:dbgPavimBreakAtEntry = 1
  "let g:dbgPavimPathMap = [['/home/jared/projects/vagrant-nginx/istock-src/', '/data/istock/']]
  let g:dbgPavimPathMap = [['/home/jared/projects/vagrant-apache/istock-src/', '/data/istock/']]
"   }}}
"   DelimitMate {{{

"   }}}
"   Deoplete {{{
  let g:deoplete#enable_at_startup = 1
  let g:deoplete#file#enable_buffer_path = 1
"   }}}
"   EasyAlign {{{
  " Start interactive EasyAlign in visual mode (e.g. vipga)
  xmap ga <Plug>(EasyAlign)

  " Start interactive EasyAlign for a motion/text object (e.g. gaip)
  nmap ga <Plug>(EasyAlign)
"   }}}
"   EasyMotion {{{
  map <Leader> <Plug>(easymotion-prefix)

  " <Leader>f{char} to move to {char}
  " map  <Leader>f <Plug>(easymotion-bd-f)
  " nmap <Leader>f <Plug>(easymotion-overwin-f)

  " s{char}{char} to move to {char}{char}
  nmap s <Plug>(easymotion-overwin-f2)

  " Move to line
  map <Leader>L <Plug>(easymotion-bd-jk)
  nmap <Leader>L <Plug>(easymotion-overwin-line)

  " Move to word
  map  <Leader>w <Plug>(easymotion-bd-w)
  nmap <Leader>w <Plug>(easymotion-overwin-w)
""   }}}
"   EnhacnedDiff {{{
  let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'
"   }}}
"   Fugitive {{{

" for some reason diff is opening in horizontal split instead of vertical
set diffopt+=vertical

nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gw :Gwrite<cr>
nnoremap <leader>ga :Gadd<cr>
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gco :Gcheckout<cr>
nnoremap <leader>gci :Gcommit<cr>
nnoremap <leader>gm :Gmove<cr>
nnoremap <leader>gr :Gremove<cr>
nnoremap <leader>gl :!git gl -18<cr>:wincmd \|<cr>

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

"   }}}
"   HTML5 {{{

  let g:event_handler_attributes_complete = 0
  let g:rdfa_attributes_complete = 0
  let g:microdata_attributes_complete = 0
  let g:atia_attributes_complete = 0

"   }}}
"   Indent Guides {{{
  let  g:indent_guides_auto_colors = 0
  autocmd VimEnter,ColorScheme * :hi IndentGuidesOdd guibg=#333333
  autocmd VimEnter,ColorScheme * :hi IndentGuidesEven guibg=#3f3f3f
"   }}}
"   Javascript Lib Syntax {{{
  let g:used_javascript_libs = 'd3,underscore,jquery,jasmine'
"   }}}
"   jsDoc {{{
  let g:jsdoc_allow_input_prompt = 1
  let g:jsdoc_input_description = 1
  let g:jsdoc_underscore_private = 1
  let g:jsdoc_enable_es6 = 1
"   }}}
"   Neomake {{{
  autocmd! BufWritePost * Neomake
  let g:neomake_javascript_enabled_makers = ['eslint']
  let g:neomake_open_list = 2
  let g:neomake_html_enabled_makers = []

"   }}}
"   Neosnippet {{{
  let g:neosnippet#disable_runtime_snippets = { '_' : 1 }
  let g:neosnippet#enable_snipmate_compatibility = 1
  let g:neosnippet#snippets_directory = '$HOME/.config/nvim/plugged/vim-snippets/snippets'
  " Plugin key-mappings.
  imap <C-k>     <Plug>(neosnippet_expand_or_jump)
  smap <C-k>     <Plug>(neosnippet_expand_or_jump)
  xmap <C-k>     <Plug>(neosnippet_expand_target)

  " SuperTab like snippets behavior.
  "imap <expr><TAB>
  " \ pumvisible() ? "\<C-n>" :
  " \ neosnippet#expandable_or_jumpable() ?
  " \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
  smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
  \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

  nnoremap <leader>rs :call neosnippet#variables#set_snippets({})<cr>

"   }}}
"   NERD Tree {{{

  noremap  <leader><F2> :NERDTreeToggle<cr>
  inoremap <leader><F2> <esc>:NERDTreeToggle<cr>
  noremap  <leader><F3> :NERDTreeFind<cr>
  inoremap <leader><F3> <esc>:NERDTreeFind<cr>

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
  let NERDTreeMapOpenInTab='\t'

"   }}}
"   Neomake {{{
  autocmd! BufWritePost * Neomake
"   }}}
"   Syntastic {{{
"  let g:syntastic_javascript_checkers = ['jshint', 'jscs']
"  let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']
"  let g:syntastic_php_phpcs_args="--report=csv --standard=PSR2"
"  let g:syntastic_error_symbol = '☒'
"  let g:syntastic_warning_symbol = '⚠'
"  let g:syntastic_style_error_symbol = '✗'
"  let g:syntastic_style_warning_symbol = '❗'
"  let g:syntastic_aggregate_errors = 1
"
"  nnoremap <silent> <C-e> :<C-u>call ToggleErrors()<CR>
"  function! ToggleErrors()
"    let old_last_winnr = winnr('$')
"    lclose
"    if old_last_winnr == winnr('$')
"      " Nothing was closed, open syntastic error location panel
"      Errors
"    endif
"  endfunction
"   Polyglot {{{
  let g:javascript_plugin_jsdoc = 1
  let g:javascript_plugin_ngdoc = 1
  let g:javascript_conceal_function       = "ƒ"
  let g:javascript_conceal_null           = "ø"
  let g:javascript_conceal_this           = "@"
  let g:javascript_conceal_return         = "⇚"
  let g:javascript_conceal_undefined      = "¿"
  let g:javascript_conceal_NaN            = "ℕ"
  let g:javascript_conceal_prototype      = "¶"
  let g:javascript_conceal_static         = "•"
  let g:javascript_conceal_super          = "Ω"
  let g:javascript_conceal_arrow_function = "⇒"
"   }}}
"   Syntastic {{{
  let g:syntastic_javascript_checkers = ['eslint']
  "let g:syntastic_javascript_checkers = ['jscs', 'jshint']
  let g:syntastic_error_symbol = '☒'
  let g:syntastic_warning_symbol = '⚠'
  let g:syntastic_style_error_symbol = '✗'
  let g:syntastic_style_warning_symbol = '❗'
  let g:syntastic_aggregate_errors = 1

  nnoremap <silent> <C-e> :<C-u>call ToggleErrors()<CR>
  function! ToggleErrors()
    let old_last_winnr = winnr('$')
    lclose
    if old_last_winnr == winnr('$')
      " Nothing was closed, open syntastic error location panel
      Errors
    endif
  endfunction
"   }}}
"   TagBar {{{
  nmap <leader><F4> :TagbarToggle<CR>
"   }}}
"   Tern {{{
  let g:tern_map_keys=1
"   }}}
"   UltiSnips {{{
  let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/plugged/UltiSnips',$HOME.'/.config/nvim/plugged/vim-snippets/UltiSnips']
  " Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
  let g:UltiSnipsExpandTrigger="<tab>"
  let g:UltiSnipsJumpForwardTrigger="<c-b>"
  let g:UltiSnipsJumpBackwardTrigger="<c-z>"
  " If you want :UltiSnipsEdit to split your window.
  let g:UltiSnipsEditSplit="vertical"
"   }}}
"   }}}
" }}}
" Mini-plugins ------------------------------------------------------ {{{
" Stuff that should probably be broken out into plugins, but hasn't proved to be
" worth the time to do so just yet.

"   Synstack {{{

  " Show the stack of syntax hilighting classes affecting whatever is under the
  " cursor.
  function! SynStack()
    echo join(map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")'), " > ")
  endfunc

  nnoremap <leader><F7> :call SynStack()<CR>

"   }}}
"   J {{{

function! s:JumpTo(dest)
  call system("tmux split-window -h 'j " . a:dest . "; and myctags &; and vim .'")
endfunction

command! -nargs=1 J call s:JumpTo(<f-args>)

"   }}}
"   Indent Guides {{{

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

"   }}}
"   Block Colors {{{

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

"   }}}
"   Pulse Line {{{

  function! s:Pulse() " {{{
    redir => old_hi
    silent execute 'hi CursorLine'
    redir END
    let old_clsetting = &cursorline
    let old_hi = split(old_hi, '\n')[0]
    let old_hi = substitute(old_hi, 'xxx', '', '')

    let steps = 8
    let width = 1
    let start = width
    let end = steps * width
    let color = 233

    set cursorline
    for i in range(start, end, width)
      execute "hi CursorLine ctermfg=fg ctermbg=" . (color + i)
      redraw
      sleep 6m
    endfor
    for i in range(end, start, -1 * width)
      execute "hi CursorLine ctermfg=fg ctermbg=" . (color + i)
      redraw
      sleep 6m
    endfor

    execute 'hi ' . old_hi
    if old_clsetting == 0
      set nocursorline
    endif
  endfunction " }}}
  command! -nargs=0 Pulse call s:Pulse()

"   }}}
"   ag {{{
  if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
  endif
  nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
  set switchbuf+=usetab,newtab
"   }}}
" }}}
