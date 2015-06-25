" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Dec 17
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

syntax enable
colo blazer
" colo distinguished
noremap j gj
noremap k gk
set backupdir=~/.vim/backup
set tabstop=4
"inoremap {} {}<++><Esc>hhhhi
"inoremap () ()<++><Esc>hhhhi
"inoremap [] []<++><Esc>hhhhi
set exrc
set secure

let g:ycm_global_ycm_extra_conf = "~/.vim/ycm_extra_conf.py"
let g:ycm_extra_conf_globlist = ['~/Projects/*']
"let g:ycm_confirm_extra_conf = 0

let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_signs = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_cpp_check_header = 1
"let g:syntastic_cpp_no_include_search = 0
let g:syntastic_javascript_checkers = ["gjslint"]
let g:syntastic_cpp_compiler = "g++"
let g:syntastic_cpp_compiler_options = " -std=c++11"
let g:syntastic_tex_chktex_args = " -n 1"
let g:syntastic_python_checkers = []
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_stl_format = '%E{Errors: #%e (%fe)}%B{, }%W{Warnings: #%w (%fw)}]'
let g:syntastic_mode_map={ 'mode': 'active',
	\ 'active_filetypes': [],
	\ 'passive_filetypes': ['zsh'] }

map <C-n> :NERDTreeToggle<CR>


" vim-latexsuite
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"
set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after


" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
if &t_Co > 2 || has("gui_running")
  syntax on
endif

" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
au!

au BufRead,BufNewFile *.txt		set filetype=text
au BufRead,BufNewFile *.md		set filetype=text
au BufRead,BufNewFile *.tex		set filetype=tex

" For all text files set 'textwidth' to 78 characters.
autocmd FileType text,txt setlocal textwidth=78 tabstop=4 formatoptions+=t spelllang=en_gb spell

autocmd FileType tex setlocal textwidth=78 formatoptions+=t spelllang=en_gb spell

autocmd FileType cpp,cc,cxx,html,javascript setlocal tabstop=2 shiftwidth=2 expandtab nu
autocmd FileType python setlocal tabstop=4 shiftwidth=4 expandtab nu
autocmd FileType cs setlocal tabstop=4 shiftwidth=4 expandtab nu
autocmd FileType c setlocal tabstop=8 softtabstop=8 shiftwidth=8 noexpandtab nu

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost *
\ if line("'\"") > 1 && line("'\"") <= line("$") |
\   exe "normal! g`\"" |
\ endif

augroup END


" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif
