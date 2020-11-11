if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | q | source $MYVIMRC
  let g:first_install = 1
else
  let g:init_vim_loaded = 1
endif

if !has('nvim-0.5')
  " Use treesitter instead
  let g:polyglot_disbled = ['javascript']
endif

call plug#begin('~/.config/nvim/plugged')

" File explorer
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'airblade/vim-rooter'

" Editing
Plug 'remko/detectindent', { 'on': 'DetectIndent' }
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'jiangmiao/auto-pairs'
Plug 'itchyny/vim-parenmatch'
Plug 'christoomey/vim-sort-motion'
Plug 'AndrewRadev/switch.vim'
Plug 'tpope/vim-speeddating'

" Autocompletion
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'wellle/tmux-complete.vim'

" Debugging
Plug 'puremourning/vimspector'

" Window Manager
Plug 'szw/vim-maximizer'

" Visualization
Plug 'Yggdroot/indentLine'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'AndrewRadev/linediff.vim'
Plug 'machakann/vim-highlightedyank'

" Navigation
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Experimental: A replacement for fzf
" Currently does not perform well compared to fzf itself
" Plug 'nvim-lua/popup.nvim'
" Plug 'nvim-lua/plenary.nvim'
" Plug 'nvim-lua/telescope.nvim'

Plug 'tpope/vim-rsi'
Plug 'wellle/targets.vim'
Plug 'christoomey/vim-tmux-navigator', { 'on': [] }
" Plug 'yuttie/comfortable-motion.vim' " Disabled due to screen lags
Plug 'justinmk/vim-sneak'

" Syntax Highlight
Plug 'norcalli/nvim-colorizer.lua'
Plug 'sheerun/vim-polyglot'
Plug 'kien/rainbow_parentheses.vim'
if has('nvim-0.5')
  Plug 'nvim-treesitter/nvim-treesitter' " Experimental until nvim-0.5
endif

" Linting
Plug 'dense-analysis/ale'

" Languages
Plug 'moll/vim-node'
Plug 'othree/yajs.vim'
Plug 'othree/es.next.syntax.vim'

" Documentation
Plug 'kkoomen/vim-doge', { 'on': 'DogeGenerate' }

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'rhysd/git-messenger.vim'

" Appearances
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'maximbaz/lightline-ale'
Plug 'mhinz/vim-startify'
Plug 'skywind3000/vim-quickui'

" Standard
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-sensible'

" Tracking
Plug 'wakatime/vim-wakatime'

" Session management
Plug 'tpope/vim-obsession'
Plug 'djoshea/vim-autoread'

" Color scheme
" Plug 'gruvbox-community/gruvbox'
" Plug 'joshdick/onedark.vim'
Plug 'arcticicestudio/nord-vim'

call plug#end()

if !exists('g:init_vim_loaded')
  finish
endif

" Automatically install missing plugins on startup
autocmd VimEnter *
\  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
\  |   PlugInstall --sync | q
\  | endif

syntax on

augroup lazyload_plugins
  autocmd!
  autocmd CursorHold * call plug#load('vim-tmux-navigator') | autocmd! lazyload_plugins
augroup END

" nvim-tree.lua
let g:lua_tree_icons = {
\   'default': ' '
\ }
let g:lua_tree_ignore = ['.git', '.DS_Store']
let g:lua_tree_follow = 1

autocmd BufEnter,FileType LuaTree let &cursorline=1
autocmd BufLeave,BufWinLeave LuaTree let &cursorline=0

" NERDCommenter
let g:NERDSpaceDelims = 1

" vim-markdown
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

" fzf
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.9, 'height': 0.9,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }
let g:fzf_preview_window = 'right:50%'

" Coc
let g:coc_global_extensions = [
\   'coc-json',
\   'coc-tsserver',
\   'coc-html',
\   'coc-css',
\   'coc-rls',
\   'coc-yaml',
\   'coc-python',
\   'coc-emmet',
\ ]

" ALE
" Only run on open or save file
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0

" QuickUI
let g:quickui_show_tip = 1
let g:quickui_border_style = 2
let g:quickui_color_scheme = 'papercol dark'

