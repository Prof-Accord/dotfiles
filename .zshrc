### zsh本体の設定

# エイリアス
## ls
alias ls='ls --color=auto'
alias ls='ls -G'
alias ll='ls -alF'
alias ll='ls -lh'
alias ll='ls -l'
alias la='ls -A'
alias la='ls -a'
alias l='ls -CF'
## git
alias g='git'
alias ga='git add'
alias gd='git diff'
alias gs='git status'
alias gp='git push'
alias gb='git branch'
alias gco='git checkout'
alias gf='git fetch'
alias gc='git commit'
# bundle
alias b='bundle'
alias be='bundle exec'
alias bi='bundle install'
alias bo='bundle outdated'
alias bu='bundle update'
alias rc='bundle exec rails c'

### zsh-completionsで補完機能をより強力にする
# 他のzshと履歴を共有
setopt inc_append_history
# 同時に起動しているzshの間でhistoryを共有する
setopt share_history
# historyに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks
# 同じコマンドをhistoryに残さない
setopt hist_ignore_all_dups
# 文字コードを指定v
export LANG=ja_JP.UTF-8
# 日本語ファイル名を表示可能にする
setopt print_eight_bit
# cd無しでもディレクトリ移動
setopt auto_cd
# cd -で以前移動したディレクトリを表示
setopt auto_pushd
# コマンドのスペルをミスして実行した場合に候補を表示
setopt correct
# 履歴の保存先ファイル指定
HISTFILE=~/.zsh_history
# メモリに保存される履歴の件数
export HISTSIZE=1000
# 履歴ファイルに保存される履歴の件数
export SAVEHIST=10000

# 補完機能
autoload -Uz compinit && compinit

# 小文字でも大文字にマッチ
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' '+m:{A-Z}={a-z}'

# 補完候補をTabや矢印で選択可能
zstyle ':completion:*:default' menu select=1

# lsコマンドで色分けする
zstyle ':completion:*' list-colors $LSCOLORS

### Zinitの設定
### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi
source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

# シンタックスハイライト
zinit light zsh-users/zsh-syntax-highlighting

# 入力補完
zinit light zsh-users/zsh-autosuggestions

# サジェストの色変更
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=244"

# 標準でサポートされていないコマンド用の補完
zinit light zsh-users/zsh-completions

# Ctrl+r でコマンド履歴を検索
zinit light zdharma/history-search-multi-word

# ターミナルを256色使用可能にする
zinit light chrissicool/zsh-256color

# pecoやpercolのラッパー
zinit light mollifier/anyframe

### pecoの設定
# コマンド履歴検索 ctrl+r
function peco-history-selection() {
  BUFFER=`history -n 1 | tac  | awk '!a[$0]++' | peco`
  CURSOR=$#BUFFER
  zle reset-prompt
}
zle -N peco-history-selection
bindkey '^R' peco-history-selection

# コマンド履歴からディレクトリ検索・移動 ctrl+e
if [[ -n $(echo ${^fpath}/chpwd_recent_dirs(N)) && -n $(echo ${^fpath}/cdr(N)) ]]; then
  autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
  add-zsh-hook chpwd chpwd_recent_dirs
  zstyle ':completion:*' recent-dirs-insert both
  zstyle ':chpwd:*' recent-dirs-default true
  zstyle ':chpwd:*' recent-dirs-max 1000
  zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/chpwd-recent-dirs"
fi
function peco-cdr () {
 local selected_dir="$(cdr -l | sed 's/^[0-9]* *//' | peco)"
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
}
zle -N peco-cdr
bindkey '^E' peco-cdr

# カレントディレクトリ以下のディレクトリ検索・移動 ctrl+x
function find_cd() {
  local selected_dir=$(find . -type d | peco)
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
}
zle -N find_cd
bindkey '^X' find_cd


if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit
fi

### 重複パスを登録しない
typeset -U path PATH

#### rbenvを初期化するためのスクリプト
eval "$(rbenv init - zsh)"

### starship初期化するためのスクリプト
eval "$(starship init zsh)"
