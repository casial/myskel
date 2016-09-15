call plug#begin('~/vim.plugged')
Plug 'benjifisher/matchit.zip'
Plug 'bling/vim-airline'
Plug 'cakebaker/scss-syntax.vim'
Plug 'chikamichi/mediawiki.vim'
Plug 'chriskempson/tomorrow-theme'
Plug 'elixir-lang/vim-elixir'
Plug 'ervandew/supertab'
Plug 'fcpg/vim-whiplash'
Plug 'freeo/vim-kalisi'
Plug 'gcavallanti/vim-noscrollbar'
Plug 'gosukiwi/vim-atom-dark'
Plug 'joshdick/onedark.vim'
Plug 'junegunn/seoul256.vim'
Plug 'KabbAmine/yowish.vim'
Plug 'Lokaltog/vim-distinguished'
Plug 'mbbill/undotree'
Plug 'morhetz/gruvbox'
Plug 'mtglsk/mushroom'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'nanotech/jellybeans.vim'
Plug 'octol/vombatidae-vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/syntastic'
Plug 'sjl/badwolf'
Plug 'slim-template/vim-slim'
Plug 't9md/vim-ruby-xmpfilter'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vividchalk'
Plug 'unblevable/quick-scope'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-ruby/vim-ruby'
Plug 'vim-scripts/SeeTab'
Plug 'w0ng/vim-hybrid'
Plug 'wellsjo/wells-colorscheme.vim'
call plug#end()
set tabstop=8
"tab width
set softtabstop=4
"for viewing
set shiftwidth=4
" for >>  and <<
set expandtab
set redraw
"set tw=79
"256 color support
if &term == 'xterm-color' || &term == 'screen-256color' || &term == 'xterm-256color'
    set t_Co=256
endif
set autoread "stop telling me my chmod has changed the file?
set bs=2		" allow backspacing over everything in insert mode
set ai			" always set autoindenting on
set backup		" keep a backup file
set backupdir=$HOME/tmp   " directory of backup files
set viminfo='20,\"50,:50	" read/write a .viminfo file, don't store more
                        " than 50 lines of registers
set history=1000	" keep 50 lines of command line history
set wildmenu
" Set command-line completion mode:
"   - on first <Tab>, when more than one match, list all matches and complete
"     the longest common  string
"   - on second <Tab>, complete the next full match and show menu
set wildmode=list:longest,full
" Use UTF-8 as the default buffer encoding
set enc=utf-8
set encoding=utf-8

" as nice as this would be, it makes vim DOG slow
"set foldenable
"set foldmethod=syntax
"set foldlevel=999 " make it really high, so they're not displayed by default
"colorscheme xoria256
"colorscheme badwolf
"colorscheme seoul256
set background=dark
"colorscheme gruvbox
"colorscheme vombatidae
colorscheme jellybeans

let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4

set laststatus=2
let g:airline_powerline_fonts = 0
let g:airline_detect_paste=1
let g:airline_detect_modified=1
let g:airline#syntastic#enabled  = 1
let g:airline_detect_modified=1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = '⮀'
let g:airline_left_alt_sep = '⮁'
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'
let g:airline_symbols.branch = '⭠'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '⭡'

" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

function! Noscrollbar(...)
    let w:airline_section_z = '%{noscrollbar#statusline(20,'' '',''█'',[''▐''],[''▌''])}'
    "let w:airline_section_z = '%{noscrollbar#statusline()}'
endfunction
call airline#add_statusline_func('Noscrollbar')
"let w:airline_section_z = '%{noscrollbar#statusline(20,'' '',''█'',[''▐''],[''▌''])}'
"let w:airline_section_z = '%{noscrollbar#statusline(9,''■'',''◫'',[''◧''],[''◨''])}'

"ctrlspace stuff
let g:airline_exclude_preview = 1

"xmpfilter stuff
autocmd FileType ruby nmap <buffer> <F3> <Plug>(xmpfilter-mark)
autocmd FileType ruby xmap <buffer> <F3> <Plug>(xmpfilter-mark)
autocmd FileType ruby imap <buffer> <F3> <Plug>(xmpfilter-mark)

autocmd FileType ruby nmap <buffer> <F4> <Plug>(xmpfilter-run)
autocmd FileType ruby xmap <buffer> <F4> <Plug>(xmpfilter-run)
autocmd FileType ruby imap <buffer> <F4> <Plug>(xmpfilter-run)

