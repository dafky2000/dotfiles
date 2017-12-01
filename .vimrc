" Daniel Kelly
" .vimrc 20161107T15:58
" Second attempt at a sane vim config, my last got a little out of control. Utilize native vim as much as possible is the aim of this config. Sparingly use plugins when we cannot formulate a more native solution and try always to use minimal and specific plugins.
"
" enter the current millenium
set nocompatible
filetype off

augroup filetypedetect
  au BufNewFile,BufRead,BufReadPost *.md set filetype=markdown
  au BufNewFile,BufRead,BufReadPost *.html set filetype=php
augroup END

" PLUGINS:
	" set the runtime path to include Vundle and initialize
	set rtp+=~/.vim/bundle/Vundle.vim
	call vundle#begin()
	" alternatively, pass a path where Vundle should install plugins
	"call vundle#begin('~/some/path/here')

	" let Vundle manage Vundle, required
	Plugin 'VundleVim/Vundle.vim'
	" Rip-Rip/clang_complete for C/C++ context aware code completion
	" https://github.com/Rip-Rip/clang_complete/blob/master/doc/clang_complete.txt
	" Plugin 'Rip-Rip/clang_complete'
	" Plugin 'justmao945/vim-clang'
	Plugin 'Valloric/YouCompleteMe'
	Plugin 'rdnetto/YCM-Generator'
	" tpope/vim-commentary for comment functionality
	" gcc - comment a line
	" gc - followed by motion to comment number of lines
	Plugin 'tpope/vim-commentary'
	" tpope/vim-surround for adding surround functionality
	" Adds the "s" motion operator, for example: "cs{(" to change in surrounding
	" { to (
	" OR cs"' to change surrounding double quote to single quotes
	" OR cst<h2 to change the surround (html) tag with h2 (will also change the
	" ending tag)
	Plugin 'tpope/vim-surround'
	" tpope/vim-repeat additional repeat functionality plugin commands
	Plugin 'tpope/vim-repeat'
	" Replaces my old drw with gr{motion} so we can use any motion
	Plugin 'tpope/vim-fugitive'
	" Plugin 'tpope/vim-markdown'
	Plugin 'jiangmiao/auto-pairs'
	Plugin 'vim-scripts/ReplaceWithRegister'
	" Provides different text object to select by
	" https://github.com/kana/vim-textobj-user/wiki
	Plugin 'kana/vim-textobj-user'
	" Select by comments
	" yic - yank inside comment
	Plugin 'glts/vim-textobj-comment'
	" Select by indent
	" gcii - Comment inside indent block
	Plugin 'kana/vim-textobj-indent'
	" Select by line
	" gral - Replace entire line with register contents
	Plugin 'kana/vim-textobj-line'
	" neomake/neomake for async linting and build testing
	Plugin 'neomake/neomake'
	" rust-lang/rust.vim for rust file detection, syntax highlighting,
	" formatting and more
	" Plugin 'rust-lang/rust.vim'
	" Plugin 'bendavis78/vim-polymer'
  Plugin 'chriskempson/base16-vim'
  Plugin 'LucHermitte/lh-vim-lib'
  Plugin 'LucHermitte/local_vimrc'
	" All of your Plugins must be added before the following line
	call vundle#end()            " required

" enable syntax and plugins (for netrw)
syntax enable
filetype plugin on

" FUZZY FILE FINDER:
	" Search down into subfolders, Fuzzy-finding files
	" Provides tab-completion for all file-related tasks
	set path+=**
	" Ignore a bunch of file patterns!! Add to as we see fit!
	set wildignore=.git,.hg,build,build_*,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,*.pyc,*.swf,*.egg,*.jar,*.dump,*.gem
	" Display all matching files when we tab complete
	set wildmenu
	" NOW WE CAN:
	" - Hit tab to :find by partial match
	" - Use * to make it fuzzy
	" THINGS TO CONSIDER:
	" - :b lets you autocomplete any open buffer

" CODE FOLDING:
	" Sets the default fold type to syntax folding
	set foldenable
	set foldmethod=indent
	set foldcolumn=0
	" let javascript_fold=1         " JavaScript
	" let perl_fold=1               " Perl
	" let php_folding=1             " PHP
	" let html_folding=1            " HTML
	" Save the folding for every file and recall it upon openning
	autocmd BufWinLeave *.* mkview
	autocmd BufWinEnter *.* silent loadview
	let g:skipview_files = [
		\ '[EXAMPLE PLUGIN BUFFER]'
		\ ]
	function! MakeViewCheck()
		if has('quickfix') && &buftype =~ 'nofile'
			" Buffer is marked as not a file
			return 0
		endif
		if empty(glob(expand('%:p')))
			" File does not exist on disk
			return 0
		endif
		if len($TEMP) && expand('%:p:h') == $TEMP
			" We're in a temp dir
			return 0
		endif
		if len($TMP) && expand('%:p:h') == $TMP
			" Also in temp dir
			return 0
		endif
		if index(g:skipview_files, expand('%')) >= 0
			" File is in skip list
			return 0
		endif
		return 1
	endfunction
	augroup vimrcAutoView
		autocmd!
		" Autosave & Load Views.
		autocmd BufWritePost,BufLeave,WinLeave ?* if MakeViewCheck() | mkview | endif
		autocmd BufWinEnter ?* if MakeViewCheck() | silent loadview | endif
	augroup end

" GLOBAL EDITOR OPTIONS:
	" So unicode characters print over ssh?
	set encoding=utf-8
	set termencoding=utf-8

  let base16colorspace=256
  " colorscheme koehler
  " colorscheme peachpuff
  " colorscheme default
  " colorscheme base16-default-dark

	" Allows me to backspace and delete across a newline
	set backspace=indent,eol,start
	" Highlight first search result as we type
	set incsearch
	" Highlight all search results
	set hlsearch
	" Set the command history higher!
	set history=10000
	" Line numbering and relative numbering
	set number
	set relativenumber
	set autoindent
	" Disable that pesky swapfile. I can handle myself!
	set noswapfile
	" Add the line and column number when they can fit!
	set ruler
	" Keep X number of lines around the cursor visible
	set scrolloff=3
	" Set our shell to bash!
	set shell=/bin/bash
	" Make the line numbers a little less in your face
	" highlight LineNr ctermfg=DarkGrey ctermbg=DarkGrey
	" highlight CursorLineNr ctermfg=White
  highlight NeomakeWarning cterm=underline ctermfg=Red gui=undercurl guisp=Red
  highlight NeomakeError cterm=underline ctermfg=Red gui=undercurl guisp=Red
  " highlight NeomakeWarningSign cterm=underline ctermfg=9 gui=undercurl guisp=Red
  " highlight NeomakeErrorSign cterm=underline ctermfg=9 gui=undercurl guisp=Red  

  " let base16colorspace=256  " Access colors present in 256 colorspace
  "
	" Uses the system clipboard, should be able to copy and paste into and out of
	" vim
	set clipboard=unnamedplus

	set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
	" Set automatic soft word wrapping
	set wrap
	set linebreak
	if v:version >= 704
		set breakindent
	endif
	let &showbreak="\u21aa "
	" set showbreak+=_
	" Comment to work around trailing space	set showbreak="\u21aa " " Comment to work around trailing space	set showbreak="\u21aa " " Comment to work around trailing space" Comment to work around trailing space	set showbreak="\u21aa " " Comment to work around trailing space	set showbreak="\u21aa " " Comment to work around trailing space" Comment to work around trailing space	set showbreak="\u21aa " " Comment to work around trailing space	set showbreak="\u21aa " " Comment to work around trailing space" Comment to work around trailing space	set showbreak="\u21aa " " Comment to work around trailing space	set showbreak="\u21aa " " Comment to work around trailing space
	set nolist
	set showcmd
	" Disable Arrow keys in NORMAL mode only!
	" Get used to staying on the homerow or dont use VIM!
	no <Up> ddkP
	no <Down> ddp
	no <Left> <Nop>
	no <Right> <Nop>
	ino <Up> <Nop>
	ino <Down> <Nop>
	ino <Left> <Nop>
	ino <Right> <Nop>

	" So I can use the mouse in vim (through tmux) 
	set mouse+=a
	if &term =~ '^screen'
		" tmux knows the extended mouse mode
		set ttymouse=xterm2
	endif

" CUSTOM COMMANDS AND REMAPPINGS:
	" Remap the local leader to the backslash (personal preference)
	:let mapleader = "\\"
	:let maplocalleader = "\\"
	" Uses the system clipboard, should be able to copy and paste into and out
	" of vim
	set clipboard=unnamedplus
	" Allow saving of files as sudo when I forgot to start vim using sudo with w!!
	" cmap w!! w !sudo tee > /dev/null %
	ca w!! w !sudo tee % >/dev/null
  " Automatically create parent directory on save if directory doesn't exist
  au BufWritePre * if expand("<afile>")!~#'^\w\+:/' && !isdirectory(expand("%:h")) | execute "silent! !mkdir -p".shellescape(expand('%:h'), 1) | redraw! | endif
	" Reloads .vimrc on save..?
	au! BufWritePost $MYVIMRC source $MYVIMRC
	" To reload the vimrc file from anywhere
	nnoremap <leader><Esc> :source ~/.vimrc<cr>
	" Resize splits when the window is resized
	au VimResized * exe "normal! \<c-w>="
	au BufNewFile * set noeol
	" Close quickfix window associated with window
	aug QFClose
		au!
		au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
	aug END

	noremap <Leader><Tab> :call VexToggle(getcwd())<CR>
	noremap <Leader>` :call VexToggle("")<CR>
	" noremap <Leader><Tab> :call ExToggle(getcwd())<CR>
	" noremap <Leader>` :call ExToggle("")<CR>

	" Easier pane navigation, no need to hit ctrl+w first..
	nnoremap <C-J> <C-W><C-J>
	nnoremap <C-K> <C-W><C-K>
	nnoremap <C-L> <C-W><C-L>
	nnoremap <C-H> <C-W><C-H>
	" More natural splitting, shortcut using leader and default to split right
	" and split below (so the cursor goes to the new split)
	set splitbelow
	set splitright
	noremap <Leader>s :split<CR>
	noremap <Leader>v :vsplit<CR>

	" Remap the enter and shift+enter to add newline without entering insert
	" mode
	" nnoremap <S-CR> O<Esc> " Doesn't work in most terminal emulators
	nnoremap <CR> o<Esc>

	" Return indent (all whitespace at start of a line), converted from
	" tabs to spaces if what = 1, or from spaces to tabs otherwise.
	" When converting to tabs, result has no redundant spaces.
	function! Indenting(indent, what, cols)
		let spccol = repeat(' ', a:cols)
		let result = substitute(a:indent, spccol, '\t', 'g')
		let result = substitute(result, ' \+\ze\t', '', 'g')
		if a:what == 1
			let result = substitute(result, '\t', spccol, 'g')
		endif
		return result
	endfunction

	" Convert whitespace used for indenting (before first non-whitespace).
	" what = 0 (convert spaces to tabs), or 1 (convert tabs to spaces).
	" cols = string with number of columns per tab, or empty to use 'tabstop'.
	" The cursor position is restored, but the cursor will be in a different
	" column when the number of characters in the indent of the line is changed.
	function! IndentConvert(line1, line2, what, cols)
		let savepos = getpos('.')
		let cols = empty(a:cols) ? &tabstop : a:cols
		execute a:line1 . ',' . a:line2 . 's/^\s\+/\=Indenting(submatch(0), a:what, cols)/e'
		call histdel('search', -1)
		call setpos('.', savepos)
	endfunction
	command! -nargs=? -range=% Space2Tab call IndentConvert(<line1>,<line2>,0,<q-args>)
	command! -nargs=? -range=% Tab2Space call IndentConvert(<line1>,<line2>,1,<q-args>)
	command! -nargs=? -range=% RetabIndent call IndentConvert(<line1>,<line2>,&et,<q-args>)

" CTAG JUMPING: (DISABLED)
	" Create the `tags` file (may need to install ctags first)
	" command! MakeTags !ctags -R .
	" au BufWritePost *.c,*.cpp,*.h,*.hpp,*.css,*.js,*.pl,*.pm,*.fpl,*.rb,*.py silent! !ctags -R . &
	" NOW WE CAN:
	" - Use ^] to jump to tag under cursor
	" - Use g^] for ambiguous tags
	" - Use ^t to jump back up the tag stack
	" AUTOCOMPLETE:
	" The good stuff is documented in |ins-completion|
	" HIGHLIGHTS:
	" - ^n for anything specified by the 'complete' option
	" - ^x^n for JUST this file
	" - ^x^f for filenames (works with our path trick!)
	" - ^x^] for tags only
	" NOW WE CAN:
	" - Use ^n and ^p to go back and forth in the suggestion list

" FILE BROWSING:
	" Tweaks for browsing with netrw
	" Most of this is adapted from http://ivanbrennan.nyc/blog/2014/01/16/rigging-vims-netrw/
	" <Leader>+Tab or <Leader>+` to toggle the file browser
	" Opens file browser in left split and opens file in the previous buffer,
	let g:netrw_banner = 0
	let g:netrw_liststyle = 3
	let g:netrw_browse_split = 4
	let g:netrw_altv = 1
	" let g:netrw_winsize = 25
	let g:netrw_list_hide=netrw_gitignore#Hide()
	" let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
	let g:netrw_use_errorwindow=0

	fun! BClose()
		let prev_buf = bufnr("#")
		if  prev_buf > 0 && buflisted(prev_buf)
			buffer #
			bdelete #
		else
			bdelete
		endif
	endf

	fun! ExToggle(dir)
		if &filetype != "netrw"
			let g:netrw_browse_split=0  " open files in current window
			exe "Explore " . a:dir
		else
			call BClose()
		endif
	endf

	fun! VexToggle(dir)
		if exists("t:vex_buf_nr")
			call VexClose()
		else
			call VexOpen(a:dir)
		endif
	endf

	fun! VexOpen(dir)
		let g:netrw_browse_split=4  " open files in previous window
		let vex_width = 25

		exe "Vexplore " . a:dir
		let t:vex_buf_nr = bufnr("%")
		wincmd H

		call VexSize(vex_width)
	endf

	fun! VexClose()
		let cur_win_nr = winnr()
		let target_nr = ( cur_win_nr == 1 ? winnr("#") : cur_win_nr )

		1wincmd w
		close
		unlet t:vex_buf_nr

		exe (target_nr - 1) . "wincmd w"
		call NormalizeWidths()
	endf

	fun! VexSize(vex_width)
		execute "vertical resize" . a:vex_width
		set winfixwidth
		call NormalizeWidths()
	endf

	fun! NormalizeWidths()
		let eadir_pref = &eadirection
		set eadirection=hor
		set equalalways! equalalways!
		let &eadirection = eadir_pref
	endf

	augroup NetrwGroup
		autocmd!
		autocmd BufEnter * call NormalizeWidths()
	augroup END
	" augroup ProjectDrawer
	" 	autocmd!
	" 	autocmd VimEnter * :Vexplore
	" augroup END

" SNIPPETS:
	" Read an empty HTML template and move cursor to title
	nnoremap \html :-1read $HOME/scripts/development/vim_snippets/html.txt<CR>zR3jwf>a
	" NOW WE CAN:
	" - Take over the world!
	"   (with much fewer keystrokes)

" PLUGIN_clang_complete:
	" Always use c++11!
	" let g:clang_user_options = '-std=c++11'
	" let g:clang_library_path='/usr/lib64/libclang.so'
	" let g:clang_close_preview=1

" PLUGIN_vim_clang:
	let g:clang_c_options = '-std=c11'
	let g:clang_cpp_options = '-std=c++11 -stdlib=libc++'

" PLUGIN_neomake:
	" https://neovim.io/doc/user/quickfix.html#errorformat
	autocmd! BufWritePost * Neomake
	autocmd! BufWinEnter * Neomake

	let g:neomake_c_clang_maker = {
		\ 'exe': '/usr/bin/clang',
		\ 'args': ['--std=c11', '-fsyntax-only'],
		\ 'errorformat':
			\ '%-G%f:%s:,' .
			\ '%f:%l:%c: %trror: %m,' .
			\ '%f:%l:%c: %tarning: %m,' .
			\ '%I%f:%l:%c: note: %m,' .
			\ '%f:%l:%c: %m,'.
			\ '%f:%l: %trror: %m,'.
			\ '%f:%l: %tarning: %m,'.
			\ '%I%f:%l: note: %m,'.
			\ '%f:%l: %m'
	\ }
	let g:neomake_c_clangtidy_maker = {
		\ 'exe': '/usr/bin/clang-tidy',
		\ 'errorformat':
			\ '%E%f:%l:%c: fatal error: %m,' .
			\ '%E%f:%l:%c: error: %m,' .
			\ '%W%f:%l:%c: warning: %m,' .
			\ '%-G%\m%\%%(LLVM ERROR:%\|No compilation database found%\)%\@!%.%#,' .
			\ '%E%m',
	\ }
  let g:neomake_cpp_clang_exe = '/usr/bin/clang++'
  let g:neomake_cpp_clang_args = ['--std=c++11', '-fsyntax-only', '-x', 'c++', '-I./', '-I./include/', '-I/usr/include/qt/']
	" let g:neomake_cpp_clang_maker = {
	" 	\ 'exe': '/usr/bin/clang++',
	" 	\ 'args': ['--std=c++11', '-fsyntax-only', '-Wall', '-Wextra'],
	" 	\ 'errorformat':
	" 		\ '%-G%f:%s:,' .
	" 		\ '%f:%l:%c: %trror: %m,' .
	" 		\ '%f:%l:%c: %tarning: %m,' .
	" 		\ '%I%f:%l:%c: note: %m,' .
	" 		\ '%f:%l:%c: %m,'.
	" 		\ '%f:%l: %trror: %m,'.
	" 		\ '%f:%l: %tarning: %m,'.
	" 		\ '%I%f:%l: note: %m,'.
	" 		\ '%f:%l: %m'
	" \ }
	let g:neomake_cpp_cppcheck_maker = {
		\ 'exe': '/usr/bin/cppcheck',
		\ 'args': ['--std=c++11', '-v', '-q', '-x', 'c++', '-I./', '-I./include/', '-I/usr/include/qt/',
			\ '--enable=warning,style,performance', '--inline-suppr',
			\ '--suppress=*:'.$PWD.'/src/backward.hpp', '--force',
    \ ],
		\ 'errorformat': '[%f:%l]: %m'
	\ }
	let g:neomake_cpp_clangtidy_maker = {
		\ 'exe': '/usr/bin/clang-tidy',
    \ 'args': ['-p', $PWD . '/compile_commands.json'],
		\ 'errorformat':
			\ '%E%f:%l:%c: fatal error: %m,' .
			\ '%E%f:%l:%c: error: %m,' .
			\ '%W%f:%l:%c: warning: %m,' .
			\ '%-G%\m%\%%(LLVM ERROR:%\|No compilation database found%\)%\@!%.%#,' .
			\ '%E%m',
	\ }
  " \ 'args': ['-p '.$PWD.'/build_local/'],
	" Linked the vim tools directory to the neovim tools dir since it doesn't exist in neovim
	" ln -s /usr/share/vim/vim74/tools /usr/share/nvim/runtime/tools
	let g:neomake_perl_perl_maker = {
		\ 'exe': '/usr/bin/perl',
		\ 'args': [$VIMRUNTIME . '/tools/efm_perl.pl', '-c' ],
		\ 'errorformat': '%f:%l:%m',
	\ }
	let g:neomake_perl_perlcritic_maker = {
		\ 'exe': '/usr/bin/vendor_perl/perlcritic',
		\ 'args': ['--quiet', '--nocolor', '--verbose', '\\%f:\\%l:\\%c:\\%m (\\%e)\\n', '-4'],
		\ 'errorformat': '%f:%l:%c:%m',
	\ }
	let g:neomake_php_php_maker = {
		\ 'exe': '/usr/bin/php',
		\ 'args': ['-l', '-d display_errors=1', '-d error_reporting=E_ALL',
      \ '-d short_open_tag=On'],
		\ 'errorformat': '%m\ in\ %f\ on\ line\ %l,%-GErrors\ parsing\ %f,%-G',
	\ }
  " \ 'postprocess': function('neomake#makers#ft#php#PhpEntryProcess'),
	let g:neomake_php_eslint_maker = {
		\ 'exe': '/usr/bin/eslint',
		\ 'args': [''],
		\ 'errorformat': '%A%f: line %l\, col %v\, %m \(%t%*\d\)',
	\ }
	let g:neomake_php_jshint_maker = {
		\ 'exe': '/usr/bin/jshint',
		\ 'args': ['--verbose', '--extract', 'always'],
		\ 'errorformat': '%A%f: line %l\, col %v\, %m \(%t%*\d\)',
	\ }
	let g:neomake_php_tidy_maker = {
		\ 'exe': '/usr/bin/tidy',
		\ 'args': ['-e', '-q', '--gnu-emacs', 'true'],
		\ 'errorformat': '%f:%l:%c: %m',
		\ 'buffer_output': 1,
	\ }
	" HTMLHINTFILE=/home/dan/Documents/Walinga/sapps/index.php /usr/bin/php /home/dan/Documents/Walinga/sapps/index.php | /usr/bin/htmlhint --format unix /dev/stdin | sed -e "s:/dev/stdin:$HTMLHINTFILE:g"
  " https://stackoverflow.com/questions/47023461/preg-replace-multiline-match-but-preserve-new-lines/47024521#47024521
	let g:neomake_php_htmlhint_maker = {
		\ 'exe': '/bin/fish',
		\ 'args': [ '-c', "php -d short_open_tag=On -r 'echo array_reduce(token_get_all(file_get_contents($argv[1])),function($c,$i){return $i[0]==321?$c.$i[1]:$c.str_repeat(\"\\n\",@count_chars($i.$i[1])[10]);});'"
                  \ . " -- '%:p'"
                  \ . ' | htmlhint --config .htmlhintrc --nocolor --format unix /dev/stdin'
                  \ . ' | sed -e s:/dev/stdin:%:p:g'
                  \ . ' | xargs -d "\\n" -I \% echo \%'
    \ ],
		\ 'errorformat': '%f:%l:%c: %m',
    \ 'append_file': 0,
	\ }
	let g:neomake_html_php_maker = {
		\ 'exe': '/usr/bin/php',
		\ 'args': ['-l', '-d display_errors=1', '-d error_reporting=E_ALL'],
		\ 'errorformat': '%m\ in\ %f\ on\ line\ %l,%-GErrors\ parsing\ %f,%-G',
		\ 'postprocess': function('neomake#makers#ft#php#PhpEntryProcess'),
	\ }
	let g:neomake_html_eslint_maker = {
		\ 'exe': '/usr/bin/eslint',
		\ 'args': [''],
		\ 'errorformat': '%A%f: line %l\, col %v\, %m',
	\ }
	let g:neomake_html_jshint_maker = {
		\ 'exe': '/usr/bin/jshint',
		\ 'args': ['--verbose', '--extract', 'always'],
		\ 'errorformat': '%A%f: line %l\, col %v\, %m \(%t%*\d\)',
	\ }
	let g:neomake_html_htmlhint_maker = {
		\ 'exe': '/bin/fish',
		\ 'args': [ '-c', "php -d short_open_tag=On -r 'echo array_reduce(token_get_all(file_get_contents($argv[1])),function($c,$i){return $i[0]==321?$c.$i[1]:$c.str_repeat(\"\\n\",@count_chars($i.$i[1])[10]);});'"
                  \ . " -- '%:p'"
                  \ . ' | htmlhint --config .htmlhintrc --nocolor --format unix /dev/stdin'
                  \ . ' | sed -e s:/dev/stdin:%:p:g'
                  \ . ' | xargs -d "\\n" -I \% echo \%'
    \ ],
		\ 'errorformat': '%f:%l:%c: %m',
    \ 'append_file': 0,
	\ }
	let g:neomake_polymerhtml_polylint_maker = {
		\ 'exe': '/usr/bin/polylint',
		\ 'args': ['--verbose', '--no-recursion'],
		\ 'errorformat': '%A%f:%l:%c,\ \ \ \ %m',
	\ }
	let g:neomake_polymerhtml_jshint_maker = {
		\ 'exe': '/usr/bin/jshint',
		\ 'args': ['--verbose', '--extract', 'always'],
		\ 'errorformat': '%A%f: line %l\, col %v\, %m \(%t%*\d\)',
	\ }
	let g:neomake_polymerhtml_csslint_maker = {
		\ 'exe': '/usr/bin/csslint',
	\ }
	" \ 'args': ['--verbose', '--extract', 'always'],
	" \ 'errorformat': '%f:%l:%c: %m',
	let g:neomake_html_tidy_maker = {
		\ 'exe': '/usr/bin/tidy',
		\ 'args': ['-e', '-q', '--gnu-emacs', 'true'],
		\ 'errorformat': '%f:%l:%c: %m',
		\ 'buffer_output': 1,
	\ }
	" let g:neomake_html_htmlhint_maker = {
	" 	\ 'exe': '/usr/bin/htmlhint',
	" 	\ 'args': ['--format', 'unix'],
	" 	\ 'errorformat': '%f:%l:%c: %m',
	" 	\ }
	let g:neomake_javascript_eslint_maker = {
		\ 'exe': '/usr/bin/eslint',
		\ 'args': ['-f', 'compact'],
		\ 'errorformat': '%f: line %l\, col %v\, %m',
	\ }
	let g:neomake_javascript_jshint_maker = {
		\ 'exe': '/usr/bin/jshint',
		\ 'args': ['--verbose'],
		\ 'errorformat': '%A%f: line %l\, col %v\, %m \(%t%*\d\)',
	\ }
  let g:neomake_css_csslint_maker = {
		\ 'exe': '/usr/bin/csslint',
  \ }
  let g:neomake_python_flake8_maker = {
    \ 'args': ['--max-line-length=999']
  \ }

	let g:neomake_c_enabled_makers = ['clang']
	" let g:neomake_cpp_enabled_makers = ['clang']
	" let g:neomake_cpp_enabled_makers = ['clangtidy']
	let g:neomake_cpp_enabled_makers = ['clang', 'cppcheck']
	" let g:neomake_cpp_enabled_makers = ['clang', 'clangtidy', 'cppcheck']
	let g:neomake_perl_enabled_makers = ['perl', 'perlcritic']
	" let g:neomake_php_enabled_makers = ['php', 'jshint', 'htmlhint']
	" let g:neomake_html_enabled_makers = ['php', 'jshint', 'htmlhint', 'polylint']
	let g:neomake_php_enabled_makers = ['php', 'htmlhint']
	" let g:neomake_html_enabled_makers = ['php', 'htmlhint', 'jshint']
	let g:neomake_html_enabled_makers = ['htmlhint', 'eslint']
	let g:neomake_polymerhtml_enabled_makers = ['csslint', 'jshint', 'polylint']
	" let g:neomake_javascript_enabled_makers = ['jshint']
	let g:neomake_javascript_enabled_makers = ['eslint']
	let g:neomake_css_enabled_makers = ['csslint']
	let g:neomake_sh_enabled_makers = ['shellcheck']
	let g:neomake_python_enabled_makers = ['python', 'flake8']

	let g:neomake_list_height = 3
	let g:neomake_open_list = 2 " Set to 2 so the cursor focus is set back to the editor window
  " let g:neomake_highlight_lines = 0
	" let g:neomake_verbose=3
	let g:neomake_logfile='/tmp/neomake_error.log'

" PLUGIN_YouCompleteMe:
	" let g:ycm_server_python_interpreter = '/usr/bin/python3'
	let g:ycm_global_ycm_extra_conf = ''
	let g:ycm_extra_conf_globlist = ['~/.ycm_extra_conf.py']
	let g:ycm_confirm_extra_conf = 0
	let g:ycm_always_populate_location_list = 0
	let g:ycm_open_loclist_on_ycm_diags = 0

	" Remove the preview window, the drop down is enough
	set completeopt-=preview

" PLUGIN_YCM_Generator:
	autocmd! BufWinEnter *.c,*.cpp,*.h,*.hpp
		\ silent! :YcmGenerateConfig --force . > /dev/null &
	autocmd! BufWritePost *.c,*.cpp,*.h,*.hpp
		\ silent! :YcmGenerateConfig --force . > /dev/null &

" CUSTOM CLEANUP:
	function! CleanupTrailing()
		" Remove trailing spaces or tabs
		:silent! %s/[ \t][ \t]*$//g
	endfunction

	function! CleanupSpace2Tab()
		" Replace double space indent with tab indent
		" :silent! %s/\(^\s*\)\@<= \{2\}/\t/g
		:silent! Space2Tab 2
	endfunction

	function! CleanupTab2Space()
		" Replace double space indent with tab indent
		" :silent! %s/\(^\s*\)\@<= \{2\}/\t/g
		:silent! Tab2Space 2
	endfunction

	function! CleanupExtraneousLineBreak()
		" Replace 3 consecutive new line with 2, so there is only a maximum of 1 line of space between code.
		:silent! %s/\n\n\n/\r\r/g
	endfunction

	function! CleanupPy()
		let save_cursor = getpos(".")
		call CleanupTrailing()
		call setpos('.', save_cursor)
	endfunction

	function! CleanupAll()
		let save_cursor = getpos(".")
		call CleanupTrailing()
		call CleanupSpace2Tab()
		call CleanupExtraneousLineBreak()
		call setpos('.', save_cursor)
	endfunction

	function! CleanupAllR()
		let save_cursor = getpos(".")
		call CleanupTrailing()
		call CleanupTab2Space()
		call CleanupExtraneousLineBreak()
		call setpos('.', save_cursor)
	endfunction

	au BufWritePre *.c call CleanupAll()
	au BufWritePre *.cpp call CleanupAll()
	au BufWritePre *.h call CleanupAll()
	au BufWritePre *.hpp call CleanupAll()

	au BufWritePre *.js call CleanupAll()
	au BufWritePre *.html call CleanupAll()
	au BufWritePre *.css call CleanupAll()

	au BufWritePre *.pm call CleanupAll()
	au BufWritePre *.pl call CleanupAll()
	au BufWritePre *.fpl call CleanupAll()

	au BufWritePre *.rb call CleanupAll()
	au BufWritePre *.py call CleanupPy()
	au BufWritePre *.sh call CleanupAll()

" SAPPS APPCACHE:
	" if there is an appcache file than we should increment the revision number,
	" this will search the current working directory for the appcache file so you
	" can be in any file in the project tree and it will be updated.
	" Must already have the correctly formatted date so it can be replaced
	" # 2015-02-12T13:04:42Z
	autocmd BufWritePost * silent execute "! if [ -f ".getcwd()."/sapps.appcache ]; then sed -i 's/20[0-9][0-9]-[0-1][0-9]-[0-3][0-9]T[0-2][0-9]:[0-5][0-9]:[0-5][0-9]Z/'`date -u +\"\\%Y-\\%m-\\%dT\\%H:\\%M:\\%SZ\"`'/g' ".getcwd()."/sapps.appcache; fi"
	autocmd BufWritePost * silent execute "! if [ -f ".getcwd()."/version.js ]; then sed -i 's/20[0-9][0-9]-[0-1][0-9]-[0-3][0-9]T[0-2][0-9]:[0-5][0-9]:[0-5][0-9]Z/'`date -u +\"\\%Y-\\%m-\\%dT\\%H:\\%M:\\%SZ\"`'/g' ".getcwd()."/version.js; fi"
	autocmd BufWritePost * silent execute "! if [ -f ".getcwd()."/sw.js ]; then sed -i 's/20[0-9][0-9]-[0-1][0-9]-[0-3][0-9]T[0-2][0-9]:[0-5][0-9]:[0-5][0-9]Z/'`date -u +\"\\%Y-\\%m-\\%dT\\%H:\\%M:\\%SZ\"`'/g' ".getcwd()."/sw.js; fi"



