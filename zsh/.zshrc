# secrets live in ~/.secrets (outside this repo)
[[ -f ~/.secrets ]] && source ~/.secrets

# AUTOSUGGESTIONS: grey ghost text from history
# install once: brew install zsh-autosuggestions
# → or End accepts, Ctrl+→ accepts one word, ESC clears the current suggestion
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=244'
ZSH_AUTOSUGGEST_STRATEGY=(history)
KEYTIMEOUT=1 # ESC is a prefix key; without this it lags before firing
[[ -r /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^[' autosuggest-clear

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"


# fzf
source <(fzf --zsh) 

source ~/.bash_profile


# Added by Python Dev Environment Installer
export HOMEBREW_BIN_LOCATION="/opt/homebrew/bin"
export PATH="$HOMEBREW_BIN_LOCATION:$PATH"

# split configs managed by Stow under ~/.zsh
source "$HOME/.zsh/config.zsh"
source "$HOME/.zsh/aliases.zsh"