call quickui#menu#reset()

call quickui#menu#install('&File', [
\   ["&New Buffer\t:enew", 'enew', 'Create a new empty buffer in current window'],
\   ["New &Vertical Buffer\t:vnew", 'vnew', 'Create a new empty buffer in a new vertical split'],
\   ['--'],
\   ["&Save\t,w", 'write', 'Save changes on current buffer'],
\   ["Save &All\t:wall", 'wall', 'Save changes on all buffers'],
\   ['--'],
\   ["&Reload %{&modified?'Unsaved ':''}Buffer\t:edit!", 'edit!', 'Reload current buffer'],
\   ["Close &Window\t<C-w>q", 'close', 'Close current window'],
\   ["&Close %{&modified?'Unsaved ':''}Buffer\t<A-w>", 'bdelete!', 'Close current buffer'],
\   ["Close &Others\t<A-w>", '%bd | e# | bd#', 'Close all buffers including no name except current one'],
\ ])
call quickui#menu#install('&Edit', [
\   ["&Undo\tu", 'undo', 'Undo the latest change'],
\   ["&Redo\t<C-y>", 'redo', 'Redo the latest change'],
\   ['--'],
\   ["&Cut\td", 'delete', 'Cut the current line into the yank register'],
\   ["Cop&y\ty", 'yank', 'Yank the current line into the yank register'],
\   ["&Paste\tp", 'put', 'Put the content in yank register after the cursor'],
\   ['--'],
\   ["F&ind\t:<leader>/", 'BLines', 'Initiate a search mode'],
\   ["&Find in Files\t:<leader>f", 'Rg', 'Search for pattern across the project'],
\   ['--'],
\   ["Toggle &Line Comment\t<leader>c<space>", 'call NERDComment("n", "Toggle")', 'Toggle line comments'],
\   ["Insert &Block Comment\t<leader>cs>", 'call NERDComment("n", "Sexy")', 'Insert block comments'],
\ ])
call quickui#menu#install('&View', [
\   [" Command &Palette\t:Commands", 'Commands', 'Open a command list'],
\   ['--'],
\   ["%{exists('w:indentLine_indentLineId') && ! empty(w:indentLine_indentLineId)?'✓':' '}Render &Indent Guides\t:IndentLinesToggle", 'IndentLinesToggle', 'Toggle indentation guide lines'],
\   ["%{&list?'✓':' '}&Render Whitespace\t:set invlist", 'set invlist | LeadingSpaceToggle', 'Toggle render of whitespace characters'],
\   ["%{&wrap?'✓':' '}&Word Wrap\t:set invwrap", 'set invwrap', 'Toggle a word wrap'],
\   ['--'],
\   ["%{&spell?'✓':' '}&Spell Check\t:set invspell", 'set invspell', 'Toggle a spell check'],
\   ["%{&cursorline?'✓':' '}Cursor &Line\t:set invcursorline", 'set invcursorline', 'Toggle render of current cursor line'],
\   ["%{&cursorcolumn?'✓':' '}Cursor &Column\t:set invcursorcolumn", 'set invcursorcolumn', 'Toggle render of current cursor column'],
\ ])

" Lightline-bufferline
let g:lightline#bufferline#enable_devicons = 1
let g:lightline#bufferline#min_buffer_count = 2

" Lightline
let g:lightline = {
\   'colorscheme': 'n0rd',
\ }

let g:lightline.tabline = {
\   'left': [
\     ['buffers']
\   ],
\   'right': [
\     []
\   ],
\ }

let g:lightline.component_expand = {
\   'linter_checking': 'lightline#ale#checking',
\   'linter_infos': 'lightline#ale#infos',
\   'linter_warnings': 'lightline#ale#warnings',
\   'linter_errors': 'lightline#ale#errors',
\   'linter_ok': 'lightline#ale#ok',
\   'buffers': 'lightline#bufferline#buffers',
\ }

let g:lightline.component_type = {
\   'linter_checking': 'right',
\   'linter_infos': 'right',
\   'linter_warnings': 'warning',
\   'linter_errors': 'error',
\   'linter_ok': 'right',
\   'buffers': 'tabsel',
\ }

