# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi


# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Keybindings
bindkey -e
export KEYTIMEOUT=1
# bindkey '^p' history-search-backward
# bindkey '^n' history-search-forward
# bindkey '^[w' kill-region

bindkey -s ^f "tmux-sessionizer\n"

# Add in zsh plugins
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions


# Add in snippets
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
# zinit snippet OMZP::git
# zinit snippet OMZP::aws
# zinit snippet OMZP::kubectl
# zinit snippet OMZP::kubectx
# zinit snippet OMZP::command-not-found

# Load completions
fpath+=~/.zfunc
autoload -Uz compinit && compinit
zinit cdreplay -q

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
export HISTIGNORE="tgpt*:$HISTIGNORE"
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Select text

if [[ -z "$TMUX" ]]; then
    shift-arrow() {
      ((REGION_ACTIVE)) || zle set-mark-command
      zle $1
    }
    shift-left()  shift-arrow backward-char
    shift-right() shift-arrow forward-char
    shift-up()    shift-arrow up-line-or-history
    shift-down()  shift-arrow down-line-or-history
    zle -N shift-left
    zle -N shift-right
    zle -N shift-up
    zle -N shift-down

    bindkey $terminfo[kLFT] shift-left
    bindkey $terminfo[kRIT] shift-right
    bindkey $terminfo[kri]  shift-up
    bindkey $terminfo[kind] shift-down
fi

# Exports
export EDITOR='nvim'
export LANG='en_US.UTF-8'
export COLORTERM='truecolor'
export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

export FZF_DEFAULT_OPTS="--layout=reverse --inline-info \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--border=\"rounded\" --border-label="" --preview-window=\"border-rounded\" \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'tree -C {}'"

export EZA_COLORS="uu=0:gu=0"
if [ -f ~/.ls_colors ]; then
    export LS_COLORS=$(< ~/.ls_colors)
fi


bindkey '\t' autosuggest-accept
bindkey '^I'   complete-word
bindkey '^[[Z' autosuggest-accept

# Aliases
alias n='nvim'
alias lg='lazygit'
alias gacp='git aa && git ci && git push'
alias copy='xclip -selection clipboard'
alias ff='firefox'
alias nv='neovide . & disown'
alias ssha='eval $(ssh-agent) && ssh-add'
alias l='eza -a --icons=auto'
alias ls='eza -lh --icons=auto --color-scale-mode=gradient'
alias lt='eza -T -L 2 --git --git-ignore --icons=auto'
alias ll='eza -lha --icons=auto --sort=name --group-directories-first'
# alias ld='eza -lhD --icons=auto'
alias cat='bat'
alias send='curl -F "file=@$1" 0x0.st'
alias receive='curl -o $1 0x0.st/$1'
alias yls="yadm ls | awk -F/ '{ if (NF==1) {print \$0} else if (!seen[\$1\"/\"\$2]) {print \$1\"/\"\$2\"/\"; seen[\$1\"/\"\$2] = 1} }'"
alias yst="yadm st"
alias cl='calcure 2> /dev/null'
alias bt='bluetoothctl'
alias ..='cd ..'
alias ...='cd ../..'
alias .~='cd ~'

# Movement
# Bind Alt+Left to move backward by word
bindkey '^[[1;3D' backward-word
# Bind Alt+Right to move forward by word
bindkey '^[[1;3C' forward-word


# Functions

mkcd() {
  mkdir -p "$1" && cd "$1"
}

yup() {
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo "Usage: yup <file> <commit msg>"
    fi
    yadm add "$1"
    yadm commit -m "$2"
}

t() {
    if tmux has-session -t work 2>/dev/null; then
        TERM=xterm-256color tmux -u attach-session -t work
    else
        TERM=xterm-256color tmux -u new-session -s work
    fi
}

