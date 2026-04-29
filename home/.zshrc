# ===== zsh common config =====

autoload -Uz compinit
compinit
PROMPT='%F{green}%n@%m%f:%F{blue}%~%f %# '

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt append_history
setopt share_history
setopt hist_ignore_dups
setopt hist_ignore_space

alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias grep='grep --color=auto'

codexdev() {
  codex -s workspace-write -C "$PWD" "$@"
}

# ===== 端末ごとに異なる設定は以下のファイルに記述する =====
[ -f ~/.zsh_local ] && source ~/.zsh_local
