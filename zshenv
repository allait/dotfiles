# Keep only unique items in path, moving them when necessary
typeset -U path
path=(/usr/local/share/python /usr/local/bin /usr/local/sbin $path)
