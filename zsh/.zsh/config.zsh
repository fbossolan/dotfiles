# options, history, autocomplete, prompt and keybindings
# sourced by zshrc

# ==========================================
# 1. CORE SETTINGS & HISTORY
# ==========================================
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000

# Better history handling
setopt APPEND_HISTORY       # Don't overwrite history
setopt SHARE_HISTORY        # Share history between terminal windows
setopt HIST_IGNORE_DUPS     # Don't store duplicate lines
setopt HIST_IGNORE_SPACE    # Don't store commands starting with a space

# Enable colors for ls
export CLICOLOR=1
export LSCOLORS=ExGxFxDxCxDxDxhbadexex

# ==========================================
# 2. THE COMPLETE AUTOCOMPLETE SYSTEM
# ==========================================
autoload -Uz compinit && compinit

# Enable the arrow-key menu selection
zstyle ':completion:*' menu select

# Group completions by category (files, directories, etc)
zstyle ':completion:*' group-name ''
zstyle ':completion:*:*:*:*:descriptions' format '%F{147}-- %d --%f'

# Case-insensitive completion (type 'cd down' for 'Downloads')
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Highlight the selection in Lavender (147) with black text
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" 'ma=48;5;147;38;5;0'

# ==========================================
# 3. PROMPT & VISUALS
# ==========================================
setopt prompt_subst
autoload -Uz vcs_info
precmd() { vcs_info }

# Catppuccin Mocha Colors (approximate)
# Blue: 111, Pink: 212, Green: 115, Red: 210, Lavender: 147

# Git branch formatting
zstyle ':vcs_info:git:*' formats '%F{115}⎇ (%b)%f '

# Logic for the Checkmark / Cross
# %(?.success_text.fail_text)
INDICATOR="%(?.%F{115}✓%f.%F{210}✘%f)"

# Final Prompt Construction
# [Check/Cross] [Directory] [Git Branch] $
PROMPT='${INDICATOR} %F{111}%~ %F{115}${vcs_info_msg_0_}%f%F{147}$%f '

# ==========================================
# 5. LIGHTWEIGHT KEYBINDINGS
# ==========================================
bindkey -e                        # Use Emacs-style keys (Ctrl+A to start, ctrl e to end, ctrl u delete entire line)
bindkey '^[[A' up-line-or-search  # Arrow up searches history
bindkey '^[[B' down-line-or-search # Arrow down searches history