" detect puppet filetype
"au BufRead,BufNewFile *.pp              set filetype=puppet

let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'


" For UndoTree
if has("persistent_undo")
    set undodir=~/tmp/
    set undofile
endif

" show tabs and trailing whitespace visually
"set list listchars=tab:>-,trail:.,extends:>
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮,trail:⌴
set showbreak=↪
set title

" Enable loading filetype and indentation plugins
filetype plugin on
filetype indent on
if v:version > 700
    map <leader>d :NERDTreeToggle<CR>
    " quit NERDTree after openning a file
    let NERDChristmasTree=1
    let NERDTreeQuitOnOpen=1
    let NERDTreeIgnore=['\.git','\.svn']
    " Insert mode completion options
    set completeopt=menu,longest,preview
    " use CTRL-F for omni completion
    imap <C-F> ^X^O
    "set spell
    "let spell_auto_type = "mail"
endif

" If we're in a wide window, enable line numbers.
fun! <SID>WindowWidth()
    if winwidth(0) > 90
        setlocal number
        " If possible, try to use a narrow number column.
        if v:version >= 700
            try
                setlocal numberwidth=3
                setlocal foldcolumn=2
            catch
            endtry
        endif
    endif
endfun

" Automagic line numbers
autocmd BufEnter * :call <SID>WindowWidth()
" Always do a full syntax refresh
"autocmd BufEnter * syntax sync

set ignorecase            " ignore case in search patterns
set undolevels=1000

" Settings for taglist.vim
let Tlist_Use_Right_Window=1
let Tlist_Auto_Open=0
let Tlist_Enable_Fold_Column=0
let Tlist_Compact_Format=1
let Tlist_WinWidth=28
let Tlist_Exit_OnlyWindow=1
let Tlist_File_Fold_Auto_Close = 1
nnoremap <silent> <F9> :Tlist<CR>

" Project.vim settings
let g:proj_window_width=10


" indent guides stuff
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1
let g:indent_guides_enable_on_vim_startup=1

iabbrev _sf support@1r46vcjt0wvvysdxj4ysri0k6.in.salesforce.com
iabbrev _hh 
\I hope you find this information helpful. Please let me know if you have any additional questions or if I can be of further assistance.
\<CR>
\<CR>Thanks,
\<CR>Sam Rowe
iabbrev _ty 
\Thanks,
\<CR>Sam Rowe
iabbrev _output Thanks for sending that output, it was very helpful.
iabbrev _copy Please always copy support@coraid.com to ensure a prompt reply in the event that I'm unavailable and to ensure that your emails are archived in your support ticket.
iabbrev _me  Sam Rowe
iabbrev _cdu http://support.coraid.com/support/quickstart/usingCoraid-diags.html
iabbrev _email sam@samrowe.com
iabbrev ldis ಠ_ಠ
"ab _pre echo "<pre>\n";
"ab _Pre echo "</pre>\n";
"ab _var var_dump(
"ab _dg debug_grab( 
"ab _ed debugend();
"ab _de debugend();
"ab _head header("Content-Type: text/plain");
iabbrev _webex https://nimblestorage.webex.com/meet/Sam.Rowenimblestorage.com

noremap  <F1> :checktime<cr>
inoremap <F1> <esc>:checktime<cr>
" Use sane regexes.
nnoremap / /\v
vnoremap / /\v
" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv


" ,E : Execute current line.
map ,E 0/\$<CR>w"yy$:<C-R>y<C-A>r!<C-E>
" Edit my .vimrc file.
map ,v :e ~/.vimrc

" Update the system settings from my vimrc file.
map ,u :source ~/.vimrc<cr>

" use ctrl+space as an escape key
imap <C-Space> <esc>
imap jj <esc>
imap <F1> <esc>

" Smoother changes
set ttyfast
"Show uncompleted command
set showcmd
"Show matching parenthesis
"set showmatch
"Show current mode
"set showmode
:let loaded_matchparen = 1

nmap :WQ :wq
" map S to replace the current word with a previously yanked one
nmap <silent> S :let @x=@"<CR>"_diw"xP

"map <F2> :call WebMe()<cr>
"map <F3> !} fmt -c -w 72<cr>
map  !} fmt -w 72<cr>
"map <F4> {<CR>}<C-O>O
"map <F3> gqap
imap <F7>  <esc>:call ReplacePlaceHolder()<cr>a
nmap <F7>  :call ReplacePlaceHolder()<cr>
nmap <LocalLeader>m <ESC>:call PhpActOnVariable()<cr>
map <F10> :set paste<CR>i
map <F11> :set nopaste<CR>
imap <F10> <C-O>:set paste<CR>
imap <F11> <nop>
set pastetoggle=<F11>
" use par for formatting:
"set equalprg=par\ -gjw72

