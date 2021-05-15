let mapleader =" "

if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
  echo "Downloading junegunn/vim-plug to manage plugins..."
  silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
  silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
"Plug 'tpope/vim-surround'
Plug 'preservim/nerdtree'
"Plug 'junegunn/goyo.vim'
Plug 'jreybert/vimagit'
"Plug 'lukesmithxyz/vimling'
Plug 'vimwiki/vimwiki'
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'joshdick/onedark.vim'
Plug 'christoomey/vim-tmux-navigator'
call plug#end()

set termguicolors
colorscheme onedark

set hidden autowrite autoread
set title
set bg=dark
set go=a
set mouse=a
set nohlsearch ignorecase smartcase
set clipboard+=unnamedplus
set noshowmode noruler laststatus=0
set splitbelow splitright
set shiftwidth=2 tabstop=2 softtabstop=2
set expandtab smarttab smartindent
" Scroll Offset
set scrolloff=4
set encoding=utf-8
set wildmode=longest,list,full
set nrformats-=octal
set ignorecase smartcase
" Allow backspacing over everything in insert mode
set backspace=indent,eol,start
set formatoptions=qrnj1
set wildmode=list:longest,full

" Source init.vim
nnoremap <leader><CR> :w<CR>:so ~/.config/nvim/init.vim<CR>
nnoremap c "_c

" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" Perform dot commands over visual blocks:
vnoremap . :normal .<CR>

" Nerd tree
nnoremap <leader>n :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
if has('nvim')
  let NERDTreeBookmarksFile = stdpath('data') . '/NERDTreeBookmarks'
else
  let NERDTreeBookmarksFile = '~/.vim' . '/NERDTreeBookmarks'
endif

" " Open corresponding .pdf/.html or preview
" map <leader>p :!opout <c-r>%<CR><CR>

" " Runs a script that cleans out tex build files whenever I close out of a .tex file.
" autocmd VimLeave *.tex !texclear %
" start: 'vimwiki/vimwiki'
let wiki_1 = {}
let wiki_1.path = '~/wiki'
let wiki_1.syntax = 'markdown'
let wiki_1.nested_syntaxes = {'python': 'python', 'c++': 'cpp','bash':'sh' }
let wiki_1.ext = '.md'
let wiki_1.links_space_char = '_'
let g:vimwiki_list = [wiki_1]


" Automatically deletes all trailing whitespace and newlines at end of file on save.
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * %s/\n\+\%$//e
" autocmd BufWritePre *.[ch] %s/\%$/\r/e

" Function for toggling the bottom statusbar:
let s:hidden_all = 1
function! ToggleHiddenAll()
  if s:hidden_all  == 0
    let s:hidden_all = 1
    set noshowmode
    set noruler
    set laststatus=0
  else
    let s:hidden_all = 0
    set showmode
    set ruler
    set laststatus=2
  endif
endfunction
nnoremap <leader>x :call ToggleHiddenAll()<CR>

" FZF settings
nnoremap <silent> <Leader>t :Files<cr>
nnoremap <silent> <Leader>b :Buffers<CR>

" Stop :Rg from matching files names in search
  command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
" Use rg instead of grep
set grepprg=rg\ --vimgrep\ --smart-case\ --follow
