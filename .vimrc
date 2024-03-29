"---------------------------------------
" .vimrc
"---------------------------------------

"\
"| Tips. 
"|  ':source ~/.vimrc' to reload .vimrc
"/

"---------------------------------------
" Init
"---------------------------------------

filetype off
filetype plugin indent off

"---------------------------------------
" Plugin
"---------------------------------------

" check status
if has('vim_starting')
	" add runtime path
	set rtp+=~/.vim/plugged/vim-plug
	
	" install if not installed
	if !isdirectory(expand('~/.vim/plugged/vim-plug'))
		echo 'install vim-plug'

		echo 'create directory...'
		call system('mkdir -p ~/.vim/plugged/vim-plug')

		echo 'clone repo...'
		call system('git clone https://github.com/junegunn/vim-plug.git ~/.vim/plugged/vim-plug/autoload')

	endif
endif

call plug#begin('~/.vim/plugged')

" plugin manager
Plug 'junegunn/vim-plug', { 'dir': '~/.vim/plugged/vim-plug/autoload' }

" color schemes
Plug 'w0ng/vim-hybrid'
Plug 'jacoborus/tender.vim'
Plug 'tomasr/molokai'

" Vim fugitive
Plug 'tpope/vim-fugitive'

" lightline.vim
Plug 'itchyny/lightline.vim'

" toggle comment
Plug 'tomtom/tcomment_vim'

" vim surround ( text -> visual select and type S' -> 'text' )
Plug 'tpope/vim-surround'

" nerdtree
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'jistr/vim-nerdtree-tabs'

" Emmet
Plug 'mattn/emmet-vim'

" syntax
Plug 'hail2u/vim-css3-syntax'
Plug 'jelera/vim-javascript-syntax'

" Tabular (:Tableformat wrap)
Plug 'godlygeek/tabular'

" vim-markdown (:Tableformat)
Plug 'rcmdnk/vim-markdown'

" Open Browser
Plug 'tyru/open-browser.vim'

" Previm (Markdown Preview)
Plug 'kannokanno/previm', { 'for': 'markdown' }

Plug 'simeji/winresizer'

Plug 'embear/vim-localvimrc'

call plug#end()

"---------------------------------------
" Lightline Plugin
"---------------------------------------

" StatusLine show
set laststatus=2

" Show Tabline
set showtabline=2

" Vim Default Status Bar Mode View
set noshowmode

function! LightlineModified()
	return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
	return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'RO' : ''
endfunction

function! LightlineFilename()
	return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
\		(&ft == 'vimfiler' ? vimfiler#get_status_string() :
\		&ft == 'unite' ? unite#get_status_string() :
\		&ft == 'vimshell' ? vimshell#get_status_string() :
\		'' != expand('%:t') ? expand('%:t') : '[No Name]') .
\		('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFugitive()
	if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
		let g:a = fugitive#head()
		if g:a != ''
			return ''.fugitive#head()
		else
			return 'No git'
		endif
	else
		return ''
	endif
endfunction

function! LightlineFileformat()
	return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
	return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
	return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
	return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

let g:lightline = {
\		'colorscheme': 'wombat',
\		'mode_map': { 'c': 'NORMAL' },
\		'active': {
\			'left': [
\				[ 'mode', 'paste' ],
\				[ 'fugitive', 'filename' ]
\			]
\		},
\		'component_function': {
\			'modified':			'LightlineModified',
\			'filename':			'LightlineFilename',
\			'readonly':			'LightlineReadonly',
\			'fileformat':		'LightlineFileformat',
\			'fugitive':			'LightlineFugitive',
\			'filetype':			'LightlineFiletype',
\			'fileencoding':	'LightlineFileencoding',
\			'mode':					'LightlineMode'
\		}
\	}

"---------------------------------------
" Other Plugins
"---------------------------------------

let g:vim_markdown_folding_disabled = 1

let g:localvimrc_persistent = 1

let g:NERDTreeGitStatusIndicatorMapCustom = {
\		"Modified"  : "✹",
\		"Staged"    : "✚",
\		"Untracked" : "✭",
\		"Renamed"   : "➜",
\		"Unmerged"  : "═",
\		"Deleted"   : "✖",
\		"Dirty"     : "✗",
\		"Clean"     : "✓",
\		"Unknown"   : "?"
\	}

map <C-n> <plug>NERDTreeTabsToggle<CR>

"---------------------------------------
" Language / Encoding
"---------------------------------------

" internal encoding
set encoding=utf-8

" terminal encoding
set termencoding=utf-8

language C

set fileformats=unix,dos,mac
set fileencodings=ucs-bom,utf-8,iso-2022-jp,euc-jp,cp932,utf-16le,utf-16,default

"---------------------------------------
" Tab Short cut
"---------------------------------------

" set [Tag] key
nnoremap [Tag] <Nop>
nmap t [Tag]

" change tab shortcut <t-N>
for n in range(1,9)
	execute 'nnoremap <silent> [Tag]'.n ':<C-u>tabnext'.n.'<CR>'
endfor

nnoremap <silent> [Tag]c :tabnew<CR>
nnoremap <silent> [Tag]x :tabclose<CR>
nnoremap <silent> [Tag]n :tabnext<CR>
nnoremap <silent> [Tag]p :tabprevious<CR>

"---------------------------------------
" Syntax
"---------------------------------------

syntax on
set t_Co=256
set number
set nowrap
set background=dark
set cursorline
set list
set listchars=tab:>\ ,trail:-,eol:¬,extends:»,precedes:«

" SYNTAX: hybrid
" colorscheme hybrid
" let g:hybrid_reduced_contrast = 1

" SYNTA: molokai
colorscheme molokai

" " SYNTAX: tender
" colorscheme tender

"---------------------------------------
" Basic
"---------------------------------------

set nocompatible
set backspace=2

set tabstop=4
set shiftwidth=4
set autoindent
set smartindent

" Fast
set synmaxcol=160
set lazyredraw
set ttyfast
set re=1
set timeoutlen=1000 ttimeoutlen=0

set incsearch
set hlsearch

" search word display center
nmap n nzz
nmap N Nzz

" clear highlight after ctrl-l
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" Disable multi-line comment
autocmd FileType * setlocal formatoptions-=ro

" Don't break select after ctrl-a and ctrl-x
vnoremap <c-a> <c-a>gv
vnoremap <c-x> <c-x>gv

"---------------------------------------
" Language configure
"---------------------------------------

autocmd FileType html,ruby,vim setlocal tabstop=2 shiftwidth=2

autocmd FileType python setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4

autocmd FileType html setlocal matchpairs& matchpairs+=<:>

autocmd FileType cpp setlocal path=.,/usr/include/c++/6/


"---------------------------------------
" finalize
"---------------------------------------

filetype plugin indent on
filetype on


