# source what we need to improve our user experience
source $HOME/.config/shell/to_include.sh
source $HOME/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/.config/zsh/prompt

# run fastfetch 
echo -e && pfetch

autoload -Uz vcs_info # enable vcs_info
precmd () { vcs_info } # always load before displaying the prompt
zstyle ':vcs_info:*' formats ' %s(%F{blue}%b%f)' # git(main)

setopt prompt_subst
setopt autocd extendedglob nomatch menucomplete
setopt interactive_comments
autoload -Uz colors && colors
autoload -Uz +X compinit && compinit

## case insensitive path-completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select

# going back to history
bindkey "^k" history-beginning-search-backward
bindkey "^j" history-beginning-search-forward
bindkey -v

function zle-keymap-select () {
    case $KEYMAP in 
        vicmd) echo -ne '\e[1 q' ;; # block
        viins|main) echo -ne '\e[5 q' ;; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins
    echo -ne "\e[5 q"
}
zle -N zle-line-init

# include bash history every time we open a new terminal
HISTFILE=~/.config/zsh/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory

# for fzf
eval "$(fzf --zsh)"

# default zoxide to cd
eval "$(zoxide init --cmd cd zsh)"

# Start ssh-agent if not running
eval "$(ssh-agent -s)" >/dev/null
ssh-add -q ~/.ssh/id_ed25519 2>/dev/null || true

