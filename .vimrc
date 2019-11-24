" MAIN1 ------------------------------------------------------------------- {{{

filetype off
autocmd!
if &loadplugins == 1
    call pathogen#infect()
    call pathogen#helptags()
endif
set nocompatible
filetype indent plugin on

if isdirectory($XDG_CACHE_HOME . '/vim' ) == 0
    :silent !install -dm700 $XDG_CACHE_HOME/vim >/dev/null 2>&1
endif
set directory=$XDG_CACHE_HOME/vim//

" }}}
" SETTINGS ---------------------------------------------------------------- {{{
" 0   unknown {{{
" 0   'antialias'       'anti'    Mac OS X: use smooth, antialiased fonts
" 0   'bioskey'         'biosk'   MS-DOS: use bios calls for input characters
" 0   'conskey'         'consk'   get keys directly from console (MS-DOS only)
" 0   'guifontset'      'gfs'     GUI: Names of multi-byte fonts to be used
" 0   'key'                       encryption key
" 0   'macatsui'                  Mac GUI: use ATSUI text drawing
" 0   'mzquantum'       'mzq'     the interval between polls for MzScheme threads
" 0   'opendevice'      'odev'    allow reading/writing devices on MS-Windows
" 0   'osfiletype'      'oft'     no longer supported
" 0   'renderoptions'   'rop'     options for text rendering on Windows
" 0   'restorescreen'   'rs'      Win32: restore screen when exiting
" 0   'shellslash'      'ssl'     use forward slash for shell file names
" 0   'shelltype'       'st'      Amiga: influences how to use a shell
" }}}
" 1   important {{{
" 1   'compatible'      'cp'      behave Vi-compatible as much as possible
" 1   'cpoptions'       'cpo'     flags for Vi-compatible behavior
set cpoptions-=m,<
" 1   'helpfile'        'hf'      full path name of the main help file
" 1   'insertmode'      'im'      start the edit of a file in Insert mode
" 1   'paste'                     allow pasting text
" 1   'pastetoggle'     'pt'      key code that causes 'paste' to toggle
set pastetoggle=<F9>
" 1   'runtimepath'     'rtp'     list of directories used for runtime files
" }}}
" 2   moving around, searching and patterns {{{
" 2   'autochdir'       'acd'     change directory to the file in the current window
" 2   'casemap'         'cmp'     specifies how case of letters is changed
" 2   'cdpath'          'cd'      list of directories searched with ":cd"
" 2   'define'          'def'     pattern to be used to find a macro definition
" 2   'ignorecase'      'ic'      ignore case in search patterns
set ignorecase
" 2   'include'         'inc'     pattern to be used to find an include file
" 2   'includeexpr'     'inex'    expression used to process an include line
" 2   'incsearch'       'is'      highlight match while typing search pattern
set incsearch
" 2   'magic'                     changes special characters in search patterns
" 2   'maxmempattern'   'mmp'     maximum memory (in Kbyte) used for pattern search
" 2   'paragraphs'      'para'    nroff macros that separate paragraphs
" 2   'path'            'pa'      list of directories searched with "gf" et.al.
" 2   'regexpengine'    're'      default regexp engine to use
" 2   'sections'        'sect'    nroff macros that separate sections
" 2   'smartcase'       'scs'     no ignore case when pattern has uppercase
set smartcase
" 2   'startofline'     'sol'     commands move cursor to first non-blank in line
set nostartofline
" 2   'whichwrap'       'ww'      allow specified keys to cross line boundaries
set whichwrap+=h,l,<,>,[,],b,s,~
" 2   'wrapscan'        'ws'      searches wrap around the end of the file
set wrapscan
" }}}
" 3   tags {{{
" 3   'cscopepathcomp'  'cspc'    how many components of the path to show
" 3   'cscopeprg'       'csprg'   command to execute cscope
" 3   'cscopequickfix'  'csqf'    use quickfix window for cscope results
" 3   'cscoperelative'  'csre'    Use cscope.out path basename as prefix
" 3   'cscopetag'       'cst'     use cscope for tag commands
" 3   'cscopetagorder'  'csto'    determines ":cstag" search order
" 3   'cscopeverbose'   'csverb'  give messages when adding a cscope database
" 3   'showfulltag'     'sft'     show full tag pattern when completing tag
set showfulltag
" 3   'tagbsearch'      'tbs'     use binary searching in tags files
" 3   'taglength'       'tl'      number of significant characters for a tag
" 3   'tagrelative'     'tr'      file names in tag file are relative
" 3   'tags'            'tag'     list of file names used by the tag command
set tags=./tags;/
" 3   'tagstack'        'tgst'    push tags onto the tag stack
" }}}
" 4   displaying text {{{
" 4   'breakat'         'brk'     characters that may cause a line break
" 4   'breakindent'     'bri'     wrapped line repeats indent
set breakindent
" 4   'breakindentopt'  'briopt'  settings for 'breakindent'
"set breakindentopt=sbr
" 4   'cmdheight'       'ch'      number of lines to use for the command-line
" 4   'columns'         'co'      number of columns in the display
" 4   'concealcursor'   'cocu'    whether concealable text is hidden in cursor line
" 4   'conceallevel'    'cole'    whether concealable text is shown or hidden
" 4   'display'         'dy'      list of flags for how to display text
set display+=lastline
" 4   'fillchars'       'fcs'     characters to use for displaying special items
set fillchars+=fold:\⋅"
" 4   'lazyredraw'      'lz'      don't redraw while executing macros
set lazyredraw
" 4   'linebreak'       'lbr'     wrap long lines at a blank
set linebreak
" 4   'lines'                     number of lines in the display
" 4   'list'                      show <Tab> and <EOL>
set list
augroup list
    autocmd!
    autocmd InsertEnter * :set nolist
    autocmd InsertLeave * :set list
