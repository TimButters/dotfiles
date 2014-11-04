dotfiles
========

Configuration files for basic Linux tools such as BASH, ZSH, vim, etc.

These are my personal configuration files for a variety of tools. 
You are welcome to use them, although there is no guarantee that they are any good!


bashrc
------
This provides basic bash configuration setting the desktop environment variable to 'openbox' and the editor variable to vim. There is a customised colour prompt and useful aliases defined.


zshrc
-----
This configures zshell with the same settings used in bash plus some extras. The prompt includes information about any git repository in the current directory using vcs_info.


screenrc
--------
Basic GNU Screen configuration that sets the terminal to a 256-colour variant with the shell set to zshell.


Xresources
----------
Customisation for xterm and urxvt enabling true transparency for urxvt (requires compositing).


vimrc & vim
-----
Configuration for vim enabling syntax highlighting, various settings for source code files with language specific options. Some plugins are required:
- Syntastic
- Ctrl-P
- NERDTree
- vim-latexsuite

Appropriate colour schemes are included in the vim folder.

