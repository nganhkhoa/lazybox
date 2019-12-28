if g:luibo_lint_format == 'ale'

command! ALEDisableFixers       let g:ale_fix_on_save=0
command! ALEEnableFixers        let g:ale_fix_on_save=1
command! ALEDisableFixersBuffer let b:ale_fix_on_save=0
command! ALEEnableFixersBuffer  let b:ale_fix_on_save=0

let g:airline#extensions#ale#enabled = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%][%severity%] %s'
nmap <silent> <C-n>E <Plug>(ale_previous_wrap)
nmap <silent> <C-n>e <Plug>(ale_next_wrap)

let g:ale_fix_on_save = 1
let g:ale_lint_on_enter = 1
let g:ale_lint_on_insert_leave = 1
let g:ale_linters_explicit = 1
" let g:ale_lint_on_text_changed = 'always'
let g:ale_completion_delay = 1000
let g:ale_lint_delay = 500

" Gutter setup
" SignColumn should fit the theme setting g:terminal_color_foreground
" let g:ale_sign_column_always = 1
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'

let g:ale_linters = {
\   'python': ['flake8', 'mypy'],
\   'javascript': ['eslint'],
\   'typescript': ['tslint'],
\   'c': ['clangcheck'],
\   'cpp': ['clangcheck'],
\   'java': ['javac'],
\   'go': ['gopls'],
\}

let g:ale_fixers = {
\   'python': ['black'],
\   'javascript': ['prettier'],
\   'typescript': ['prettier'],
\   'c': ['clang-format'],
\   'cpp': ['clang-format'],
\   'java': ['google_java_format']
\}

" Python {{{
let g:ale_python_mypy_options = '--ignore-missing-imports'
let g:ale_python_autopep8_options = '-a -a -a'
" }}}

" Javascript && Typescript {{{
" let g:ale_javascript_eslint_options = '--fix-dry-run'
" let g:ale_javascript_eslint_executable='eslint_d'
let g:ale_javascript_prettier_use_global = 1
let g:ale_javascript_prettier_use_local_config = 1
let g:ale_javascript_prettier_options = '--single-quote'
let g:ale_typescript_tslint_use_global = 1
" let g:ale_typescript_tslint_config_path = ''
" }}}

" C/C++ {{{
let g:ale_cpp_clangcheck_options = ''
let g:ale_cpp_clangcheck_executable = 'clang-check'
let g:ale_c_clangcheck_executable = 'clang-check'
let g:ale_c_clangformat_executable = 'clang-format'
let g:ale_c_clangformat_options = '-style="{
\ DerivePointerAlignment: false,
\ PointerAlignment: Left,
\ AlignAfterOpenBracket: AlwaysBreak,
\ SortIncludes: false,
\ AllowShortFunctionsOnASingleLine: SFS_None
\}"'
" }}}

" Java {{{
" let g:ale_java_google_java_format_executable = "google_java_format"
" }}}

endif
