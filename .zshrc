#
#           _____                    _____                    _____          
#          /\    \                  /\    \                  /\    \         
#         /::\____\                /::\    \                /::\____\        
#        /:::/    /               /::::\    \              /::::|   |        
#       /:::/    /               /::::::\    \            /:::::|   |        
#      /:::/    /               /:::/\:::\    \          /::::::|   |        
#     /:::/____/               /:::/__\:::\    \        /:::/|::|   |        
#    /::::\    \              /::::\   \:::\    \      /:::/ |::|   |        
#   /::::::\    \   _____    /::::::\   \:::\    \    /:::/  |::|   | _____  
#  /:::/\:::\    \ /\    \  /:::/\:::\   \:::\    \  /:::/   |::|   |/\    \ 
# /:::/  \:::\    /::\____\/:::/  \:::\   \:::\____\/:: /    |::|   /::\____\
# \::/    \:::\  /:::/    /\::/    \:::\  /:::/    /\::/    /|::|  /:::/    /
#  \/____/ \:::\/:::/    /  \/____/ \:::\/:::/    /  \/____/ |::| /:::/    / 
#           \::::::/    /            \::::::/    /           |::|/:::/    /  
#            \::::/    /              \::::/    /            |::::::/    /   
#            /:::/    /               /:::/    /             |:::::/    /    
#           /:::/    /               /:::/    /              |::::/    /     
#          /:::/    /               /:::/    /               /:::/    /      
#         /:::/    /               /:::/    /               /:::/    /       
#         \::/    /                \::/    /                \::/    /        
#          \/____/                  \/____/                  \/____/         
#
#   2023. 08. 31
#

# Return if not interactive
[[ -o interactive ]] || return

# Completion
autoload -Uz compinit
compinit

# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

setopt append_history
setopt share_history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt inc_append_history
setopt auto_cd
setopt correct
setopt no_beep

# Colors
autoload -Uz colors
colors

if command -v dircolors >/dev/null 2>&1; then
  if [[ -f ~/.dir_colors ]]; then
    eval "$(dircolors -b ~/.dir_colors)"
  elif [[ -f /etc/DIR_COLORS ]]; then
    eval "$(dircolors -b /etc/DIR_COLORS)"
  fi
fi

alias ls='ls --color=auto'
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'

# Window title
case "$TERM" in
  xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*)
    precmd() {
      print -Pn "\e]0;%n@%m:%~\a"
    }
    ;;
  screen*)
    precmd() {
      print -Pn "\ek%n@%m:%~\e\\"
    }
    ;;
esac

# Allow root GUI apps locally
xhost +local:root > /dev/null 2>&1

# Extract archives
ex() {
  if [[ -f "$1" ]]; then
    case "$1" in
      *.tar.bz2) tar xjf "$1" ;;
      *.tar.gz)  tar xzf "$1" ;;
      *.bz2)     bunzip2 "$1" ;;
      *.rar)     unrar x "$1" ;;
      *.gz)      gunzip "$1" ;;
      *.tar)     tar xf "$1" ;;
      *.tbz2)    tar xjf "$1" ;;
      *.tgz)     tar xzf "$1" ;;
      *.zip)     unzip "$1" ;;
      *.Z)       uncompress "$1" ;;
      *.7z)      7z x "$1" ;;
      *)         echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# lf file manager cd helper
lfcd() {
  local tmp dir
  tmp="$(mktemp)"

  command lf -last-dir-path="$tmp" "$@"

  if [[ -f "$tmp" ]]; then
    dir="$(cat "$tmp")"
    rm -f "$tmp"

    if [[ -d "$dir" && "$dir" != "$PWD" ]]; then
      cd "$dir"
    fi
  fi
}

alias nav='lfcd'
alias vim='nvim'
alias vmm='vim main.tex'
alias wifi='nmtui'
alias bluetooth='bluetoothctl'
alias volume='pulsemixer'
alias calc='calcurse'
alias pgrep='pdfgrep -HiR --color=auto'

alias newterm='st >/dev/null 2>&1 & disown'
alias arxivpdf='process-arxiv-pdf'
alias monitor='xrandr --output eDP --off'
alias monitor-on='xrandr --output eDP --right-of HDMI-A-0 --auto'

git_update() {
  local update_msg="${1:-Update}"
  git add .
  git commit -m "$update_msg"
}
alias gitu='git_update'

git_update_note() {
  local file_name update_msg

  file_name="$(grep -oiP '\\textbf{\\huge\s*\K(.*?)(?=\})' main.tex | sed 's/\s/_/g')"

  cp main.pdf "../$file_name.pdf"
  cp main.pdf "/home/han/Han/SyncNotes/$file_name.pdf"

  update_msg="${1:-Update}"
  git add .
  git commit -m "$update_msg"
}
alias gitnu='git_update_note'

export EDITOR='nvim'
export VISUAL='nvim'
export BROWSER='qutebrowser'

# # Rust/Cargo
# [[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# Local bin environment
[[ -f "$HOME/.local/bin/env" ]] && source "$HOME/.local/bin/env"

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

autoload -Uz vcs_info

precmd() {
    vcs_info
}

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats ' %F{magenta}(%b)%f'

setopt PROMPT_SUBST

PROMPT='%F{green}[%n@%F{yellow}x%F{red}y%F{cyan}z%f${vcs_info_msg_0_}%F{green}]$%f '

[[ -f ~/.ls_colors ]] && export LS_COLORS="$(cat ~/.ls_colors)"
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# Vi mode
bindkey -v

# Open current command line in $EDITOR with Esc + v
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line
