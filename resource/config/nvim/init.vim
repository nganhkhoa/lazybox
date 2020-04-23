" @Author: Nguyễn Anh Khoa <mail.nganhkhoa@gmail.com>
" @Date: 2018-12-31 17:48:56
" @Last Modified by: nganhkhoa <mail.nganhkhoa@gmail.com>
" +Last Modified time: 2020-04-23

" avaiable value:
"   deoplete
"   ale
"   coc
let g:luibo_lint_format = 'deoplete'

source $HOME/AppData/Local/nvim/plug.vim

source $HOME/AppData/Local/nvim/deoplete.vim
source $HOME/AppData/Local/nvim/coc.vim
source $HOME/AppData/Local/nvim/ale.vim
source $HOME/AppData/Local/nvim/commands.vim

source $HOME/AppData/Local/nvim/fvim.vim

" Common {{{
set nocompatible        " use real VIM
filetype plugin on
syntax on
" set verbose=13
set expandtab
set shiftround
set shiftwidth=2
set softtabstop=2
set linebreak
set modelines=5
" set foldenable
set foldlevelstart=10
set foldnestmax=10
set nofoldenable
set autoread
set autoindent
set number relativenumber
set signcolumn=yes

" set showbreak=↪\ "
set showbreak=\\ "
set list listchars=tab:‣\ ,trail:·,precedes:«,extends:»,eol:¬

" when install plugins, use /bin/sh
if has('unix')
set shell=/bin/sh       " /usr/bin/fish:/bin/bash:zsh?
endif

" let g:gruvbox_italic=1
set termguicolors
let $NVIM_TUI_ENABLE_TRUE_COLOR=1   " required by tender
colorscheme tender
highlight SignColumn guibg=#282828
" set guifont=FiraCode_Nerd_Font:h11
" set background=dark

" add current dir to runtimepath for use of UltiSnips
let cwd = getcwd()
execute "set runtimepath+=".fnameescape(cwd)

let mapleader=','
nnoremap j gj
nnoremap k gk
nnoremap <leader>s :mksession!<CR>
nnoremap <leader>S :mksession!<CR>:qa<CR>
nnoremap <space> za

" if in :term, esc will go to :visual
tnoremap <Esc> <C-\><C-n>

" record the last place when exit :insert
inoremap <esc> <esc>mm
inoremap jj <esc>mm

" Vim popup up down key
inoremap <expr> <S-j> pumvisible() ? "\<C-n>" : "\<S-j>"
inoremap <expr> <S-k> pumvisible() ? "\<C-p>" : "\<S-k>"
" inoremap <expr> <C-i> pumvisible() ? "\<C-y>" : "\<C-i>"

" allows cursor change in tmux mode
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor\
  " command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
  nnoremap <leader>a :Ag<space>
  let useAg = 1
else
  nnoremap <leader>a :echo("No Ag executable")<CR>
endif

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
au BufNewFile,BufRead *.ts setlocal ft=typescript
au BufNewFile,BufRead *.dart setlocal ft=dart
au BufNewFile,BufRead *.java,*.jav,*.aidl setlocal ft=java

set concealcursor=
set conceallevel=2
" }}}

" Language configuration {{{
let g:polyglot_disabled = [
\ 'markdown',
\ 'javascript'
\]
let g:markdown_fenced_languages = [
\ 'html',
\ 'python',
\ 'bash=sh',
\ 'shell=sh',
\ 'c',
\ 'cpp',
\ 'js=javascript',
\ 'ts=typescript',
\ 'go',
\ 'crystal',
\ 'asm',
\ 'nasm'
\]
let g:markdown_minlines = 200
let g:used_javascript_libs = 'react,chai,vue,angularjs'

" cpp highlight {{{
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_concepts_highlight = 1
let c_no_curly_error=1
" }}}

" Javascript {{{
let g:jsx_ext_required = 1
let g:javascript_plugin_flow = 1
" }}}

" Typescript {{{
" let g:typescript_compiler_binary = 'tsc'
" let g:typescript_compiler_options = '--experimentalDecorators'
" let g:tsuquyomi_disable_quickfix = 1
" }}}

" }}} Language configuration

" File, Buffer, Tab Manger {{{

" Vaffle {{{
function! OpenVaffle() abort
  if bufname('%') == ''
    call vaffle#init()
  else
    call vaffle#init(expand('%:p'))
  endif
endfunction
nnoremap <leader>dd :call OpenVaffle()<CR>
" let g:vaffle_show_hidden_files = 1
" }}}