augroup END
" 4   'listchars'       'lcs'     characters for displaying in list mode
exec "set listchars=tab:\uBB\uBB,extends:>,precedes:<,nbsp:~,trail:\uB7"
" 4   'number'          'nu'      print the line number in front of each line
set number
augroup number
    autocmd!
    autocmd InsertEnter * :set nonumber
    autocmd InsertLeave * :set number
augroup END
" 4   'numberwidth'     'nuw'     number of columns used for the line number
" 4   'redrawtime'      'rdt'     timeout for 'hlsearch' and :match highlighting
" 4   'relativenumber'  'rnu'     show relative line number in front of each line
set norelativenumber
" 4   'scroll'          'scr'     lines to scroll with CTRL-U and CTRL-D
" 4   'scrolloff'       'so'      minimum nr. of lines above and below cursor
set scrolloff=3
" 4   'showbreak'       'sbr'     string to use at the start of wrapped lines
set showbreak=↳\ \ \ "
" 4   'sidescroll'      'ss'      minimum number of columns to scroll horizontal
set sidescroll=1
" 4   'sidescrolloff'   'siso'    min. nr. of columns to left and right of cursor
set sidescrolloff=10
" 4   'window'          'wi'      nr of lines to scroll for CTRL-F and CTRL-B
" 4   'wrap'                      long lines wrap and continue on the next line
set wrap
" 4   'writedelay'      'wd'      delay this many msec for each char (for debug)
" }}}
" 5   syntax, highlighting and spelling {{{
" 5   'background'      'bg'      "dark" or "light", used for highlight colors
set background=dark
" 5   'colorcolumn'     'cc'      columns to highlight
set colorcolumn=80
" 5   'cursorcolumn'    'cuc'     highlight the screen column of the cursor
" 5   'cursorline'      'cul'     highlight the screen line of the cursor
set cursorline
augroup cursorline
    autocmd!
    autocmd WinLeave,InsertEnter * set nocursorline
    autocmd WinEnter,InsertLeave * set cursorline
augroup END
" 5   'filetype'        'ft'      type of file, used for autocommands
" 5   'highlight'       'hl'      sets highlighting mode for various occasions
" 5   'hlsearch'        'hls'     highlight matches with last search pattern
set hlsearch
" 5   'mkspellmem'      'msm'     memory used before :mkspell compresses the tree
" 5   'spell'                     enable spell checking
set nospell
" 5   'spellcapcheck'   'spc'     pattern to locate end of a sentence
" 5   'spellfile'       'spf'     files where zg and zw store words
set spellfile=$HOME/.vim/custom-dictionary.utf-8.add
" 5   'spelllang'       'spl'     language(s) to do spell checking for
" 5   'spellsuggest'    'sps'     method(s) used to suggest spelling corrections
" 5   'synmaxcol'       'smc'     maximum column to find syntax items
set synmaxcol=800
" 5   'syntax'          'syn'     syntax to be loaded for current buffer
" }}}
" 6   multiple windows {{{
" 6   'cursorbind'      'crb'     move cursor in window as it moves in other windows
" 6   'eadirection'     'ead'     in which direction 'equalalways' works
" 6   'equalalways'     'ea'      windows are automatically made the same size
" 6   'helpheight'      'hh'      minimum height of a new help window
" 6   'hidden'          'hid'     don't unload buffer when it is abandoned
set hidden
" 6   'laststatus'      'ls'      tells when last window has status lines
set laststatus=2
" 6   'previewheight'   'pvh'     height of the preview window
" 6   'previewwindow'   'pvw'     identifies the preview window
" 6   'scrollbind'      'scb'     scroll in window as other windows scroll
" 6   'scrollopt'       'sbo'     how 'scrollbind' should behave
" 6   'splitbelow'      'sb'      new window from split is below the current one
set splitbelow
" 6   'splitright'      'spr'     new window is put right of the current one
set splitright
" 6   'statusline'      'stl'     custom format for the status line
set statusline=%<%f
set statusline+=%w%h%m%r
set statusline+=\ [%{&ff}/%Y]
set statusline+=\ [%{getcwd()}]
set statusline+=%=%-14.(%l,%c%V%)\ %p%%
" 6   'switchbuf'       'swb'     sets behavior when switching to another buffer
" 6   'winfixheight'    'wfh'     keep window height when opening/closing windows
" 6   'winfixwidth'     'wfw'     keep window width when opening/closing windows
" 6   'winheight'       'wh'      minimum number of lines for the current window
" 6   'winminheight'    'wmh'     minimum number of lines for any window
set winminheight=0
" 6   'winminwidth'     'wmw'     minimal number of columns for any window
" 6   'winwidth'        'wiw'     minimal number of columns for current window
" }}}
" 7   multiple tab pages {{{
" 7   'guitablabel'     'gtl'     GUI: custom label for a tab page
" 7   'guitabtooltip'   'gtt'     GUI: custom tooltip for a tab page
" 7   'showtabline'     'stal'    tells when the tab pages line is displayed
set showtabline=1
" 7   'tabline'         'tal'     custom format for the console tab pages line
" 7   'tabpagemax'      'tpm'     maximum number of tab pages for -p and "tab all"
set tabpagemax=50
" }}}
" 8   terminal {{{
" 8   'esckeys'         'ek'      recognize function keys in Insert mode
" 8   'guicursor'       'gcr'     GUI: settings for cursor shape and blinking
set guicursor+=a:blinkon0
" 8   'icon'                      let Vim set the text of the window icon
" 8   'iconstring'                string to use for the Vim icon text
" 8   'scrolljump'      'sj'      minimum number of lines to scroll
set scrolljump=5
" 8   'term'                      name of the terminal
" 8   'title'                     let Vim set the title of the window
set title
" 8   'titlelen'                  percentage of 'columns' used for window title
" 8   'titleold'                  old title, restored when exiting
" 8   'titlestring'               string to use for the Vim window title
" 8   'ttybuiltin'      'tbi'     use built-in termcap before external termcap
" 8   'ttyfast'         'tf'      indicates a fast terminal connection
set ttyfast
" 8   'ttyscroll'       'tsl'     maximum number of lines for a scroll
" 8   'ttytype'         'tty'     alias for 'term'
" 8   'weirdinvert'     'wiv'     for terminals that have weird inversion method

