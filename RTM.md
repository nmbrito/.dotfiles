# VIM
## Mappings
### Function keys
   ```   
    inoremap <F1>                   <C-X><Tab>                                              # F1  # Insert mode, opens vim omnicompletion
    nnoremap <silent><F2>           :Files<CR>                                              # F2  # Normal mode, toggle fzf file search in the working directory
    nnoremap <silent><S-F2>         :Files %:p:h<CR>                                        # F2  # Normal mode, toggle fzf file search in the same file directory
    nnoremap <silent><F3>           :Goyo<CR>                                               # F3  # Normal mode, toggle Goyo
    nnoremap <silent><F4>           :UndotreeToggle<CR>                                     # F4  # Normal mode, toggle Undotree
    nnoremap <F5>                   :w!<CR>                                                 # F5  # Normal mode, quick save
    nnoremap <leader><F5>           :wq!<CR>                                                # F5  # Normal mode, quick save and quit
    nnoremap <silent><F6>           :Buffers<CR>                                            # F6  # Normal mode, normal mode, search buffers (! for fullscreen)
    nnoremap <F7>                   :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>     # F7  # Normal mode, remove all trailing whitespace by pressing F5
    nnoremap <S-F11>                :mksession! $VIMSESSIONS/current_session.vim<CR>        # F11 # Normal mode, save current session
    nnoremap <leader><S-F11>        :source $VIMSESSIONS/current_session.vim<CR>            # F11 # Normal mode, load current session
    nnoremap <silent><F12>          :sp $DOTDIR/vimrc_help.md<CR>                           # F12 # Normal mode, normal mode, opens this mappings file

    :command -nargs=1 Mksw          :mks! $VIMSESSIONS/<args>.vim                           # Command mode, saves session to a custom file name
    :command -nargs=1 Mksl          :source $VIMSESSIONS/<args>.vim                         # Command mode, loads a session name with a custom file name
   ```   

### Colorschemes quick change
   ```   
    nnoremap <silent><leader>cs     :colorscheme slate<CR>
    nnoremap <silent><leader>cj     :colorscheme jellybeans<CR>
    nnoremap <silent><leader>cm     :colorscheme molokai<CR>
   ```   
    
### fzf-vim - Fuzzy Finder
   ```   
    nnoremap <silent>gf             :GFiles<CR>                         # Normal mode, search git tracked files through fzf
    ------------------------------------------------------------------> # Pressing C-x opens the file in a horizontal split buffer
    ------------------------------------------------------------------> # Pressing C-v opens the file in a vertical split buffer
    ------------------------------------------------------------------> # Tab selects
    ------------------------------------------------------------------> # S-Tab selects all
    ------------------------------------------------------------------> # ? toggles preview
    nnoremap <silent>gc             :Commits<CR>                        # Normal mode, search commited git through fzf
    nnoremap <silent>//             :BLines<CR>                         # Normal mode, search current buffer file through fzf
    nnoremap <silent>f//            :BLines!<CR>                        # Normal mode, search current buffer file through fzf in fullscreen
    nnoremap <silent>a//            :Lines<CR>                          # Normal mode, search all buffers files through fzf
    ------------------------------------------------------------------> # Pressing C-T pastes selected files or directories onto the command line (Tab selects)
    ------------------------------------------------------------------> # Pressing C-R pastes the selected command from history onto the command line
    ------------------------------------------------------------------> # Pressing A-C changes directory into the selected directory
    ------------------------------------------------------------------> # :Commands :History :Maps :Filetypes :Commits :BCommits
   ```   
    
### Buffers
   ```   
    nnoremap <leader><PageUp>       :bprevious<CR>                      # Normal mode, previous buffer
    nnoremap <leader><PageDown>     :bnext<CR>                          # Normal mode, next buffer
    nnoremap <leader><Delete>       :bdelete<CR>                        # Normal mode, close buffer and keep anything related to them
    nnoremap <leader><C-Delete>     :bdelete<space>                     # Normal mode, close buffer(s) by number or filename and keep anything related to them
    ------------------------------------------------------------------> # Extra: press home to input buffer range, e.g.: 2,5bdelete
    nnoremap <leader><S-Delete>     :bwipeout<CR>                       # Normal mode, close buffer but wipe everything related
    ------------------------------------------------------------------> # :buffers opens the default VIM buffer
   ```   

### Split buffers
   ```   
    nnoremap <leader>h              :sp<CR>                             # Normal mode, split horizontal
    nnoremap <leader>v              :vsp<CR>                            # Normal mode, split vertical
    nnoremap <leader>H              :sb                                 # Normal mode, split horizontal, enter buffer name or number and open
    nnoremap <leader>V              :vert sb                            # Normal mode, split vertical, enter buffer name or number and open
   ```   