nmap <silent> <C-N> :silent noh<cr>
set scrolloff=6

" Use ctrl+vim movement keys for movement within :split windows
noremap <C-J> <C-W>j<C-W>_
noremap <C-K> <C-W>k<C-W>_

" Map <CTRL>-E to run PHP parser check
"noremap <C-E> :!php4 -l %<CR>
" Intelligent tab completion
"inoremap <silent> <Tab> <C-r>=<SID>InsertTabWrapper(1)<CR>
"inoremap <silent> <S-Tab> <C-r>=<SID>InsertTabWrapper(-1)<CR>

" detect puppet filetype
"au BufRead,BufNewFile *.pp              set filetype=puppet

" Only do this part when compiled with support for autocommands
if has("autocmd")
  " In text files, always limit the width of text to 78 characters
  "autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  "if &modifiable
  if argv(0) != 'less.sh' || &modifiable
      "autocmd BufReadPost * if line("'\"") | exe "'\"" | endif
      au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif 
  endif
  au FileType gitcommit startinsert
  au Filetype gitcommit setlocal spell textwidth=72
endif

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  " Don't try to highlight lines longer than 800 characters.
  set synmaxcol=800
  set hlsearch
endif

if has("autocmd")
 augroup cprog
  " Remove all cprog autocommands
  au!

  " When starting to edit a file:
  "   For C and C++ files set formatting of comments and set C-indenting on.
  "   For other files switch it off.
  "   Don't change the order, it's important that the line with * comes first.
  autocmd FileType *      set formatoptions=tcql nocindent comments&
  autocmd FileType c,cpp  set formatoptions=croql cindent comments=sr:/*,mb:*,el:*/,://
 augroup END
endif

" content creation
if has("autocmd")
    augroup content
        autocmd!

"        autocmd BufNewFile *.rb 0put ='# vim: set sw=4 sts=4 et tw=0 :' |
"                    \ 0put ='#!/usr/bin/ruby' | set sw=4 sts=4 et tw=0 |
"                    \ norm G
        autocmd BufNewFile *.sh 0put ='# vim: set sw=4 sts=4 et tw=0 :' |
                    \ 0put ='#!/bin/sh' | set sw=4 sts=4 et tw=0 |
                    \ norm G
"        autocmd BufNewFile *.php 0put ='# vim: set sw=4 sts=4 et tw=0 :' |
"                    \ 0put ='<?php' | set sw=4 sts=4 et tw=0 |
"                    \ norm G
    augroup END
endif

" Disable the damned mousewheel
:nmap <ScrollWheelUp> <nop>
:nmap <S-ScrollWheelUp> <nop>
:nmap <C-ScrollWheelUp> <nop>
:nmap <ScrollWheelDown> <nop>
:nmap <S-ScrollWheelDown> <nop>
:nmap <C-ScrollWheelDown> <nop>
:nmap <ScrollWheelLeft> <nop>
:nmap <S-ScrollWheelLeft> <nop>
:nmap <C-ScrollWheelLeft> <nop>
:nmap <ScrollWheelRight> <nop>
:nmap <S-ScrollWheelRight> <nop>
:nmap <C-ScrollWheelRight> <nop>