" Buffergator {{{
let g:buffergator_display_regime = 'parentdir'
" }}}

" }}}

" Motions, Quick key {{{

" place {{{
nmap gi <Plug>(place-insert)
nmap gm <Plug>(place-insert-multiple)
" }}}

" Sideway {{{
nnoremap <S-h> :SidewaysLeft<cr>
nnoremap <S-l> :SidewaysRight<cr>
" }}}

" EasyAlign {{{
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" }}}

" Commentary {{{
" autocmd FileType apache setlocal commentstring=#\ %s
" }}}

" Move {{{
" move lines/block up/down by pressing <C-k>/<C-j>
" move characters right/left ...
let g:move_key_modifier = 'C'
" }}}

" vim-operator-surround {{{
" operator mappings
map <silent>sa <Plug>(operator-surround-append)
map <silent>sd <Plug>(operator-surround-delete)
map <silent>sr <Plug>(operator-surround-replace)

" delete or replace most inner surround

" if you use vim-textobj-multiblock
" nmap <silent>sdd <Plug>(operator-surround-delete)<Plug>(textobj-multiblock-a)
" nmap <silent>srr <Plug>(operator-surround-replace)<Plug>(textobj-multiblock-a)

" if you use vim-textobj-anyblock
" nmap <silent>sdd <Plug>(operator-surround-delete)<Plug>(textobj-anyblock-a)
" nmap <silent>srr <Plug>(operator-surround-replace)<Plug>(textobj-anyblock-a)

" if you use vim-textobj-between
" nmap <silent>sdb <Plug>(operator-surround-delete)<Plug>(textobj-between-a)
" nmap <silent>srb <Plug>(operator-surround-replace)<Plug>(textobj-between-a)
" }}}

" CamelCaseMotion {{{
" call camelcasemotion#CreateMotionMappings('<leader>')
" map <silent> w <Plug>CamelCaseMotion_w
" map <silent> b <Plug>CamelCaseMotion_b
" map <silent> e <Plug>CamelCaseMotion_e
" map <silent> ge <Plug>CamelCaseMotion_ge
" sunmap w
" sunmap b
" sunmap e
" sunmap ge
" }}}

" textobj-anyblock {{{
let g:textobj#anyblock#blocks = [ '(', '{', '[', '"', "'", '<' ]
" }}}

" }}}

" Quick scope {{{
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
" }}}

" overcommandline {{{
" nnoremap <silent> :%s :OverCommandLine<CR>%s/
" xnoremap <silent> :%s :'<,'>OverCommandLine<CR>s/
let g:over#command_line#substitute#replace_pattern_visually = 1
let g:over#command_line#search#enable_incsearch = 1
" }}}

" Fencview auto detect encoding {{{
let g:fencview_autodetect = 1
" }}}

" Status Line {{{
" Airline {{{
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme= 'tender' " 'minimalist'
let g:airline_powerline_fonts = 0
" set encoding=utf-8
" }}}

" Lightline {{{
set noshowmode  " Disable show mode info
set showtabline=2
let g:lightline = {}
let g:lightline.separator = { 'left': "\ue0b8", 'right': "\ue0be" }
let g:lightline.subseparator = { 'left': "\ue0b9", 'right': "\ue0b9" }
let g:lightline.tabline_separator = { 'left': "\ue0bc", 'right': "\ue0ba" }
let g:lightline.tabline_subseparator = { 'left': "\ue0bb", 'right': "\ue0bb" }

let g:lightline.active = {
\ 'left': [
\   [ 'artify_mode', 'paste' ],
\   [ 'readonly', 'filename', 'modified', 'devicons_filetype' ]
\ ],
\ 'right': [
\   [ 'devicons_fileformat', 'artify_lineinfo' ],
\   ['linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok'],
\ ]
\ }

let g:lightline.tabline = {
\ 'left': [ [ 'logo', 'tabs' ] ],
\ 'right': [ [ 'artify_gitbranch' ], [ 'gitstatus' ] ]
\ }

let g:lightline.component = {
\ 'logo':    "\ufb26",
\ 'readonly':    '%R',
\ 'paste':       '%{&paste?"PASTE":""}',
\ 'fileformat': '%{&fenc!=#""?&fenc:&enc}[%{&ff}]',
\ 'filetype': '%{&ft!=#""?&ft:"no ft"}',
\ 'artify_mode': '%{Artify_lightline_mode()}',
\ 'artify_lineinfo': "%2{Artify_line_percent()}\uf295 %3{Artify_line_num()}:%-2{Artify_col_num()}",
\ }