### Moving in windows/sanely
   ```   
    nnoremap <C-h> <C-w>h                                               # Normal mode, left
    nnoremap <C-j> <C-w>j                                               # Normal mode, down
    nnoremap <C-k> <C-w>k                                               # Normal mode, up
    nnoremap <C-l> <C-w>l                                               # Normal mode, right
    nnoremap <C-H> <C-w>H                                               # Normal mode, switch split left
    nnoremap <C-J> <C-w>J                                               # Normal mode, switch split down
    nnoremap <C-K> <C-w>K                                               # Normal mode, switch split up
    nnoremap <C-L> <C-w>L                                               # Normal mode, switch split right
    nnoremap <C-r> <C-w>r                                               # Normal mode, rotate split
   ```   

### Increase/decrease windows/splits size
   ```   
    nnoremap L <C-w><                                                   # Normal mode, vertical increase
    nnoremap J <C-w>+                                                   # Normal mode, horizontal increase
    nnoremap K <C-w>-                                                   # Normal mode, horizontal decrease
    nnoremap H <C-w>>                                                   # Normal mode, vertical decrease
   ```   
    
### VIM Omnicompletion
   ```   
    inoremap <C-j> <C-N>                                                # Insert mode, next in the list
    inoremap <C-k> <C-P>                                                # Insert mode, previous in the list
   ```   

### Toggles
   ```   
    nnoremap <leader>rp     :RainbowParentheses!!                       # Normal mode, toggles rainbow parentheses
    nnoremap <leader>ws     :ToggleWhitespace                           # Normal mode, toggles better whitespace
    nnoremap <leader>wss    :ToggleStripWhitespaceOnSave                # Normal mode, toggles better whitespace strip on save
    ------------------------------------------------------------------> # <leader>ig :IndentGuidesToggle # Toggles indent guides default mapping
   ```   

### QoL
   ```
    nnoremap <Leader>d "_d                                              # Normal mode, delete and don't store in reg
    vnoremap <Leader>d "_d                                              # Visual mode, delete and don't store in reg
    nnoremap <Leader>c "_c                                              # Normal mode, change and don't store in reg
    vnoremap <Leader>c "_c                                              # Visual mode, change and don't store in reg
    nnoremap <Up> kzz                                                   # Normal mode, go up and re-center screen
    nnoremap <Down> jzz                                                 # Normal mode, go down and re-center screen
    vnoremap <Alt-j> :m '>+1<CR>gv=gv                                   # Visual mode, move the selected block down
    vnoremap <Alt-k> :m '>-2<CR>gv=gv                                   # Visual mode, move the selected block up


   ```

### Brackets [disabled]
   ```   
    inoremap "          ""<left>                                        # Insert mode, inserts "" pressing only "
    inoremap '          ''<left>                                        # Insert mode, inserts '' pressing only '
    inoremap (          ()<left>                                        # Insert mode, inserts () pressing only (
    inoremap [          []<left>                                        # Insert mode, inserts [] pressing only [
    inoremap {          {}<left>                                        # Insert mode, inserts {} pressing only {
    inoremap {<CR>      {<CR>}<ESC>O                                    # Insert mode, inserts {} block pressing only {
    inoremap {;<CR>     {<CR>};<ESC>O                                   # Insert mode, inserts {}; block pressing only {;
   ```   

## Default useful motions / commands
   ```   
    <C-t>                           # Insert mode, tab
    <C-d>                           # Insert mode, detab
    ZZ                              # Save and exit
    ZQ                              # Exit without saving
    g <C-a>                         # Magic? Use visual block <C-v> then <S-i> starting number and exit. Use gv to re-select previous area. Press START_NUMBERg <C-a>

    :reg                            # Show registers
    "x ->motion                     # Select register where 'x' is a number or letter

    :put range(initial,ending)      # Prints numbers in lines

    " NAME  ------------- {{        # Fold Lines (another curly bracket at the end)
    " Content below                 # Fold Lines
    " }}                            # Fold Lines
    " NAME {{1                      # This single line works too, 1 is the fold level number
    zo                              # Open a single fold under the cursor.
    zc                              # Close the fold under the cursor.
    za                              # Toggle fold
    zr                              # Open next fold level
    zR                              # Open all folds.
    zm                              # Close next fold level
    zM                              # Close all folds.
    zf ->motion direction           # Create fold

    vimdiff file1 file2
    ]c                              # Next change
    [c                              # Previous change
    do                              # Diff obtain
    dp                              # Diff put
    :diffupdate                     # Rescan files

    :mksession[!] [name.vim]        # Saves session in current directory, [!] overwrites file
    $ vim -S [name.vim]             # Restore session from terminal
    :source name.vim                # Restore session from vim

    :'<,'>sort                      # Sorts visual selected block text
    :NUMBER,/match/s                # Replace from NUMBER to next match (it can also be match to match)
    :NUMBER,?match?s                # Replace from NUMBER to previous match (it can also be match to match)
    :NUMBER,$s                      # Replace from NUMBER to end of file. The 's' can also be replaced with 'd' or 'y'.
    :NUMBER,.s                      # Replace from NUMBER to current line. The 's' can also be replaced with 'd' or 'y'.
    :-RLN,+RLNs                     # Replace from relative line number to relative line number where minus is above and plus is below current line

    :bufdo command | update         # Run a command across all buffers. Update saves each buffer (optional).
   ```   

