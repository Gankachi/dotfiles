" Basic settings
set nu
set ts=2 sw=2
" Masochist mode : No arrows
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

inoremap <Up>    <NOP>
inoremap <Down>  <NOP>
inoremap <Left>  <NOP>
inoremap <Right> <NOP>


" Plugin Management
call plug#begin('~/.local/share/nvim/plugged')

" neomake : Allows asynchronous actions in nvim
Plug 'neomake/neomake'

" NERDTree : Tree view inside of VIM
Plug 'scrooloose/nerdtree'

" fzf : Fuzzy search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Palenight
Plug 'drewtempelmeyer/palenight.vim'

" Python Linter
Plug 'nvie/vim-flake8'


call plug#end()

" Plugin settings

""" Nerd Tree
" Activate NERDTree on Ctrl+n
let NERDTreeShowHidden=1
map <silent> <C-n> :NERDTreeToggle<CR>

" Close NERDTree when file is opened
let g:NERDTreeQuitOnOpen=1

""" fzf
nnoremap <C-P> :Files<CR>

""" vim-airline
let g:airline_powerline_fonts = 1
let g:airline_theme="palenight"

""" Palenight
let g:palenight_terminal_italics=1
set termguicolors
