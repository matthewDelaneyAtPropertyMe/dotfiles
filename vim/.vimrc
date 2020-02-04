set nocompatible

" => Plugins
    filetype off                  " required
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()

    " let Vundle manage Vundle, required
    Plugin 'VundleVim/Vundle.vim'
    Plugin 'morhetz/gruvbox'
    Plugin 'altercation/vim-colors-solarized'
    Plugin 'vim-airline/vim-airline'
    Plugin 'vim-airline/vim-airline-themes'
    Plugin 'majutsushi/tagbar'
    Plugin 'neoclide/coc.nvim', {'branch': 'release'}
    Plugin 'scrooloose/syntastic'
    Plugin 'tpope/vim-fugitive'
    Plugin 'universal-ctags/ctags'
    Plugin 'christoomey/vim-tmux-navigator'
    Plugin 'junegunn/goyo.vim'
    " All of your Plugins must be added before the following line
    call vundle#end()            " required
    filetype plugin indent on    " required

" => Colors and text

    set background=dark
    syntax enable
    set encoding=utf-8

    " gruvbox settings
    let g:gruvbox_contrast_dark='hard' " must be set first (no explanation)
    colorscheme gruvbox
    let g:airline_theme='base16_gruvbox_dark_hard'

" => Set default behaviour for key presses

    set backspace=indent,eol,start " Allows bs to remove indents, eol's and previously inserted text

    set tabstop=4 " size of tabs in spaces
    set softtabstop=4 " number of spaces removed when tab is backspaced
    set expandtab " tabs are spaces
    set shiftwidth=4 " '>' or '<' in visual mode is 4 spaces

    set clipboard=unnamed " allows copying and pasting to and from vim

" => UI Config
    set number relativenumber
    set cursorline " enables line highlighting
    set showmatch " highlights matching {[()]}
    set wildmenu
    set wildmode=longest,full
    set wildignorecase
    set shortmess+=I " disables splash screen on startup
    set shortmess+=A " disables swap file warning
    set breakindent " wrapped text is indented
    set breakindentopt=shift:4 " indented wrapped text wrapped with a 4 space indent
    set autoindent " apply prev line indent to line below
    set smartindent " adds automatic indenting after things like {
    set cpoptions+=n " when text wraps, does not highlight indents - create some wrapped text to see - 'compatible-options'
    set belloff=all " disables bell sound

    set hlsearch " turns search highlighting on
    set incsearch " search as characters are entered
    set ignorecase " case insensitive searching

    " Airline settings
    let g:airline#extensions#tabline#enabled=1 " applies airline style to tabs (esp. nice in gvim)
    let g:airline#extensions#branch#empty_message='NBD' " fugitive functionality: no branch detected
    let g:airline#extensions#syntastic#enabled=0 " disables syntastic integration - superfluous
    " controls layout, a=mode, b=branch, c=filepath, x=fileType, y=encoding, z=currPosition
    let g:airline#extensions#default#layout=[
        \ [ 'a', 'b', 'z', 'c' ],
        \ [ 'y' ]
        \ ]
    set noshowmode " stops --INSERT-- from appearing beneath airline

    " Tagbar settings
    let g:tagbar_compact=1 " gets rid of lines above tagbar
    let g:tagbar_autofocus=1 " autofocus on open

    " netrw settings
    let g:netrw_browse_split=3 " opens files in a new tab
    let g:netrw_liststyle=3 " tree visual style
    let g:netrw_banner=0 " removes banner
    let g:netrw_altv=1 " netrw, on Vexplore, will open on the left
    let g:netrw_winsize=15 " split only takes up 15% of the screen
    let g:netrw_sort_by=" name" " sorts alphabetically and by case and type, files, folders then folders with a Capital
    let g:netrw_sort_direction=" reverse"

    " coc settings
    set hidden " when there are unwritten changes to a file, hidden means it will not bug you to save them, instead saving the changes to a buffer
    set nobackup " Some servers have issues with backup files, see #649, also means we will never accidentally upload a backup file to git
    set nowritebackup
    set cmdheight=2 " Better display for messages
    set updatetime=300 " You will have bad experience for diagnostic messages when it's default 4000.
    set shortmess+=c " don't give ins-completion-menu messages.
    set signcolumn=yes " a column giving contextual information, like an IDE error column

    " syntastic settings
    let g:syntastic_auto_loc_list=1 " opens automatically on detection, closes when none are detected
    let g:syntastic_check_on_open=1 " runs checks on open
    let g:syntastic_check_on_wq=1 " checks for errors on wq
    let g:syntastic_echo_current_error=0 " disables command window
    let g:syntastic_enable_balloons=0 " disables balloon on mouse hover
    " makes the height of display equal min of numErrors or 3:
    function! SyntasticCheckHook(errors)
        if !empty(a:errors)
            let g:syntastic_loc_list_height=min([len(a:errors), 3])
        endif
    endfunction

    " Tmux-navigator settings