" ===================================================================
" ASCII tables - you may need them some day.  Save them to a file!
" ===================================================================
"
" ASCII Table - | octal value - name/char |
"
" |000 nul|001 soh|002 stx|003 etx|004 eot|005 enq|006 ack|007 bel|
" |010 bs |011 ht |012 nl |013 vt |014 np |015 cr |016 so |017 si |
" |020 dle|021 dc1|022 dc2|023 dc3|024 dc4|025 nak|026 syn|027 etb|
" |030 can|031 em |032 sub|033 esc|034 fs |035 gs |036 rs |037 us |
" |040 sp |041  ! |042  " |043  # |044  $ |045  % |046  & |047  ' |
" |050  ( |051  ) |052  * |053  + |054  , |055  - |056  . |057  / |
" |060  0 |061  1 |062  2 |063  3 |064  4 |065  5 |066  6 |067  7 |
" |070  8 |071  9 |072  : |073  ; |074  < |075  = |076  > |077  ? |
" |100  @ |101  A |102  B |103  C |104  D |105  E |106  F |107  G |
" |110  H |111  I |112  J |113  K |114  L |115  M |116  N |117  O |
" |120  P |121  Q |122  R |123  S |124  T |125  U |126  V |127  W |
" |130  X |131  Y |132  Z |133  [ |134  \ |135  ] |136  ^ |137  _ |
" |140  ` |141  a |142  b |143  c |144  d |145  e |146  f |147  g |
" |150  h |151  i |152  j |153  k |154  l |155  m |156  n |157  o |
" |160  p |161  q |162  r |163  s |164  t |165  u |166  v |167  w |
" |170  x |171  y |172  z |173  { |174  | |175  } |176  ~ |177 del|
"
" ===================================================================
" ASCII Table - | decimal value - name/char |
"
" |000 nul|001 soh|002 stx|003 etx|004 eot|005 enq|006 ack|007 bel|
" |008 bs |009 ht |010 nl |011 vt |012 np |013 cr |014 so |015 si |
" |016 dle|017 dc1|018 dc2|019 dc3|020 dc4|021 nak|022 syn|023 etb|
" |024 can|025 em |026 sub|027 esc|028 fs |029 gs |030 rs |031 us |
" |032 sp |033  ! |034  " |035  # |036  $ |037  % |038  & |039  ' |
" |040  ( |041  ) |042  * |043  + |044  , |045  - |046  . |047  / |
" |048  0 |049  1 |050  2 |051  3 |052  4 |053  5 |054  6 |055  7 |
" |056  8 |057  9 |058  : |059  ; |060  < |061  = |062  > |063  ? |
" |064  @ |065  A |066  B |067  C |068  D |069  E |070  F |071  G |
" |072  H |073  I |074  J |075  K |076  L |077  M |078  N |079  O |
" |080  P |081  Q |082  R |083  S |084  T |085  U |086  V |087  W |
" |088  X |089  Y |090  Z |091  [ |092  \ |093  ] |094  ^ |095  _ |
" |096  ` |097  a |098  b |099  c |100  d |101  e |102  f |103  g |
" |104  h |105  i |106  j |107  k |108  l |109  m |110  n |111  o |
" |112  p |113  q |114  r |115  s |116  t |117  u |118  v |119  w |
" |120  x |121  y |122  z |123  { |124  | |125  } |126  ~ |127 del|
"
" ===================================================================
" ASCII Table - | hex value - name/char |
"
" | 00 nul| 01 soh| 02 stx| 03 etx| 04 eot| 05 enq| 06 ack| 07 bel|
" | 08 bs | 09 ht | 0a nl | 0b vt | 0c np | 0d cr | 0e so | 0f si |
" | 10 dle| 11 dc1| 12 dc2| 13 dc3| 14 dc4| 15 nak| 16 syn| 17 etb|
" | 18 can| 19 em | 1a sub| 1b esc| 1c fs | 1d gs | 1e rs | 1f us |
" | 20 sp | 21  ! | 22  " | 23  # | 24  $ | 25  % | 26  & | 27  ' |
" | 28  ( | 29  ) | 2a  * | 2b  + | 2c  , | 2d  - | 2e  . | 2f  / |
" | 30  0 | 31  1 | 32  2 | 33  3 | 34  4 | 35  5 | 36  6 | 37  7 |
" | 38  8 | 39  9 | 3a  : | 3b  ; | 3c  < | 3d  = | 3e  > | 3f  ? |
" | 40  @ | 41  A | 42  B | 43  C | 44  D | 45  E | 46  F | 47  G |
" | 48  H | 49  I | 4a  J | 4b  K | 4c  L | 4d  M | 4e  N | 4f  O |
" | 50  P | 51  Q | 52  R | 53  S | 54  T | 55  U | 56  V | 57  W |
" | 58  X | 59  Y | 5a  Z | 5b  [ | 5c  \ | 5d  ] | 5e  ^ | 5f  _ |
" | 60  ` | 61  a | 62  b | 63  c | 64  d | 65  e | 66  f | 67  g |
" | 68  h | 69  i | 6a  j | 6b  k | 6c  l | 6d  m | 6e  n | 6f  o |
" | 70  p | 71  q | 72  r | 73  s | 74  t | 75  u | 76  v | 77  w |
" | 78  x | 79  y | 7a  z | 7b  { | 7c  | | 7d  } | 7e  ~ | 7f del|
" ===================================================================
"noh
