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

  # 左上：nvim
  local nvim_pane
  nvim_pane=$(wezterm cli spawn \
    --new-window \
    --cwd "$cwd" \
    -- nvim)

  # 左下：ターミナル
  wezterm cli split-pane \
    --pane-id "$nvim_pane" \
    --bottom \
    --percent 35 \
    --cwd "$cwd" \
    -- zsh -l

  # 右側：チャット用ペイン
  wezterm cli split-pane \
    --pane-id "$nvim_pane" \
    --right \
    --top-level \
    --percent 38 \
    --cwd "$cwd" \
    -- zsh -l
}