# TMUX
## Quick manual:
### Sessions
   ```   
    : new                                   # New session
    : new -s session_name                   # New session named
    : prefix s                              # Show sessions
    : prefix $                              # Rename session

    : tmux kill-session -t session_name     # Kill/delete session
    : tmux kill-session -a session_name     # Kill/delete all but current session

    : prefix d                              # Detach from session

    : tmux a                                # Attach last session
    : tmux at
    : tmux attach
    : tmux attach-session

    : tmux a -t session_name                # Attach to named session
    : tmux at   session_name
    : tmux attach session_name
    : tmux attach-session session_name

    : prefix w                              # Session and window preview
    : prefix (                              # Previous session
    : prefix )                              # Next session
   ```   

### Windows
   ```   
    : prefix c                              # Create window
    : tmux new -n window_name

    : prefix ,                              # Rename current window
    : prefix &                              # Close current window
    : prefix w                              # List windows
    : prefix p                              # Previous window
    : prefix n                              # Next window
    : prefix 0...9                          # Switch/select window
    : prefix l                              # Toggle last active window

    : swap-window -s 2 -t 1                 # Reorder window, swap window number 2(src) and 1(dst)
    : swap-window -t -1                     # Move current window to the left by one position
    ```   

### Panes
   ```   
    : prefix ;                              # Toggle last active pane
    : prefix %                              # Split pane with horizontal layout
    : prefix "                              # Split pane with vertical layout
    : prefix {                              # Move the current pane left
    : prefix }                              # Move the current pane right
    : prefix up                             # Switch to pane to the direction
    : prefix down
    : prefix left
    : prefix right

    : prefix Spacebar                       # Toggle between pane layouts
    : prefix o                              # Switch to next pane
    : prefix q                              # Show pane numbers
    : prefix q 0...9                        # Switch/select pane by number
    : prefix z                              # Toggle pane zoom
    : prefix !                              # Convert pane into a window
    : prefix + up                           # Resize current pane height(holding second key is optional)
    : prefix Ctrl + up
    : prefix + down
    : prefix Ctrl + down
    : prefix + right                        # Resize current pane width(holding second key is optional)
    : prefix Ctrl + right
    : prefix + left
    : prefix Ctrl + left
    : prefix x                              # Close current pane
   ```   

### Others
   ```   
    : prefix :                  # Enter command mode
    : list-keys                 # Help
    : prefix ?
    : tmux info                 # Info
   ```   

    tmux new -n tmux-helper && vim ~/.dotfiles/tmux_help.md

    -g -> global
    -n -> don't use prefix
    -r -> allow multiple commands to be entered without pressing the prefix key
    -a -> value appends to existing setting (similar to an AND)
    M = alt

    Reload config file
    bind r source-file ~/.config/tmux/tmux.conf

# VIFM
    TODO!

# Powerline Symbols

|       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       | ⏽      |       |
| ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ |
| \uE0B0 | \uE0B2 | \uE0B3 | \uE0B1 | \uE0   | \uE0   | \uE0   | \uE0   | \uE0   | \uE0   | \uE0   | \uE0   | \uE0   | \uE0   | \uE0   | \uE0   | \uE0   | \uE0   | \uE0   | \uE0   |

|       |       |       |       |       |       |       |       |       |       |       |       |       |       |       |       | ⏻      | ⏼      | ⏾      | EMPTY  |
| ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ |
| \uE0B0 | \uE0   | \uE0   | \uE0   | \uE0   | \uE0   | \uE0   | \uE0   | \uE0   | \uE0   | \uE0   | \uE0   | \uE0   | \uE0   | \uE0   | \uE0   | \uE0   | \uE0   | \uE0   | \uE0   |

# Other Useful Stuff
   ```   
    git remote set-url origin urlHTTPS or urlSSH
    ssh-add ~/path/private_key

    Recovering SSH key:
        chmod 700 ~/.ssh
        chmod 600 ~/.ssh/rsa*
   ```   

