# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.

export PATH=$PATH:/opt/homebrew/bin
export PATH=/usr/local/bin:$PATH
export ABBR_QUIET=1
export EDITOR="nvim"
export XDG_CONFIG_HOME=${HOME}/.config
#################################  HISTORY  #################################
# history
HISTFILE=$HOME/.zsh_history     # 履歴を保存するファイル
HISTSIZE=100000                 # メモリ上に保存する履歴のサイズ
SAVEHIST=1000000                # 上述のファイルに保存する履歴のサイズ

# highlight_color
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=244"

# share .zshhistory
setopt inc_append_history       # 実行時に履歴をファイルにに追加していく
setopt share_history            # 履歴を他のシェルとリアルタイム共有する

setopt hist_ignore_all_dups     # ヒストリーに重複を表示しない
setopt hist_save_no_dups        # 重複するコマンドが保存されるとき、古い方を削除する。
setopt extended_history         # コマンドのタイムスタンプをHISTFILEに記録する
setopt hist_expire_dups_first   # HISTFILEのサイズがHISTSIZEを超える場合は、最初に重複を削除します

## コマンド履歴検索
function peco-history-selection() {
  BUFFER=`history -n 1 | tac  | awk '!a[$0]++' | peco`
  CURSOR=$#BUFFER
  zle reset-prompt
}
zle -N peco-history-selection
bindkey '^R' peco-history-selection

# enable completion
autoload -Uz compinit; compinit

autoload -Uz colors; colors

# Tabで選択できるように
zstyle ':completion:*:default' menu select=2

# 補完で大文字にもマッチ
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ファイル補完候補に色を付ける
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# 非同期gitプロンプトを無効にする
zstyle ':omz:alpha:lib:git' async-prompt no

# ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash

# カッコを自動補完
setopt auto_param_keys

# ファイル名の展開でディレクトリにマッチした場合 末尾に / を付加
setopt mark_dirs

# 補完キー連打で順に補完候補を自動で補完
setopt auto_menu

# スペルミス訂正
setopt correct

# コマンドラインでも # 以降をコメントと見なす
setopt interactive_comments

# コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt magic_equal_subst

# 語の途中でもカーソル位置で補完
setopt complete_in_word

# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# ディレクトリ名だけでcdする
setopt auto_cd

# ビープ音を消す
setopt no_beep

# コマンドを途中まで入力後、historyから絞り込み
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

#/を単語区切りにする
autoload -Uz select-word-style
select-word-style bash
WORDCHARS='.-'

# >>> zsh-completions setting >>>

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
  source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  autoload -Uz compinit && compinit
fi

# <<< zsh-completions setting <<<


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/tutaya/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/tutaya/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/tutaya/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/tutaya/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH

# pnpm
export PNPM_HOME="/Users/tutaya/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm enid
export PATH="$HOME/bin:$PATH"

# Added by Antigravity
export PATH="/Users/tutaya/.antigravity/antigravity/bin:$PATH"

# コマンドが存在するか確認する関数
_has() {
  type "$1" > /dev/null 2>&1
}

## starship prompt
if _has starship; then
  eval "$(starship init zsh)"
fi

# Sheldonで管理しているプラグインを読み込む
if _has sheldon; then
  eval "$(sheldon source)"
fi

if [ -f "$HOME/dotfiles/zsh/aliases.zsh" ]; then
  source "$HOME/dotfiles/zsh/aliases.zsh"
fi
export PATH="$HOME/.cargo/bin:$PATH"

# ログインボーナスの実行
# Neovim内蔵ターミナルの場合はディレクトリ移動を避ける、
# またはサブシェル ( ) を使って元のディレクトリを保持する
if [[ -z "$NVIM" ]]; then
  (cd ~/login_bonus_for_shell && python logger.py)
fi

# ghq
function ghq-fzf() {
  local src=$(ghq list | fzf --preview "bat --color=always --style=header,grid --line-range :80 $(ghq root)/{}/README.*")
  if [ -n "$src" ]; then
    BUFFER="cd $(ghq root)/$src"
    zle accept-line
  fi
  zle -R -c
}
zle -N ghq-fzf
bindkey '^g' ghq-fzf
export PATH="/Users/tutaya/.config/herd-lite/bin:$PATH"
export PHP_INI_SCAN_DIR="/Users/tutaya/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"