let g:lightline.component_function = {
\ 'devicons_filetype': 'Devicons_Filetype',
\ 'devicons_fileformat': 'Devicons_Fileformat',
\ 'gitbranch': 'gitbranch#name',
\ }

let g:lightline.component_expand = {
\  'linter_checking': 'lightline#lsc#checking',
\  'linter_warnings': 'lightline#lsc#warnings',
\  'linter_errors': 'lightline#lsc#errors',
\  'linter_ok': 'lightline#lsc#ok',
\ }

let g:lightline.tab_component_function = {
\ 'artify_activetabnum':   'Artify_active_tab_num',
\ 'artify_inactivetabnum': 'Artify_inactive_tab_num',
\ 'artify_filename':       'Artify_lightline_tab_filename',
\ 'filename':              'lightline#tab#filename',
\ 'modified':              'lightline#tab#modified',
\ 'readonly':              'lightline#tab#readonly',
\ 'tabnum':                'lightline#tab#tabnum'
\ }

let g:lightline#lsc#indicator_checking = "\uf110"
let g:lightline#lsc#indicator_notstarted = "\ufbab"
let g:lightline#lsc#indicator_errors = "\uf00d"
let g:lightline#lsc#indicator_ok = "\uf00c"

function! Artify_lightline_mode() abort
  return Artify(lightline#mode(), 'monospace')
endfunction
function! Artify_line_percent() abort
  return Artify(string((100*line('.'))/line('$')), 'bold')
endfunction
function! Artify_line_num() abort
  return Artify(string(line('.')), 'bold')
endfunction
function! Artify_col_num() abort
  return Artify(string(getcurpos()[2]), 'bold')
endfunction

function! Devicons_Filetype()
  " return winwidth(0) > 70 ? (strlen(&filetype) ? WebDevIconsGetFileTypeSymbol() . ' ' . &filetype : 'no ft') : ''
  " return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
  return strlen(&filetype) ? WebDevIconsGetFileTypeSymbol() : "\ufce0"
endfunction
function! Devicons_Fileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

" }}}
" }}}

" Raibow Parentheses Improved {{{
let g:rainbow_active = 1
let g:rainbow_conf = {
\    'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
\    'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
\    'operators': '_,_',
\    'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\    'separately': {
\        '*': {},
\        'tex': {
\            'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
\        },
\        'lisp': {
\            'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
\        },
\        'vim': {
\            'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
\        },
\        'html': {
\            'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
\        },
\        'css': 0,
\    }
\}
" }}}

" Mundo {{{
nnoremap <leader>u :MundoToggle<CR>
set undofile
set undodir=~/.vim/undo
" }}}

" Auto-pairs {{{
let g:AutoPairsFlyMode = 1
" }}}

" GGrep {{{
set grepprg=ag
let g:grep_cmd_opts = '--line-numbers --noheading'
" }}}

" UltiSnips {{{
" let g:UltiSnipsSnippetsDir = $HOME."/.config/UltiSnips"
let g:UltiSnipsSnippetDirectories = [
\   'UltiSnips',
\   $HOME.'/.vim/UltiSnips'
\]
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<S-l>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"
" }}}

" TagBar {{{
nmap <leader>tag :TagbarToggle<CR><C-W>p
" }}}

" File header {{{
let g:fileheader_default_author = 'Nguyen Anh Khoa'
let g:fileheader_author = 'Nguyen Anh Khoa'
let g:fileheader_default_email = 'ng.akhoa98@gmail.com'
let g:fileheader_email = 'ng.akhoa98@gmail.com'
let g:fileheader_by_git_config = 1
" }}}

" key sound {{{
let g:keysound_enable = 1
let g:keysound_theme = 'default'
let g:keysound_py_version = 3
let g:keysound_volume = 1000
" }}}

" {{{
let g:silicon = {
\ 'theme':              'Dracula',
\ 'font':                  'Hack',
\ 'background':         '#aaaaff',
\ 'shadow-color':       '#555555',
\ 'line-pad':                   2,
\ 'pad-horiz':                 80,
\ 'pad-vert':                 100,
\ 'shadow-blur-radius':         0,
\ 'shadow-offset-x':            0,
\ 'shadow-offset-y':            0,
\ 'line-number':           v:true,
\ 'round-corner':          v:true,
\ 'window-controls':       v:true,
\ }
" }}}

if getcwd() != $HOME.'/.config/nvim/' && filereadable(".vimrc")
  " source local project .vimrc
  source .vimrc
endif

" vim: foldmethod=marker:foldlevel=0:foldenable
