# personal reminder
alias reminder='cat ~/.config/shell/reminder.sh'

# OTP number
alias otp='echo R.FNRS.5060-0-F'

alias grep='grep --color=auto'
alias ls='lsd'

# aliases for folders
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -l'

# shortcuts 
alias ..='cd ..'
alias ..="cd .."
alias ...="cd ../../"
alias ....="cd ../../../"

alias gc='cd ~/.config/'
alias gd='cd ~/Downloads/'
alias gp='cd ~/pictures/'

# to send something into the clipboard more easily
# alias clip='xclip -selection clipboard'
alias clip='wl-copy'
# and paste it
# alias pst='xclip -o -sel clip'
alias pst='wl-paste'
# to open files
alias open='xdg-open &>/dev/null'
# when copying, moving, and removing files
alias cp='cp -vi'
alias mv='mv -vi'
alias rm='rm -vi'
# count files in the current folder
alias count="ls | wc -l"
# display calendar
alias cal="cal -m"

# Force ncmpcpp to use sane bindings
alias ncm="ncmpcpp -b ~/.config/ncmpcpp/bindings"