" manipulate termcap. remove bold fonts:
set t_md=

" }}}
" 9   using the mouse {{{
" 9   'mouse'                     enable the use of mouse clicks
set mouse=a
" 9   'mousefocus'      'mousef'  keyboard focus follows the mouse
set mousefocus
" 9   'mousehide'       'mh'      hide mouse pointer while typing
" 9   'mousemodel'      'mousem'  changes meaning of mouse buttons
" 9   'mouseshape'      'mouses'  shape of the mouse pointer in different modes
" 9   'mousetime'       'mouset'  max time between mouse double-click
" 9   'ttymouse'        'ttym'    type of mouse codes generated
set ttymouse=xterm2
" }}}
" 10  GUI {{{
" 10  'balloondelay'    'bdlay'   delay in mS before a balloon may pop up
" 10  'ballooneval'     'beval'   switch on balloon evaluation
" 10  'balloonexpr'     'bexpr'   expression to show in balloon
" 10  'browsedir'       'bsdir'   which directory to start browsing in
" 10  'guifont'         'gfn'     GUI: Name(s) of font(s) to be used
set guifont=monospace\ 9
" 10  'guifontwide'     'gfw'     list of font names for double-wide characters
" 10  'guiheadroom'     'ghr'     GUI: pixels room for window decorations
" 10  'guioptions'      'go'      GUI: Which components and options are used
set guioptions=acep
" 10  'guipty'                    GUI: try to use a pseudo-tty for ":!" commands
" 10  'langmenu'        'lm'      language to be used for the menus
" 10  'linespace'       'lsp'     number of pixel lines to use between characters
set linespace=0
" 10  'menuitems'       'mis'     maximum number of items in a menu
" 10  'toolbar'         'tb'      GUI: which items to show in the toolbar
" 10  'toolbariconsize' 'tbis'    size of the toolbar icons (for GTK 2 only)
" 10  'winaltkeys'      'wak'     when the windows system handles ALT keys
" }}}
" 11  printing {{{
" 11  'printdevice'     'pdev'    name of the printer to be used for :hardcopy
" 11  'printencoding'   'penc'    encoding to be used for printing
" 11  'printexpr'       'pexpr'   expression used to print PostScript for :hardcopy
" 11  'printfont'       'pfn'     name of the font to be used for :hardcopy
" 11  'printheader'     'pheader' format of the header used for :hardcopy
" 11  'printmbcharset'  'pmbcs'   CJK character set to be used for :hardcopy
" 11  'printmbfont'     'pmbfn'   font names to be used for CJK output of :hardcopy
" 11  'printoptions'    'popt'    controls the format of :hardcopy output
" }}}
" 12  messages and info {{{
" 12  'confirm'         'cf'      ask what to do about unsaved/read-only files
" 12  'errorbells'      'eb'      ring the bell for error messages
" 12  'helplang'        'hlg'     preferred help languages
" 12  'more'                      pause listings when the whole screen is filled
" 12  'report'                    threshold for reporting nr. of lines changed
set report=0
" 12  'ruler'           'ru'      show cursor line and column in the status line
set ruler
" 12  'rulerformat'     'ruf'     custom format for the ruler
" 12  'shortmess'       'shm'     list of flags, reduce length of messages
set shortmess+=aI
" 12  'showcmd'         'sc'      show (partial) command in status line
set showcmd
" 12  'showmode'        'smd'     message on status line to show current mode
set showmode
" 12  'terse'                     shorten some messages
" 12  'verbose'         'vbs'     give informative messages
" 12  'verbosefile'     'vfile'   file to write messages in
" 12  'visualbell'      'vb'      use visual bell instead of beeping
set novisualbell
" }}}
" 13  selecting text {{{
" 13  'clipboard'       'cb'      use the clipboard as the unnamed register
set clipboard=unnamed
" 13  'keymodel'        'km'      enable starting/stopping selection with keys
" 13  'selection'       'sel'     what type of selection to use
" 13  'selectmode'      'slm'     when to use Select mode instead of Visual mode
" }}}
" 14  editing text {{{
" 14  'backspace'       'bs'      how backspace works at start of line
set backspace=indent,eol,start
" 14  'comments'        'com'     patterns that can start a comment line
" 14  'complete'        'cpt'     specify how Insert mode completion works
set complete=.,w,b,u,t
" 14  'completefunc'    'cfu'     function to be used for Insert mode completion
" 14  'completeopt'     'cot'     options for Insert mode completion
set completeopt=longest,menuone,preview
" 14  'dictionary'      'dict'    list of file names used for keyword completion
set dictionary+=/usr/share/dict/words
" 14  'digraph'         'dg'      enable the entering of digraphs in Insert mode
" 14  'formatexpr'      'fex'     expression used with "gq" command
" 14  'formatlistpat'   'flp'     pattern used to recognize a list header
" 14  'formatoptions'   'fo'      how automatic formatting is to be done
set formatoptions=qrn1j
" 14  'infercase'       'inf'     adjust case of match for keyword completion
set infercase
" 14  'joinspaces'      'js'      two spaces after a period with a join command
" 14  'matchpairs'      'mps'     pairs of characters that "%" can match
set matchpairs+=<:>
" 14  'matchtime'       'mat'     tenths of a second to show matching paren
set matchtime=2
" 14  'modifiable'      'ma'      changes to the text are not possible
" 14  'modified'        'mod'     buffer has been modified
" 14  'nrformats'       'nf'      number formats recognized for CTRL-A command
" 14  'omnifunc'        'ofu'     function for filetype-specific completion
" 14  'operatorfunc'    'opfunc'  function to be called for g@ operator
" 14  'pumheight'       'ph'      maximum height of the popup menu
set pumheight=20
" 14  'readonly'        'ro'      disallow writing the buffer
" 14  'showmatch'       'sm'      briefly jump to matching bracket if insert one
set showmatch
" 14  'textwidth'       'tw'      maximum width of text that is being inserted
set textwidth=0
" 14  'thesaurus'       'tsr'     list of thesaurus files for keyword completion
" 14  'tildeop'         'top'     tilde command "~" behaves like an operator
" 14  'undolevels'      'ul'      maximum number of changes that can be undone
" 14  'undoreload'      'ur'      max nr of lines to save for undo on a buffer reload
set undoreload=10000
" 14  'wrapmargin'      'wm'      chars from the right where wrapping starts
set wrapmargin=0
" }}}
" 15  tabs and indenting {{{
" 15  'autoindent'      'ai'      take indent for new line from previous line
" set autoindent
" 15  'cindent'         'cin'     do C program indenting
" 15  'cinkeys'         'cink'    keys that trigger indent when 'cindent' is set
" 15  'cinoptions'      'cino'    how to do indenting when 'cindent' is set
set cinoptions=:0,l1,t0,g0,(0
" 15  'cinwords'        'cinw'    words where 'si' and 'cin' add an indent
" 15  'copyindent'      'ci'      make 'autoindent' use existing indent structure
" set copyindent
" 15  'expandtab'       'et'      use spaces when <Tab> is inserted
" set expandtab
" 15  'indentexpr'      'inde'    expression used to obtain the indent of a line
" 15  'indentkeys'      'indk'    keys that trigger indenting with 'indentexpr'
" 15  'lisp'                      automatic indenting for Lisp
" 15  'lispwords'       'lw'      words that change how lisp indenting works
" 15  'preserveindent'  'pi'      preserve the indent structure when reindenting
" set preserveindent
" 15  'shiftround'      'sr'      round indent to multiple of shiftwidth
" set shiftround
" 15  'shiftwidth'      'sw'      number of spaces to use for (auto)indent step
set shiftwidth=8
" 15  'smartindent'     'si'      smart autoindenting for C programs
" set smartindent
" 15  'smarttab'        'sta'     use 'shiftwidth' when inserting <Tab>
" set smarttab
" 15  'softtabstop'     'sts'     number of spaces that <Tab> uses while editing
" set softtabstop=4
" 15  'tabstop'         'ts'      number of spaces that <Tab> in file uses
set tabstop=8
" }}}
" 16  folding {{{
" 16  'commentstring'   'cms'     template for comments; used for fold marker
set commentstring=%s
" 16  'foldclose'       'fcl'     close a fold when the cursor leaves it
" 16  'foldcolumn'      'fdc'     width of the column used to indicate folds
set foldcolumn=1
" 16  'foldenable'      'fen'     set to display all folds open
set nofoldenable
" 16  'foldexpr'        'fde'     expression used when 'foldmethod' is "expr"
" 16  'foldignore'      'fdi'     ignore lines when 'foldmethod' is "indent"
" 16  'foldlevel'       'fdl'     close folds with a level higher than this
" 16  'foldlevelstart'  'fdls'    'foldlevel' when starting to edit a file
set foldlevelstart=99
" 16  'foldmarker'      'fmr'     markers used when 'foldmethod' is "marker"
" 16  'foldmethod'      'fdm'     folding type
set foldmethod=marker
" 16  'foldminlines'    'fml'     minimum number of lines for a fold to be closed
" 16  'foldnestmax'     'fdn'     maximum fold depth
" set foldnestmax=0
" 16  'foldopen'        'fdo'     for which commands a fold will be opened
" 16  'foldtext'        'fdt'     expression used to display for a closed fold
" }}}
" 17  diff mode {{{
" 17  'diff'                      use diff mode for the current window
" 17  'diffexpr'        'dex'     expression used to obtain a diff file
" 17  'diffopt'         'dip'     options for using diff mode
set diffopt=filler,vertical
" 17  'patchexpr'       'pex'     expression used to patch a file
" }}}
" 18  mapping {{{
" 18  'maxmapdepth'     'mmd'     maximum recursive depth for mapping
" 18  'remap'                     allow mappings to work recursively
" 18  'timeout'         'to'      time out on mappings and key codes
set notimeout
" 18  'timeoutlen'      'tm'      time out time in milliseconds
" 18  'ttimeout'                  time out on mappings
set ttimeout
" 18  'ttimeoutlen'     'ttm'     time out time for key codes in milliseconds
set ttimeoutlen=10
" }}}
" 19  reading and writing files {{{
" 19  'autoread'        'ar'      autom. read file when changed outside of Vim
set autoread
" 19  'autowrite'       'aw'      automatically write file if changed
set autowrite
" 19  'autowriteall'    'awa'     as 'autowrite', but works with more commands
" 19  'backup'          'bk'      keep backup file after overwriting a file
set nobackup
" 19  'backupcopy'      'bkc'     make backup as a copy, don't rename the file
" 19  'backupdir'       'bdir'    list of directories for the backup file
let &backupdir=&directory
" 19  'backupext'       'bex'     extension used for the backup file
" 19  'backupskip'      'bsk'     no backup for files that match these patterns
set backupskip=/tmp/*
" 19  'binary'          'bin'     read/write/edit file in binary mode
" 19  'bomb'                      prepend a Byte Order Mark to the file
" 19  'cryptmethod'     'cm'      type of encryption to use for file writing
" 19  'endofline'       'eol'     write <EOL> for last line in file
" 19  'fileformat'      'ff'      file format used for file I/O
set fileformat=unix
" 19  'fileformats'     'ffs'     automatically detected values for 'fileformat'
set fileformats=unix,dos,mac
" 19  'fsync'           'fs'      whether to invoke fsync() after file write
" 19  'modeline'        'ml'      recognize modelines at start or end of file
set modeline
" 19  'modelines'       'mls'     number of lines checked for modelines
set modelines=5
" 19  'patchmode'       'pm'      keep the oldest version of a file
" 19  'shortname'       'sn'      non-MS-DOS: Filenames assumed to be 8.3 chars
" 19  'textauto'        'ta'      obsolete, use 'fileformats'
" 19  'textmode'        'tx'      obsolete, use 'fileformat'
" 19  'write'                     writing to a file is allowed
" 19  'writeany'        'wa'      write to file with no need for "!" override
" 19  'writebackup'     'wb'      make a backup before overwriting a file
set nowritebackup
" }}}
" 20  the swap file {{{
" 20  'directory'       'dir'     list of directory names for the swap file
" 20  'maxmem'          'mm'      maximum memory (in Kbyte) used for one buffer
" 20  'maxmemtot'       'mmt'     maximum memory (in Kbyte) used for all buffers
" 20  'swapfile'        'swf'     whether to use a swapfile for a buffer
set swapfile
" 20  'swapsync'        'sws'     how to sync the swap file
set swapsync=
" 20  'updatecount'     'uc'      after this many characters flush swap file
" 20  'updatetime'      'ut'      after this many milliseconds flush swap file
set updatetime=1000
" }}}
" 21  command line editing {{{
" 21  'cedit'                     key used to open the command-line window
" 21  'cmdwinheight'    'cwh'     height of the command-line window
" 21  'fileignorecase'  'fic'     ignore case when using file names
" 21  'history'         'hi'      number of command-lines that are remembered
set history=1000
" 21  'suffixes'        'su'      suffixes that are ignored with multiple match
" 21  'suffixesadd'     'sua'     suffixes added when searching for a file
" 21  'undodir'         'udir'    where to store undo files
let &undodir=&directory
" 21  'undofile'        'udf'     save undo information in a file
set undofile
" 21  'wildchar'        'wc'      command-line character for wildcard expansion
" 21  'wildcharm'       'wcm'     like 'wildchar' but also works when mapped
" 21  'wildignore'      'wig'     files matching these patterns are not completed
set wildignore+=*.bak,*.o,*.e,*~,*.obj,*.exe,*.dll,*.manifest
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
set wildignore+=*.aux,*.out,*.toc
set wildignore+=*.swp,*.jpg,*.jpeg,*.bmp,*.png,*.xpm,*.gif,*.ico
" 21  'wildignorecase'  'wic'     ignore case when completing file names
" 21  'wildmenu'        'wmnu'    use menu for command line completion
set wildmenu
" 21  'wildmode'        'wim'     mode for 'wildchar' command-line expansion
set wildmode=list:longest,full
" 21   'wildoptions'     'wop'     specifies how command line completion is done
set wildoptions=tagfile
" }}}
" 22  executing external commands {{{
" 22  'equalprg'        'ep'      external program to use for "=" command
" 22  'formatprg'       'fp'      name of external program used with "gq" command
" 22  'keywordprg'      'kp'      program to use for the "K" command
set keywordprg=:help
" 22  'shell'           'sh'      name of shell to use for external commands
" 22  'shellcmdflag'    'shcf'    flag to shell to execute one command
" 22  'shellquote'      'shq'     quote character(s) for around shell command
" 22  'shellredir'      'srr'     string to put output of filter in a temp file
" 22  'shelltemp'       'stmp'    whether to use a temp file for shell commands
" 22  'shellxescape'    'sxe'     characters to escape when 'shellxquote' is (
" 22  'shellxquote'     'sxq'     like 'shellquote', but include redirection
" 22  'warn'                      warn for shell command when buffer was changed
" }}}
" 23  running make and jumping to errors {{{
" 23  'errorfile'       'ef'      name of the errorfile for the QuickFix mode
" 23  'errorformat'     'efm'     description of the lines in the error file
" 23  'grepformat'      'gfm'     format of 'grepprg' output
" 23  'grepprg'         'gp'      program to use for ":grep"
set grepprg=grep\ -nH
" 23  'makeef'          'mef'     name of the errorfile for ":make"
" 23  'makeprg'         'mp'      program to use for the ":make" command
" 23  'shellpipe'       'sp'      string to put output of ":make" in error file
" }}}
" 24  language specific {{{
" 24  'aleph'           'al'      ASCII code of the letter Aleph (Hebrew)
" 24  'allowrevins'     'ari'     allow CTRL-_ in Insert and Command-line mode
" 24  'altkeymap'       'akm'     for default second language (Farsi/Hebrew)
" 24  'arabic'          'arab'    for Arabic as a default second language
" 24  'arabicshape'     'arshape' do shaping for Arabic characters
" 24  'fkmap'           'fk'      Farsi keyboard mapping
" 24  'hkmap'           'hk'      Hebrew keyboard mapping
" 24  'hkmapp'          'hkp'     phonetic Hebrew keyboard mapping
" 24  'imactivatefunc'  'imaf'    function to enable/disable the X input method
" 24  'imcmdline'       'imc'     use IM when starting to edit a command line
" 24  'imdisable'       'imd'     do not use the IM in any mode
" 24  'iminsert'        'imi'     use :lmap or IM in Insert mode
" 24  'imsearch'        'ims'     use :lmap or IM when typing a search pattern
" 24  'imstatusfunc'    'imsf'    function to obtain X input method status
" 24  'isfname'         'isf'     characters included in file names and pathnames
" 24  'isident'         'isi'     characters included in identifiers
" 24  'iskeyword'       'isk'     characters included in keywords
" 24  'isprint'         'isp'     printable characters
" 24  'keymap'          'kmp'     name of a keyboard mapping
" 24  'langmap'         'lmap'    alphabetic characters for other language mode
" 24  'langnoremap'     'lnr'     do not apply 'langmap' to mapped characters
" 24  'quoteescape'     'qe'      escape characters used in a string
" 24  'revins'          'ri'      inserting characters will work backwards
" 24  'rightleft'       'rl'      window is right-to-left oriented
" 24  'rightleftcmd'    'rlc'     commands for which editing works right-to-left
" 24  'termbidi'        'tbidi'   terminal takes care of bi-directionality
" }}}
" 25  multi-byte characters {{{
" 25  'ambiwidth'       'ambw'    what to do with Unicode chars of ambiguous width
" 25  'charconvert'     'ccv'     expression for character encoding conversion
" 25  'delcombine'      'deco'    delete combining characters on their own
" 25  'encoding'        'enc'     encoding used internally
set encoding=utf-8
" 25  'fileencoding'    'fenc'    file encoding for multi-byte text
" 25  'fileencodings'   'fencs'   automatically detected character encodings
" 25  'imactivatekey'   'imak'    key that activates the X input method
" 25  'maxcombine'      'mco'     maximum nr of combining characters displayed
" 25  'termencoding'    'tenc'    character encoding used by the terminal
" }}}
" 26  various {{{
" 26  'bufhidden'       'bh'      what to do when buffer is no longer in window
" 26  'buflisted'       'bl'      whether the buffer shows up in the buffer list
" 26  'buftype'         'bt'      special type of buffer
" 26  'debug'                     set to "msg" to see all error messages
" 26  'edcompatible'    'ed'      toggle flags of ":substitute" command
" 26  'eventignore'     'ei'      autocommand events that are ignored
" 26  'exrc'            'ex'      read .vimrc and .exrc in the current directory
set exrc
" 26  'gdefault'        'gd'      the ":substitute" flag 'g' is default on
" 26  'loadplugins'     'lpl'     load plugin scripts when starting up
" 26  'maxfuncdepth'    'mfd'     maximum recursive depth for user functions
" 26  'secure'                    secure mode for reading .vimrc in current dir
set secure
" 26  'sessionoptions'  'ssop'    options for :mksession
" 26  'viewdir'         'vdir'    directory where to store files with :mkview
" 26  'viewoptions'     'vop'     specifies what to save for :mkview
" 26  'viminfo'         'vi'      use .viminfo file upon startup and exiting
set viminfo=
" 26  'virtualedit'     've'      when to use virtual editing
set virtualedit+=block
" }}}
" }}}
" MAIN2 ------------------------------------------------------------------- {{{

syntax enable

" }}}
" ABBREVS ----------------------------------------------------------------- {{{

inoreabbrev <expr> #!! "#!/usr/bin/env" . (empty(&filetype) ? '' : ' '.&filetype)

" }}}
" MAPPINGS ---------------------------------------------------------------- {{{

let mapleader=','
let maplocalleader='\\'

nnoremap <leader>s vip:!sort<cr>
vnoremap <leader>s :!sort<cr>

nnoremap vaa ggvGg_
nnoremap Vaa ggVG

noremap <silent> <leader><space> :noh<cr>:call clearmatches()<cr>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <S-tab> <c-w>W
nnoremap <leader>v <C-w>v
nnoremap <tab> <c-w>w

noremap gj j
noremap gk k
noremap j gj
noremap k gk

cnoremap        <C-A> <Home>
cnoremap        <C-B> <Left>
cnoremap <expr> <C-D> getcmdpos()>strlen(getcmdline())?"\<Lt>C-D>":"\<Lt>Del>"
cnoremap <expr> <C-F> getcmdpos()>strlen(getcmdline())?&cedit:"\<Lt>Right>"
cnoremap        <C-N> <Down>
cnoremap        <C-P> <Up>
cnoremap        <M-b> <S-Left>
cnoremap        <M-f> <S-Right>
silent! execute "set <S-Left>=\<Esc>b"
silent! execute "set <S-Right>=\<Esc>f"

imap <silent> <up>       <nop>
imap <silent> <down>     <nop>
imap <silent> <left>     <nop>
imap <silent> <right>    <nop>
imap <silent> <home>     <nop>
imap <silent> <end>      <nop>
imap <silent> <pageup>   <nop>
imap <silent> <pagedown> <nop>
imap <silent> <c-home>   <nop>
imap <silent> <c-end>    <nop>
imap <silent> <del>      <nop>
nmap <silent> <up>       <nop>
nmap <silent> <down>     <nop>
nmap <silent> <left>     <nop>
nmap <silent> <right>    <nop>
nmap <silent> <home>     <nop>
nmap <silent> <end>      <nop>
nmap <silent> <pageup>   <nop>
nmap <silent> <pagedown> <nop>
nmap <silent> <c-home>   <nop>
nmap <silent> <c-end>    <nop>
nmap <silent> <del>      <nop>
vmap <silent> <up>       <nop>
vmap <silent> <down>     <nop>
vmap <silent> <left>     <nop>
vmap <silent> <right>    <nop>
vmap <silent> <home>     <nop>
vmap <silent> <end>      <nop>
vmap <silent> <pageup>   <nop>
vmap <silent> <pagedown> <nop>
vmap <silent> <c-home>   <nop>
vmap <silent> <c-end>    <nop>
vmap <silent> <del>      <nop>

" }}}
" MISC -------------------------------------------------------------------- {{{

augroup misc " {{{
    autocmd!

    " Highlight and strip trailing tabs and spaces
    " http://stackoverflow.com/questions/356126/how-can-you-automatically-remove-trailing-whitespace-in-vim
    autocmd BufWinEnter,BufNewFile,BufRead,InsertLeave * silent! match ExtraWhitespace /\s\+$/
    autocmd InsertEnter * silent! match ExtraWhitespace /\s\+\%#\@<!$/
    autocmd BufWritePre * :%s/\s\+$//e
augroup END " }}}

" }}}
" FILETYPES --------------------------------------------------------------- {{{
" AWK {{{

augroup ft_awk
    autocmd!
    autocmd BufNewFile,BufEnter *.awk setlocal filetype=awk
    autocmd FileType awk setlocal noexpandtab foldmethod=syntax shiftwidth=4 softtabstop=0 tabstop=4 cindent
augroup END

" }}}
" C {{{

augroup ft_c
    autocmd!
    autocmd BufNewFile,BufEnter *.c setlocal filetype=c
    autocmd FileType c setlocal noexpandtab foldmethod=syntax shiftwidth=8 softtabstop=8 tabstop=8 colorcolumn=80 commentstring=//\ %s cindent
augroup END

" }}}
" C# {{{

augroup ft_cs
    autocmd!
    autocmd BufNewFile,BufEnter *.cs setlocal filetype=cs
    autocmd FileType cs setlocal expandtab foldmethod=syntax shiftwidth=4 softtabstop=4 tabstop=4 colorcolumn=100 commentstring=//\ %s
augroup END

" }}}
" css {{{

augroup ft_css
    autocmd!
    autocmd BufNewFile,BufRead *.css setlocal filetype=css
    autocmd FileType css setlocal expandtab foldmethod=syntax shiftwidth=2 softtabstop=2 tabstop=2 colorcolumn=80
augroup END

" }}}
" html {{{

augroup ft_html
    autocmd!
    autocmd BufNewFile,BufRead *.html setlocal filetype=html
    autocmd FileType html setlocal expandtab foldmethod=syntax shiftwidth=2 softtabstop=2 tabstop=2 colorcolumn=80
augroup END

" }}}
" Java {{{

augroup ft_java
    autocmd!
    autocmd BufNewFile,BufEnter *.java setlocal filetype=java
    autocmd FileType java setlocal expandtab foldmethod=syntax shiftwidth=2 softtabstop=2 tabstop=2 colorcolumn=100 commentstring=//\ %s
augroup END

" }}}
" JavaScript {{{

augroup ft_javascript
    autocmd!
    autocmd BufNewFile,BufEnter *.js setlocal filetype=javascript
    autocmd FileType javascript setlocal expandtab foldmethod=syntax shiftwidth=2 softtabstop=2 tabstop=2 colorcolumn=80 commentstring=//\ %s
augroup END

" }}}
" Json {{{

augroup ft_json
    autocmd!
    autocmd BufNewFile,BufEnter *.json setlocal filetype=json
    autocmd FileType json setlocal expandtab foldmethod=syntax shiftwidth=2 softtabstop=2 tabstop=2 colorcolumn=80 commentstring=
augroup END

" }}}
" Markdown {{{

augroup ft_markdown
    autocmd!
    autocmd BufNewFile,BufRead *.m\(ark\|\)d\(own\|\) setlocal filetype=markdown
    autocmd FileType markdown setlocal expandtab shiftwidth=4 softtabstop=0 tabstop=4
augroup END

" }}}
" Pandoc {{{

augroup ft_markdown.pandoc
    autocmd!
    autocmd BufNewFile,BufRead *.mkd setlocal filetype=markdown.pandoc
    autocmd FileType markdown.pandoc setlocal expandtab shiftwidth=4 softtabstop=0 tabstop=4
augroup END

" }}}
" PHP {{{

let g:PHP_vintage_case_default_indent = 1
let g:PHP_noArrowMatching = 1
let php_parent_error_close = 1

augroup ft_php
    autocmd!
    autocmd BufNewFile,BufEnter *.php setlocal filetype=php
    autocmd FileType php setlocal expandtab foldmethod=syntax shiftwidth=4 softtabstop=4 tabstop=4 colorcolumn=80 commentstring=//\ %s makeprg=parallel-lint\ --colors\ --no-progress\ -j\ 1\ %
augroup END

" }}}
" Python {{{

augroup ft_python
    autocmd!
    autocmd BufNewFile,BufEnter *.py setlocal filetype=python
    autocmd FileType python setlocal expandtab foldmethod=syntax colorcolumn=88
augroup END

" }}}
" Shell {{{

let b:sh_indent_options = {}
let b:sh_indent_options['case-breaks'] = 0
let b:sh_indent_options['case-labels'] = 4
let b:sh_indent_options['case-statements'] = 4
let b:sh_indent_options['continuation-line'] = 4
let b:sh_indent_options['default'] = 4
let b:sh_indent_options['pipe-line'] = 4

" let g:is_posix = 1
let g:sh_fold_enabled = 3

augroup ft_sh
    autocmd!
    autocmd BufNewFile,BufEnter *.{da,mk}sh setlocal filetype=sh
    autocmd FileType sh setlocal noexpandtab foldmethod=syntax makeprg=shellcheck\ -f\ gcc\ % shiftwidth=4 softtabstop=0 tabstop=4
augroup END

" }}}
" SQL {{{

augroup ft_sql
    autocmd!
    autocmd BufNewFile,BufEnter *.sql setlocal filetype=sql
    autocmd FileType sql setlocal expandtab foldmethod=syntax shiftwidth=4 softtabstop=0 tabstop=4 colorcolumn=80 commentstring=--\ %s
augroup END

" }}}
" Tex {{{

augroup ft_tex
    autocmd!
    autocmd BufNewFile,BufRead *.lco setlocal filetype=tex
augroup END

" }}}
" xml {{{

augroup ft_xml
    autocmd!
    autocmd BufNewFile,BufRead *.xml setlocal filetype=xml
    autocmd FileType xml setlocal expandtab foldmethod=syntax shiftwidth=4 softtabstop=4 tabstop=4 colorcolumn=80
augroup END

" }}}
" Yaml {{{

augroup ft_yaml
    autocmd!
    autocmd BufNewFile,BufEnter *.yaml setlocal filetype=yaml
    autocmd FileType yaml setlocal expandtab foldmethod=syntax shiftwidth=2 softtabstop=2 tabstop=2 colorcolumn=80 commentstring=
augroup END

" }}}
" COLOR ------------------------------------------------------------------- {{{

let g:solarized_contrast="normal"
let g:solarized_visibility="normal"

if filereadable($XDG_RUNTIME_DIR . '/DAYLIGHT') == 1
    set background=light
else
    set background=dark
endif

colorscheme solarized

call togglebg#map("<F5>")

augroup color_solarized
    autocmd!
    autocmd BufWritePost solarized.vim color solarized
augroup END


" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

highlight Specialkey term=NONE cterm=NONE gui=NONE ctermbg=NONE guibg=NONE
highlight CursorLineNr term=NONE cterm=NONE gui=NONE ctermbg=NONE guibg=NONE
highlight ExtraWhitespace ctermbg=red guibg=red

" }}}
" PLUGINS ----------------------------------------------------------------- {{{
" Commentary {{{

nmap <leader>c <Plug>CommentaryLine
xmap <leader>c <Plug>Commentary

" }}}
" Fzf {{{

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let g:fzf_layout = { 'down': '~40%' }

let g:fzf_buffers_jump = 1

let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" }}}
" markdown {{{

let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_initial_foldlevel = &foldlevelstart

" }}}
" pandoc {{{
let g:pandoc#filetypes#handled = ["pandoc"]
let g:pandoc#filetypes#pandoc_markdown = 0

let g:pandoc#biblio#bib_extensions = ["bib"]
let g:pandoc#biblio#use_bibtool = 1

let g:pandoc#completion#bib#mode = 'citeproc'

let g:pandoc#folding#fold_yaml = 1
let g:pandoc#folding#fold_fenced_codeblocks = 1

let g:pandoc#toc#position = "left"

let g:pandoc#spell#enabled = 0

let g:pandoc#hypertext#preferred_alternate = "mkd"
let g:pandoc#hypertext#autosave_on_edit_open_link = 1

" }}}
" }}}

" vim:et foldmethod=marker foldlevel=0 shiftwidth=4 softtabstop=0 tabstop=4 :