gpp() {
    if [ -z "$1" ]; then
        echo "Usage: run_cpp <filename>"
        return 1
    fi
    g++ -std=c++23 -O2 -Wall -Wextra -Wshadow -D_GLIBCXX_DEBUG -DLOCAL -o a.out "$1" && ./a.out
    # g++ -std=c++17 -O2 -Wall -Wextra -Wshadow -D_GLIBCXX_DEBUG -DLOCAL -o a.out "$1" && ./a.out
    # g++ -std=c++17 -O2 -D_GLIBCXX_DEBUG -DLOCAL -o a.out "$1" && ./a.out
}

# proj() {
#   local dir
#   dir=$(find ${1:-.} -type d -printf '%p\n' 2> /dev/null | fzf --height 40% --reverse)
#   dir=$(realpath "$dir")
#   if [[ -n "$dir" ]]; then
#     # Launch VS Code and Neovide before tmux
#     code "$dir"
#     nv "$dir" & > /dev/null 2>&1
#     sleep 1
#     i3-msg '[class="neovide"] move down'
#     i3-msg '[class="Code"] move right'
#     if [[ -z "$TMUX" ]]; then
#       echo 'HERE'
#       t # If not already in a tmux session, create a new one
#     fi
#   else
#     echo "No directory selected."
#   fi
# }

# rm() {
#     # Prevent deletion of root and home directories
#     for arg in "$@"; do
#         if [ "$arg" = "/" ] || [ "$arg" = "$HOME" ]; then
#             echo "Error: Attempt to remove root or home directory. Aborting."
#             return 1
#         fi
#     done
#
#     # Create Trash directory if it doesn't exist
#     [ ! -d "$HOME/Trash" ] && mkdir -p "$HOME/Trash"
#
#     # Separate options from file/directory names
#     local files=()
#
#     for arg in "$@"; do
#         if [[ "$arg" != -* ]]; then
#             files+=("$arg")
#         fi
#     done
#
#     # Move files and directories to Trash
#     for file in "${files[@]}"; do
#         if [ -e "$file" ]; then
#             mv "$file" "$HOME/Trash/"
#         else
#             echo "Warning: '$file' not found."
#         fi
#     done
# }

proj() {
  local dir
  dir=$(find "${1:-.}" -type d -printf '%p\n' 2> /dev/null | fzf --height 40% --reverse)
  dir=$(realpath "$dir")
  if [[ -n "$dir" ]]; then
    # Launch VS Code and Neovide before tmux
    (code "$dir" &> /dev/null &) &
    (nv "$dir" &> /dev/null &) &

    # Wait for the windows to appear before moving them
    sleep 0.7
    # i3-msg '[class="neovide"] move down'
    i3-msg '[class="Code"] move right'

    if [[ -z "$TMUX" ]]; then
      echo 'HERE'
      t # If not already in a tmux session, create a new one
    fi
    tmux send-keys "cd '$dir'" C-m
    # clear
  else
    echo "No directory selected."
  fi
}

# Shell integrations
eval "$(fzf --zsh)"
# source <(fzf --zsh)
eval "$(zoxide init --cmd cd zsh)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
  exec startx &> /dev/null
fi

export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
export PATH=~/.local/scripts:$PATH
export PATH=~/.local/bin:$PATH

# Blockchain foundry
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
export PATH="$PATH:/home/neon/.foundry/bin"

# Chromium
export PATH="${HOME}/Projects/chromium/depot_tools:$PATH"

# Flutter
export PATH="$PATH:$HOME/development/flutter/bin"
export ANDROID_SDK_ROOT="$HOME/Android"
export PATH="$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools:$PATH"

# export ANDROID_HOME=$HOME/Android/Sdk
# export PATH=$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$PATH

export PATH="$HOME/.cargo/bin:$PATH"

export WORDCHARS=${WORDCHARS//[\/]}
export GIT_TERMINAL_PROMPT=1

# pnpm
export PNPM_HOME="/home/neon/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
export PATH=/home/neon/.meteor:$PATH

# PATHS:

# export GOROOT=/usr/local/go
# export GOPATH=/home/neon/College/bct/lab-2a
# export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"
export PATH="$GOROOT/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Load Angular CLI autocompletion.
source <(ng completion script)
[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh
