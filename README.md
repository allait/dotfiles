dotfiles
========

My config files for `vim`, `zsh`, `pentadactyl`, `git` and other shell tools. I don't expect them to
be of much use to anyone except myself, however there are some scripts, snippets and utilities that
might be useful and I'll try to list them below.

Features
--------

* Files are organized into separate folders, each representing a stand-alone component. Each component
  can define special installation rules in its own Rakefile, as well as add new rake tasks
* Support for ERB templates instead of plain files
* Support for joining files from different parts, depending on the current system and installation
  type: e.g. `*.local.darwin` for local OS X specific options and `*.remote.linux` for remote Linux
  installation
* Support for partial installation
* Rake and fabric tasks to automate local and remote environment setup

### Vim
* New color scheme: `prefect.vim`
* Some snippets for `UltiSnips`: python, puppet, SQL and more
* Extended javascript completion with support for jQuery and underscore.js

### ZSH
* Custom prompt with current mercurial/git branch name and status flags
* New completion function for `curl`
* Wrapper function `t` for taskwarrior

### Git
* `git l` and `git gl` show git log in custom one-line format
* `git dfm` shows diff using Mac OS X FileMerge

### Pentadactyl
* New color scheme: `light.penta`
* New plugins to send current URL and selection to Delibar, Twitterrific or The Hit List

### iTerm
* New color scheme: `Prime.itermcolors`

### Rake and fabric tasks
* `rake python:install_pip_tools` install python packages from `python/requirements.txt`
* `rake vim:macvim` build MacVim with current python version
* `fab install_remote_dotfiles` build dotfiles and copy them to remote machine
* `fab upload_ssh_key` append `~/.ssh/id_rsa.pub` to remote `authorized_keys`

Installation
------------

Clone the repository to any folder:

    git clone git://github.com/allait/dotfiles ~/Dotfiles
    cd ~/Dotfiles

Launch automatic installation (`ruby` and `rake` are required for this step):

    rake install

This will backup all existing files from `~/` to `~/.backup` and replace them with symlinks to files
inside your local repository clone, pull all external plugins and render `*.erb` templates for
config files, requiring personal information.

### Default installation process
Load existing component Rakefiles, using component name as surrounding rake namespace.
Run `git pull`, initialize and update git submodules. For each component:

1. Invoke `<component>:install` task (defined as `task :install` in `<component>/Rakefile`) if present

Or, if `<component>:install` is not defined:

1. Render all `*.erb` templates
2. Concatenate each file with `*.local` and `*.local.<current-system>` if any. Current system is
   determined using `uname -s` result, converted to lowercase.
3. Symlink/copy files from `<component>/name` to `~/.name`

### Custom installation
You can change installation process with `ENV` variables, either setting them before invoking `rake
install`, or passing `key=value` pairs as rake arguments. The following `ENV` variables can be used:

* `HOME=/path/ rake install` install to `/path/` instead of user home directory
* `rake install skip=pull` skip `git pull` and git submodule update during installation
* `rake install components=vim,git,web` installs only selected components
* `rake install remote=linux` performs installation appending `*.remote.linux` files instead of
  `*.local.<system>`

Each component can customize its installation process by defining `:install` and `:uninstall` rake
tasks in its own Rakefile. If present, these tasks will be invoked during installation instead of
the default process.

### Removal
To uninstall and restore files from `~/.backup` run `rake uninstall` from repository folder.

Compatibility
-------------

These should work on Mac OS X 10.6 - 10.7. Most of the scripts should work on Linux systems as is, but I've
stopped purposefully making them compatible some time ago. Since there are differences in BSD and
Linux coreutils, some of the zsh functions and plugins aren't expected to work properly.
