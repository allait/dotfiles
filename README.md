dotfiles
========

These are my config files. Mostly for `vim`, `zsh` and `git`. I don't expect them to be of much
use to anyone except myself, however there are some scripts, snippets and utilities that might be
usefull and I'll try to list them below in "Features".

Compatibility
-------------

These should work on Mac OS X 10.6. Most of the scripts should work on Linux systems as is, but I've
stopped purposefully making them compatible some time ago. Since there are differences in bultin BSD
and Linux tools, some of the zsh functions aren't expected to work properly.

Installation
------------

Clone the repository to any folder:

    git clone git://github.com/allait/dotfiles ~/Dotfiles
    cd ~/Dotfiles

Launch automatic installation (`ruby` and `rake` are required for this step):

    rake install

This will backup all existing files from `~/` to `~/.old/` and replace them with symlinks to files
inside your local repository clone, pull all external plugins and render `*.erb` templates for
config files, requiring personal information.

To uninstall and restore files from `~/.old` run `rake uninstall` from repository folder.

Features
--------

* Support for ERB templates instead of plain files
* Support for joining files from different parts, depending on the current system:
  e.g. `*.local.darwin` for OS X specific options and `*.local.linux` for Linux specific.
* Rake tasks to automate some environment setup tasks
* Fabric task to install bare bones versions of config files on remote servers

### Vim
* `syntastic.vim` syntax checkers for erlang
* New color scheme: `prefect.vim`
* Some snippets for `UltiSnips`: python, puppet, sql and more
* Extended javascript completion with support for jQuery and underscore.js

### Rake tasks
* `install_pip_tools` to install python packages from `requirements.txt`
* `install_macvim` to build macvim with current python version
