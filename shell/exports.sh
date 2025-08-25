#!/bin/sh

# favorite editor
export EDITOR="nvim" 

# set default printer
export PRINTER="print_ULiege"

# ls after cd into a directory
# export PROMPT_COMMAND='[[ ${__new_wd:=$PWD} != $PWD ]] && ls; __new_wd=$PWD'

export DMENU_BLUETOOTH_LAUNCHER="fuzzel"

# those need to be explicit
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CONFIG_HOME=$HOME/.config
export XDG_STATE_HOME=$HOME/.local/state
export XDG_CACHE_HOME=$HOME/.cache
export HISTFILE="${XDG_STATE_HOME}"/bash/history
export MANPAGER='nvim +Man!'

# for fzf, will ignore hidden folders/files
export FZF_ALT_C_COMMAND="fd --type d --exclude '.*'"
export FZF_CTRL_T_COMMAND="fd --type f --exclude '.*'"

# required for rstudio
export PATH=$PATH:/usr/lib/rstudio/rstudio
export PATH=$PATH:$HOME/.local/bin/
# for cargo
export PATH=$PATH:$HOME/.cargo/bin/

export PF_SOURCE="${HOME}/.config/pfetch/pfetchrc"
