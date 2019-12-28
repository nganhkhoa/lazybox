if g:luibo_lint_format == 'deoplete'

let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#clang#libclang_path = '/usr/lib64/libclang.so'
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

let g:LanguageClient_rootMarkers = {
\ 'javascript': ['.flowconfig', 'package.json']
\ }
let g:LanguageClient_serverCommands = {
\ 'cpp': ['cquery', '--log-file=/tmp/cq.log'],
\ 'c': ['cquery', '--log-file=/tmp/cq.log'],
\ 'typescript': ['js-ts-lsp-stdio.js'],
\ 'javascript': ['flow', 'lsp'],
\ 'javascript.jsx': ['flow', 'lsp'],
\ 'go': ['gopls'],
\ 'python': ['pyls']
\ }

let g:LanguageClient_autoStart = 1

let g:LanguageClient_loadSettings = 1
let g:LanguageClient_settingsPath = $HOME.'/.config/nvim/settings.json'
let g:LanguageClient_hoverPreview = 'Always'
set completefunc=LanguageClient#complete
set formatexpr=LanguageClient_textDocument_rangeFormatting()

nnoremap <silent> gh :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> gr :call LanguageClient#textDocument_references()<CR>
nnoremap <silent> gm :call LanguageClient#textDocument_documentSymbol()<CR>
nnoremap <silent> gf :call LanguageClient#textDocument_formatting()<CR>
" nnoremap <silent> gs :LanguageClientStop<CR>
" nnoremap <silent> gs :call LanguageClient#textDocument_documentSymbol()<CR>

endif
