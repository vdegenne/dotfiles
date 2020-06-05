filetype plugin on

" to activate the plugins copy plug.vim in ~/.vim/autoload/ and type `:PlugInstall` in vim
call plug#begin()
  Plug 'preservim/nerdcommenter'
  Plug 'preservim/nerdtree'
  Plug 'rafalbromirski/vim-aurora'
  Plug 'farmergreg/vim-lastplace'
call plug#end()

set termguicolors
inoremap <Esc> <Esc>:w<CR>

set mouse=a
