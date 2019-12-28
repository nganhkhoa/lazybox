call plug#begin()
Plug 'junegunn/vim-plug'

" Interface {{{
" Plug 'vim-airline/vim-airline'                  " status bar
" Plug 'vim-airline/vim-airline-themes'           " status bar theme
" Plug 'itchyny/lightline.vim'                    " line/tag bar
Plug 'sainnhe/artify.vim'                       " change text display
Plug 'ryanoasis/vim-devicons'
" Plug 'luochen1990/rainbow'                      " bracket highlight
Plug 'bronson/vim-trailing-whitespace'          " :FixWhitespace
Plug 'Yggdroot/indentLine'                      " indent guides
Plug 'valloric/matchtagalways'
" Plug 'junegunn/limelight.vim'                   " iA writer focus mode
" Theme
Plug 'rafi/awesome-vim-colorschemes'            " theme++
Plug 'flazz/vim-colorschemes'                   " theme++
Plug 'archseer/colibri.vim'                     " theme
Plug 'drewtempelmeyer/palenight.vim'            " theme
Plug 'NLKNguyen/papercolor-theme'               " theme
Plug 'dracula/vim', { 'as': 'dracula-vim' }     " theme
Plug 'raphamorim/lucario'                       " theme
Plug 'w0ng/vim-hybrid'                          " theme
Plug 'morhetz/gruvbox'                          " theme
Plug 'reedes/vim-colors-pencil'                 " theme
Plug 'ayu-theme/ayu-vim'                        " theme
Plug 'jacoborus/tender.vim'                     " theme
Plug 'rakr/vim-one'                             " theme
" }}}

" Dark power {{{
if empty($FZF_ROOT)
  " use ctrlp
  Plug 'ctrlpvim/ctrlp.vim'                     " file search
else
  " use fzf
  Plug expand($FZF_ROOT)                        " include fzf root
  Plug 'junegunn/fzf.vim'                       " fzf for vim
endif

" project manager
Plug 'cocopon/vaffle.vim'                       " file manager | netrw++
Plug 'jeetsukumaran/vim-buffergator'            " list buffer
" git
Plug 'tpope/vim-fugitive'                       " git wrapper
Plug 'sodapopcan/vim-twiggy'                    " git branch visualize      | fugitive+
Plug 'junegunn/gv.vim'                          " git commit browser        | fugitive+
Plug 'vrybas/vim-flayouts'                      " layout for fugitive       | fugitive+
Plug 'rhysd/git-messenger.vim'                  " git blame
" motion++
Plug 'kana/vim-operator-user'                   " define own operator
Plug 'rhysd/vim-operator-surround'              " vim-surround alternative
Plug 'bkad/CamelCaseMotion'                     " better motion between text
Plug 'b4winckler/vim-angry'                     " argument object, with multilines support
" Plug 'vim-scripts/argtextobj.vim'               " argument object
" edit++
Plug 'tomtom/tcomment_vim'                      " quick comment code
Plug 'junegunn/vim-easy-align'                  " easy align
Plug 'matze/vim-move'                           " quick moving text up/down
Plug 'joereynolds/place.vim'                    " add text without move to text
Plug 'vim-scripts/sideways.vim'                 " change argument order (Map to <S-H> and <S-L> and try)
Plug 'osyo-manga/vim-over'                      " substitute preview
" find++
" Plug 'chrisbra/improvedft'                      " Improve f/t to work on multiple line
" Plug 'rhysd/clever-f.vim'                       " continuous find
Plug 'unblevable/quick-scope'                   " highlight first occurance on f/t
Plug 'nelstrom/vim-visual-star-search'          " works for visual select on */#
" vim++
Plug 'm1foley/vim-expresso'                     " doing math on vim, why not?
Plug 'metakirby5/codi.vim'                      " using repl on vim
" note++
Plug 'reedes/vim-pencil'                        " tool for writing in vim
Plug 'mtth/scratch.vim'                         " scratch buffer
Plug 'xolox/vim-notes'
Plug 'xolox/vim-misc'
" others
Plug 'tpope/vim-unimpaired'                     " quick command for many stuff
Plug 'yuttie/comfortable-motion.vim'            " smooth scrolling
Plug 'simnalamburt/vim-mundo'                   " changes review
Plug 'mbbill/fencview'                          " auto detect encodings
Plug 'tpope/vim-sleuth'                         " auto detect indentation
" Plug 'junegunn/vim-peekaboo'                    " :registers on copy, paste
Plug 'ahonn/vim-fileheader'                     " AddFileHeader, UpdateFileHeader
Plug 'wakatime/vim-wakatime'                    " waka time tracker
" Plug 'skywind3000/vim-keysound'                 " typing sound
" Plug 'rlue/vim-barbaric'                        " auto switch input methods
Plug 'segeljakt/vim-silicon'
" }}}

" highlighter + linter + formater + other code related {{{
if g:luibo_lint_format == 'deoplete'
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'tenfyzhong/CompleteParameter.vim'
" Plug 'zchee/deoplete-clang'
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Plug 'deoplete-plugins/deoplete-jedi'
" Plug 'carlitux/deoplete-ternjs', { 'do': 'yarn global add tern' }
" Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
  " Plug 'HerringtonDarkholme/yats.vim'           " nvim-typescript requires
" Plug 'SevereOverfl0w/deoplete-github'
Plug 'autozimu/LanguageClient-neovim', {
\ 'branch': 'next',
\ 'do': 'bash install.sh',
\ }
Plug 'Palpatineli/lightline-lsc-nvim'
endif

if g:luibo_lint_format == 'coc'
Plug 'neoclide/coc.nvim', {
\ 'tag': '*',
\ 'do': { -> coc#util#install()}
\ }                                             " code completion
endif

if g:luibo_lint_format == 'ale'
Plug 'w0rp/ale'                                 " lint, format
endif

Plug 'liuchengxu/vista.vim'                     " LSP Symbols

" most of the language plugin are packed with vim-polyglot
Plug 'sheerun/vim-polyglot'                     " syntax++
Plug 'justinmk/vim-syntax-extra'                " c,bison,flex
Plug 'chrisbra/csv.vim'                         " csv
Plug 'harenome/vim-mipssyntax'                  " mips
Plug 'shiracamus/vim-syntax-x86-objdump-d'      " x86 objdump
Plug 'jrozner/vim-antlr'                        " antlr
Plug 'tpope/vim-markdown'                       " markdown
Plug 'othree/yajs.vim'                          " javascript
Plug 'othree/javascript-libraries-syntax.vim'   " javascript++ { React, Angular, Vue, ... }
Plug 'maxmellon/vim-jsx-pretty'                 " better jsx
Plug 'reasonml-editor/vim-reason-plus'          " reason
Plug 'jxnblk/vim-mdx-js'                        " mdx
Plug 'Shougo/vinarise.vim'                      " edit hex file

call plug#end()
