# History configuration
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000

# Ignore all duplicates
setopt hist_ignore_all_dups

# Don't autoexecute command found with history search
setopt hist_verify

# Each session will append to history each command
setopt inc_append_history

# Each session has access to other's history
setopt share_history

# Save commands with timestamps
setopt extended_history

# Delete duplicates when size limit reached
setopt hist_expire_dups_first

# Don't save commands starting with space
setopt hist_ignore_space

# Perform ! history expansion
setopt bang_hist
