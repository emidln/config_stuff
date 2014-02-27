if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc', {
\    'build' : {
\        'unix': 'make -f make_unix.mak',
\        'mac': 'make -f make_mac.mak',
\    },
\}

" Platform Neutral Plugins
NeoBundle 'Shougo/unite.vim'             " unite all the things!
NeoBundle 'tpope/vim-fugitive'     	 " git
NeoBundle 'sjl/gundo.vim'           	 " undo graph
NeoBundle 'mattn/webapi-vim'       	 " support for gist-vim
NeoBundle 'mattn/gist-vim'         	 " :Gist
NeoBundle 'Lokaltog/vim-powerline' 	 " status info
NeoBundle 'kien/rainbow_parentheses.vim' " Rainbow parens!
NeoBundle 'tpope/vim-surround'           " Handy selection
NeoBundle 'emidln/vimux'

"NeoBundle 'altercation/vim-colors-solarized' " solarized colorscheme

" Tab to complete
NeoBundle 'ervandew/supertab'	
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
let g:SuperTabMappingForward = '<s-tab>'
let g:SuperTabMappingBackward = '<tab>'


NeoBundle 'tpope/vim-repeat'             " Repeat with .

" Generic Lisp Plugins
NeoBundle 'https://bitbucket.org/kovisoft/paredit'
"NeoBundle 'guns/vim-sexp'                " Motions over S-Expressions
"NeoBundle 'tpope/vim-sexp-mappings-for-regular-people' " Reworked mappings

" JVM Plugins
NeoBundle 'tpope/vim-classpath'          " mvn/lein classpath stuff

" Clojure/ClojureScript Plugins
NeoBundle 'guns/vim-clojure-static'      " syntax file
NeoBundle 'tpope/vim-fireplace'          " nREPL client
"NeoBundle 'guns/vim-slamhound'           " Slamhound via fireplace

" Hy Plugins
NeoBundle 'hylang/vim-hy'                " syntax file

" Python Plugins
NeoBundle 'klen/python-mode'


" Disable rope because we use Jedi instead
let g:pymode_rope = 0

" Ignore line length warnings
let g:pymode_lint_ignore = "E501"

" Using Python2
let g:pymode_python = "python"

" Setup Python-specific complete, numbering, wrapping, textwidth, etc
let g:pymode_options = 1

" Enable warnings
let g:pymode_warnings = 1

" Disable PyMode's K in favor of jedi
let g:pymode_doc = 0

" Enable Python text objects
let g:pymode_motion = 1

" Enable PyMode's code folding
let g:pymode_folding = 1

let g:gist_clip_command = 'pbcopy'

NeoBundle 'davidhalter/jedi-vim'

"NeoBundle 'ivanov/vim-ipython'
"let g:ipy_perform_mappings = 1 " vim-ipython is weird

" Salt Plugins
NeoBundle 'saltstack/salt-vim'

" XML Plugins
NeoBundle 'othree/xml.vim'

" HTML Plugins
"NeoBundle 'othree/html5-syntax.vim'
NeoBundle 'othree/html5.vim'

" Javascript Plugins

filetype plugin indent on
set incsearch
set hlsearch
syntax on
autocmd FileType text setlocal textwidth=80

" Setup Global Rainbow Parentheses
" Fight the Heathens!
autocmd VimEnter * RainbowParenthesesToggle
autocmd VimEnter * RainbowParenthesesLoadRound
autocmd VimEnter * RainbowParenthesesLoadSquare
autocmd VimEnter * RainbowParenthesesLoadBraces

let mapleader = ","
let g:mapleader = ","
let maplocalleader = ",,"
let g:maplocalleader = ",,"

" Burn the bridges
inoremap <Left>	<NOP>
nnoremap <Left> <NOP>
inoremap <Right> <NOP>
nnoremap <Right> <NOP>
inoremap <UP> <NOP>
nnoremap <UP> <NOP>
inoremap <DOWN> <NOP>
nnoremap <DOWN> <NOP>

cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
cnoremap <C-w> <C-Right>
cnoremap <C-b> <C-Left>
cnoremap <C-^> <Home>
cnoremap <C-S-$> <End>



"set magic
"set smartcase
"set showmatch
"set mat=2 " blink for 200 ms when matching brackets
set laststatus=2
set encoding=utf-8
"set t_Co=256
set t_Co=16

" don't use DES if encryption is requested
" TODO: Hack in GPG support
set cryptmethod="blowfish"

" Litering source directories with swap files is a no no
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp

function SetPythonOptions()
	setlocal expandtab
	"setlocal smarttab
	setlocal shiftwidth=4
	setlocal tabstop=4
	setlocal autoindent
	"setlocal smartindent
	setlocal filetype=python
endfunction
autocmd BufEnter,BufRead *.py call SetPythonOptions()

function SetClojureOptions()
	set filetype=clojure
endfunction
autocmd BufNewFile,BufRead *.clj call SetClojureOptions()

""" not really a repl, but good enough for feedback
function SetClojurePyOptions()
	call SetClojureOptions()
	map <Leader>r :!clojurepy %<CR>
endfunction


function VimuxSlime()
	if !exists("g:VimuxRunnerPaneIndex") || _VimuxHasPane(g:VimuxRunnerPaneIndex) == -1
    		call VimuxOpenPane()
  	endif
	call VimuxSendText(@v)
	"call VimuxSendKeys("Enter")
endfunction
""
map <Leader>vi :VimuxInspectRunner<CR>
map <Leader>vq :VimuxCloseRunner<CR>
map <Leader>vx :VimuxInterruptRunner<VR>
vmap <Leader>vs "vy :call VimuxSlime()<CR>
nmap <Leader>vs vip<Leader>vs<CR>
" eval the outermost form
"nmap <LocalLeader>e vaF<Leader>vs<CR>
nmap <LocalLeader>e mav((((((((((((((((((((((((((((((((((((((((((((((((<Leader>vs<CR>'a
" eval the current form
nmap <LocalLeader>l ^V$<Leader>vs<CR>
nmap <LocalLeader>E va(<Leader>vs<CR>
" eval the buffer
nmap <LocalLeader>b ggVG<Leader>vs<CR>
""


" UNITE
let g:unite_source_history_yank_enable = 1
"call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#custom#source('file,file/new,buffer,file_rec', 'matchers', 'matcher_fuzzy')

nnoremap [unite] <NOP>
nmap f [unite]

nnoremap <silent> [unite]c :<C-u>UniteWithCurrentDir -buffer-name=files -start-insert buffer file_mru bookmark file_rec<CR>
"nnoremap <Leader>uf :<C-u>Unite -start-insert file_rec/async:!<CR>



autocmd BufRead,BufNewFile *.cljpy call SetClojurePyOptions()
autocmd BufRead,BufNewFile *.cljs call SetClojureOptions()
autocmd BufRead,BufNewFile *.cljx call SetClojureOptions()

highlight Folded ctermbg=0 ctermfg=30

function SetHTMLOptions()
	setlocal shiftwidth=2
	setlocal tabstop=2
	setlocal filetype=html
	imap <silent> <C-c> </<C-X><C-O>
endfunction

autocmd BufRead,BufNewFile *.html call SetHTMLOptions()

function SetSaltOptions()
	setlocal nocompatible
	setlocal tabstop=2
	setlocal shiftwidth=2
	setlocal expandtab
endfunction

autocmd BufRead,BufNewFile *.sls call SetSaltOptions()
autocmd BufRead,BufNewFile *.sls setlocal filetype=sls


"let g:solarized_termcolors=256
"set background=dark
"colorscheme solarized

" :redir @a | silent map | redir END | tabnew | normal "ap

" Automagically Update
NeoBundleCheck
