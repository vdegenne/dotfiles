call plug#begin()
  Plug 'preservim/nerdcommenter'
  Plug 'preservim/nerdtree'
  Plug 'rafalbromirski/vim-aurora'
call plug#end()

filetype plugin on
set termguicolors
inoremap <Esc> <Esc>:w<CR>
