# aliases and small shell functions
# sourced by zshrc

# ==========================================
# 4. HELPFUL ALIASES
# ==========================================
alias tat="tmux attach -t "
alias vim="nvim"
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias gst="git status"
alias gb="git branch"
alias sbp="source ~/.bash_profile"
alias ntc="nvim ~/.tmux.conf"
alias szc="source ~/.zshrc"
alias nzc="nvim ~/.zshrc"
alias ncf="nvim ~/.config/nvim/init.lua"
alias szc="source ~/.zshrc"
alias nbp="nvim ~/.bash_profile"
alias ls="ls -G"      # Colorize ls (use --color on Linux, -G on macOS)
alias ll="ls -lah"
alias ..="cd .."
alias ...="cd ../.."
alias gmc='git fetch origin && \
[ -z "$(git status --porcelain)" ] || { echo "Uncommitted changes"; exit 1; } && \
git merge-base --is-ancestor origin/develop HEAD && \
echo "OK to merge" || \
echo "Rebase or merge develop first"'

alias gcb="git branch | fzf | cut -c 3- | xargs git checkout"
alias drv='cd "$HOME/Library/CloudStorage/GoogleDrive-flavio.bossolan@mercadolivre.com/Meu Drive"'
alias rn="ranger"
alias ghist="git log --oneline --graph --decorate --all"

# functions
gpush() {
  branch=$(git branch --show-current)
  git push origin $branch
  echo "pushing to $branch"
}

gpull() {
  branch=$(git branch --show-current)
  git pull origin $branch
}

gdiff(){
    branch=$(git branch --show-current)
    git difftool origin/$branch
}