" => Remappings

    let mapleader=',' " Where you see <leader> in remaps, replace mentally with this

    " allows for navigating wrapped lines with default controls, look up gj and gk's use
    nnoremap j gj
    nnoremap k gk
    " change split by pressing ctrl+j rather than ctrl+w then j
    nnoremap <C-J> <C-W><C-J>
    nnoremap <C-K> <C-W><C-K>
    nnoremap <C-L> <C-W><C-L>
    nnoremap <C-H> <C-W><C-H>
    nnoremap <leader><space> :nohlsearch<CR>| " <leader> followed by space turns off highlights from previous search

    map <leader>e :tabe ~/.vimrc<CR>| " Quick open vimrc
    map <leader>t :TagbarToggle<CR>| " Toggles tagbar
    map <leader>n :Lexplore<CR>| " Toggles load/leave netrw - Lexplore takes up whole left side

    " => COC
        " Use tab for trigger completion with coc
        inoremap <silent><expr> <TAB>
              \ pumvisible() ? "\<C-n>" :
              \ <SID>check_back_space() ? "\<TAB>" :
              \ coc#refresh()
        inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

        function! s:check_back_space() abort
          let col=col('.') - 1
          return !col || getline('.')[col - 1]  =~# '\s'
        endfunction

        " Use K to show documentation in preview window with coc
        nnoremap <silent> K :call <SID>show_documentation()<CR>
        " close preview window when completion is done coc
        autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

    " => NETRW
        " This function allows calling shift-V to highlight files in netrw, and
        " call j to go down and highlight more as a group, and then call T to open
        " all the files at once
        function! s:show_documentation()
          if (index(['vim','help'], &filetype) >= 0)
            execute 'h '.expand('<cword>')
          else
            call CocAction('doHover')
          endif
        endfunction

        function! NetrwOpenMultiTab(current_line,...) range
            " Get the number of lines.
            let n_lines= a:lastline - a:firstline + 1

            " This is the command to be built up.
            let command="normal "

            " Iterator.
            let i=1

            " Virtually iterate over each line and build the command.
            while i < n_lines
                let command .= "tgT:" . ( a:firstline + i ) . "\<CR>:+tabmove\<CR>"
                let i += 1
            endwhile
            let command .= "tgT"

            " Restore the Explore tab position.
            if i != 1
                let command .= ":tabmove -" . ( n_lines - 1 ) . "\<CR>"
            endif

            " Restore the previous cursor line.
            let command .= ":" . a:current_line  . "\<CR>"

            " Check function arguments
            if a:0 > 0
                if a:1 > 0 && a:1 <= n_lines
                    " The current tab is for the nth file.
                    let command .= ( tabpagenr() + a:1 ) . "gt"
                else
                    " The current tab is for the last selected file.
                    let command .= (tabpagenr() + n_lines) . "gt"
                endif
            endif
            " The current tab is for the Explore tab by default.

            " Execute the custom command.
            execute command
        endfunction

        " Define mappings.
        augroup NetrwOpenMultiTabGroup
        autocmd!
        autocmd Filetype netrw vnoremap <buffer> <silent> <expr> t ":call NetrwOpenMultiTab(" . line(".") . "," . "v:count)\<CR>"
        autocmd Filetype netrw vnoremap <buffer> <silent> <expr> T ":call NetrwOpenMultiTab(" . line(".") . "," . (( v:count == 0) ? '' : v:count) . ")\<CR>"
        augroup END

    " => Go-yo
        " sets up 
        function! ProseMode()
            call goyo#execute(0, [])
            set spell noci nosi noai nolist noshowmode noshowcmd 
            set signcolumn="no"
            set complete+=s
            set bg=light
            colorscheme solarized
        endfunction

        command! ProseMode call ProseMode()
        nmap <leader>p :ProseMode<CR>