function! LightlineMode()
  return &ft !=? 'luatree' ? lightline#mode() : ''
endfunction

function! LightlineBranch()
  return &ft !=? 'luatree' ? FugitiveHead() : ''
endfunction

function! LightlineReadonly()
  return &ft !=? 'luatree' && &readonly ? 'RO' : ''
endfunction

function! LightlineModified()
  return &ft !=? 'luatree' && &modified ? '+' : ''
endfunction

function! LightlineRelativePath()
  return &ft !=? 'luatree' ? expand('%:f') != '' ? expand('%:f') : '[no name]' : 'Explorer'
endfunction

function! LightlineLineInfo()
  return &ft !=? 'luatree' ? line('.') . ':' . col('.') : ''
endfunction

function! LightlinePercent()
  return &ft !=? 'luatree' ? line('.') * 100 / line('$') . '%' : ''
endfunction

function! LightlineFileFormat()
  return &ft !=? 'luatree' ? &ff : ''
endfunction

function! LightlineFileEncoding()
  return &ft !=? 'luatree' ? &enc : ''
endfunction

function! LightlineFileType()
  return &ft !=? 'luatree' ? &filetype : ''
endfunction

let g:lightline.component_function = {
\   'obsession': 'ObsessionStatus',
\   'gitbranch': 'LightlineBranch',
\   'mode': 'LightlineMode',
\   'readonly': 'LightlineReadonly',
\   'modified': 'LightlineModified',
\   'relativepath': 'LightlineRelativePath',
\   'lineinfo': 'LightlineLineInfo',
\   'percent': 'LightlinePercent',
\   'fileformat': 'LightlineFileFormat',
\   'fileencoding': 'LightlineFileEncoding',
\   'filetype': 'LightlineFileType'
\ }

let g:lightline.inactive = {
\   'left': [
\     [],
\     ['relativepath']
\   ],
\   'right': [
\     ['lineinfo'],
\     ['percent']
\   ]
\ }

let g:lightline.active = {
\   'left': [
\     ['mode', 'paste'],
\     ['gitbranch', 'readonly', 'relativepath', 'modified']
\   ],
\   'right': [
\     [
\       'linter_ok',
\       'linter_checking',
\       'linter_errors',
\       'linter_warnings',
\       'linter_infos'
\     ],
\     ['lineinfo'],
\     ['percent'],
\     [
\       'fileformat',
\       'fileencoding',
\       'filetype'
\     ],
\     ['obsession'],
\   ]
\ }

" speed-dating
" Disabled as we will map switch.vim and speeddating ourselves
let g:speeddating_no_mappings = 1

" vim-rooter
let g:rooter_silent_chdir = 1

" indentLine
let g:indentLine_char = '|'
let g:indentLine_leadingSpaceChar = '·'
let g:indentLine_fileTypeExclude = ['text', 'startify']

" startify
let g:startify_files_number = 20
let g:startify_fortune_use_unicode = 1
let g:startify_enable_special = 0
let g:startify_custom_header = 'startify#center(startify#fortune#cowsay())'

lua <<EOF
function _G.GetIcons(path)
  local filename = vim.api.nvim_eval("fnamemodify('"..path.."', ':t')")
  local extension = vim.api.nvim_eval("fnamemodify('"..path.."', ':e')")
  local icon, hl_group = require'nvim-web-devicons'.get_icon(filename, extension, { default = true })
  if icon then
    return icon.." "
  else
    return ""
  end
end
EOF

function! StartifyEntryFormat()
  return 'v:lua.GetIcons(absolute_path) . " " . entry_path'
endfunction

" Running some patches
source ~/.config/nvim/monkey-patch.vim

colorscheme nord

" colorizer
lua require'colorizer'.setup()

" treesitter
if has('nvim-0.5')
  lua <<EOF
  require'nvim-treesitter.configs'.setup {
    ensure_installed = 'all',
    highlight = {
      enable = true
    }
  }
EOF
endif

" Try to startup autocommand manually on first install completion
if exists('g:first_install')
  call ColorSetup()
  Startify
endif
