# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# source what we need to improve our bash user experience
source $HOME/.config/shell/to_include.sh

# include bash history every time we open a new terminal
HISTFILE=$HOME/.bash_history

# case-insensitive autocompletion
bind "set completion-ignore-case on"

# for fzf
eval "$(fzf --bash)"

# cd into directory just by typing its name
shopt -s autocd

# default zoxide to cd
eval "$(zoxide init --cmd cd bash)"

# run fastfetch 
echo -e && pfetch

# change display name in terminal
export PS1='\[\033[0;31m\]\w 
\[\033[0;34m\]❯ \[\033[0;33m\]'

# required for julia
case ":$PATH:" in
    # *:/home/benjamin/.juliaup/bin:*)
    *:~/.juliaup/bin:*)
        ;;

    *)
        export PATH=~/.juliaup/bin${PATH:+:${PATH}}
        ;;
esac

# Start ssh-agent if not running
eval "$(ssh-agent -s)" >/dev/null
ssh-add -q ~/.ssh/id_ed25519 2>/dev/null || true
