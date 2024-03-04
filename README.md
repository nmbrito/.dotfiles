# personal dotfiles

## install script
Deploys a full system configuration.
   ```   
    $ cd ~/.dotfiles/INSTALL/v2/
    $ chmod u+x setup.sh
    $ sh setup.sh
   ```   

The setup runs a set of functions:
1. run all: runs all commands below
2. host fixes: if there's something to apply a fix
3. repositories: add's distros repos
4. packages: reads from package.sh and installs
5. fonts: downloads the fonts in package.sh from nerdfonts repo
6. symlinks: symlinks various configs and copies plasma configs
7. configure git globals: unecessary
8. sync git submodules: pulls repositories as submodules
9. link vim helptags: links helptags
10. change to zsh shell: changes to zsh

## info
| configs       | vim plugins           | zsh plugins                   |
| :------------ | :-------------------- | :---------------------------- |
| mc            | css-color             | powerlevel10k                 |
| neofetch      | fzf                   | zsh-autosuggestions           |
| plasma        | fzf.vim               | zsh-syntax-highlighting       |
| strawberry    | goyo.vim              | git.plugin.zsh                |
| tmux          | limelight.vim         | colored-man-pages.plugin.zsh  |
| vifm          | surround              |                               |
| vim           | undotree              |                               |
| vscode        | vim-airline           |                               |
| zsh           | vim-airline-themes    |                               |
|               | vim-better-whitespace |                               |
|               | vim-highlighedyank    |                               |
|               | vim-indent-guides     |                               |
|               | vimspector            |                               |

