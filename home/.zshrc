# ===== zsh common config =====

autoload -Uz compinit
compinit
PROMPT='%F{blue}%~%f %# '
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

# JDK 21 and Kotlin
export JAVA_HOME="$HOME/.local/opt/jdk-21"
export PATH="$HOME/.local/bin:$HOME/.local/opt/kotlinc/bin:$JAVA_HOME/bin:$PATH"
# ===== WezTerm layouts =====
wezterm-layout() {
  local cwd="${1:-$PWD}"

  WEZTERM_LAYOUT=1 wezterm start \
    --always-new-process \
    --cwd "$cwd" >/dev/null 2>&1 &!
}
