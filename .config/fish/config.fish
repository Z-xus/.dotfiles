if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Settings
set -gx COLORTERM truecolor
set -gx EDITOR nvim
set -U fish_greeting ""
set -gx HISTCONTROL ignorespace

# ENV VARS

#set -gx FZF_CTRL_R_OPTS "--preview 'echo {}' --preview-window up:3:hidden:wrap --bind 'ctrl-/:toggle-preview' --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort' --color header:italic --header 'Press CTRL-Y to copy command into clipboard'"
#set -gx FZF_DEFAULT_OPTS "--layout=reverse --inline-info --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 --border=\"rounded\" --border-label=\"\" --preview-window=\"border-rounded\" --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
#set -gx FZF_ALT_C_OPTS "--walker-skip .git,node_modules,target --preview 'tree -C {}'"
#set -gx EZA_COLORS "uu=0:gu=0"
#if test -f ~/.ls_colors
#    set -gx LS_COLORS (cat ~/.ls_colors)
#end

# Bind C-f to trigger tmux-sessionizer
bind \cf 'tmux-sessionizer; commandline -f repaint'

# History
#set -U fish_history 5000
#set -U fish_history_file ~/.local/share/fish/fish_history

# Exports
set -Ux EDITOR nvim
set -Ux LANG en_US.UTF-8
set -Ux COLORTERM truecolor

set -Ux FZF_CTRL_R_OPTS "
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

set -Ux FZF_DEFAULT_OPTS "--layout=reverse --inline-info \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--border='rounded' --border-label='' --preview-window='border-rounded' \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

set -Ux FZF_ALT_C_OPTS "--walker-skip .git,node_modules,target \
--preview 'tree -C {}'"

set -Ux EZA_COLORS "uu=0:gu=0"
if test -f ~/.ls_colors
    set -Ux LS_COLORS (cat ~/.ls_colors)
end

# Aliases
# alias n 'nvim'
alias ff 'firefox'
alias nv 'neovide'
alias ssha 'eval (ssh-agent) && ssh-add'
alias l 'eza -a --icons=auto'
alias ls 'eza -lh --icons=auto --color-scale-mode=gradient'
alias lt 'eza -T -L 2 --git --git-ignore --icons=auto'
alias ll 'eza -lha --icons=auto --sort=name --group-directories-first'
alias cat 'bat'
alias yls "yadm ls | awk -F/ '{ if (NF==1) {print \$0} else if (!seen[\$1\"/\"\$2]) {print \$1\"/\"\$2\"/\"; seen[\$1\"/\"\$2] = 1} }'"
alias yst 'yadm status'

# Functions
function yup
    if test -z "$argv[1]" -o -z "$argv[2]"
        echo "Usage: yup <file> <commit msg>"
    else
        yadm add $argv[1]
        yadm commit -m $argv[2]
    end
end

function t
    if tmux has-session -t work >/dev/null 2>&1
        TERM=xterm-256color tmux -u attach-session -t work
    else
        TERM=xterm-256color tmux -u new-session -s work
    end
end

function gpp
    if test -z "$argv[1]"
        echo "Usage: gpp <filename>"
    else
        g++ -std=c++17 -O2 -Wall -Wextra -Wshadow -D_GLIBCXX_DEBUG -DLOCAL -o a.out $argv[1] && ./a.out
    end
end

function rm
    for arg in $argv
        if test $arg = "/" -o $arg = $HOME
            echo "Error: Attempt to remove root or home directory. Aborting."
            return 1
        end
    end

    if not test -d "$HOME/Trash"
        mkdir -p "$HOME/Trash"
    end

    for file in $argv
        if not string match -r "^-" $file
            if test -e "$file"
                mv $file "$HOME/Trash/"
            else
                echo "Warning: '$file' not found."
            end
        end
    end
end

function proj
    set dir (find (or $argv[1] .) -type d | fzf --height 40% --reverse)
    if test -n "$dir"
        set dir (realpath "$dir")
        command code "$dir" &>/dev/null &
        command nv "$dir" &>/dev/null &

        sleep 0.7
        i3-msg '[class="Code"] move right'

        if not set -q TMUX
            t
        end
        tmux send-keys "cd '$dir'" C-m
    else
        echo "No directory selected."
    end
end

# Shell integrations
#fzf_key_bindings
#fzf_cd

#eval (zoxide init fish)

if not set -q DISPLAY; and test (tty) = "/dev/tty1"
    exec startx &>/dev/null
end

#if not set -q DISPLAY -a (tty) = "/dev/tty1"
#    exec startx &>/dev/null
#end

set -Ux GIT_TERMINAL_PROMPT 1

# PNPM
set -Ux PNPM_HOME "/home/neon/.local/share/pnpm"
if not contains $PNPM_HOME $PATH
    set -Ux PATH $PNPM_HOME $PATH
end

# Shell integrations
fzf --fish | source
zoxide init fish | source
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH
