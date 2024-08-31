if status is-interactive
    # Commands to run in interactive sessions can go here
end

# ALIASES
alias cat bat

# Functions
#function n
#    if test -f $argv[1]; 
#        cd "$(dirname $argv[1])" 
#        nvim "$(basename $argv[1])"
#    else if test -d $argv[1];
#        cd "$argv[1]" && nvim $(find . -type f | fzf --height 40% )
#    end
#end


# Settings
set -gx COLORTERM truecolor
set -gx EDITOR nvim
set -U fish_greeting ""
set -gx HISTCONTROL ignorespace

# ENV VARS

set -gx FZF_CTRL_R_OPTS "--preview 'echo {}' --preview-window up:3:hidden:wrap --bind 'ctrl-/:toggle-preview' --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort' --color header:italic --header 'Press CTRL-Y to copy command into clipboard'"

set -gx FZF_DEFAULT_OPTS "--layout=reverse --inline-info --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 --border=\"rounded\" --border-label=\"\" --preview-window=\"border-rounded\" --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

set -gx FZF_ALT_C_OPTS "--walker-skip .git,node_modules,target --preview 'tree -C {}'"

set -gx EZA_COLORS "uu=0:gu=0"
if test -f ~/.ls_colors
    set -gx LS_COLORS (cat ~/.ls_colors)
end

# Shell integrations
eval (fzf --fish)
eval (zoxide init fish)

# pnpm
set -gx PNPM_HOME "/home/neon/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
