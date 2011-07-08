# Keep only unique items in path, moving them when necessary
typeset -U path
path=(/usr/local/bin /usr/local/sbin /usr/local/share/python $path)
