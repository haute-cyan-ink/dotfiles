# ls -> eza
abbr ls='eza --icons --group-directories-first'
abbr la='eza -lAG --icons --group-directories-first'
abbr ll='eza -lG --icons --group-directories-first'

# clear
abbr c='clear'
abbr cc='clear &&'

# cat
abbr cat='bat --paging=never'

# nvim
abbr v='nvim'

# google search
function google() {
  local query=$(echo "$@" | sed 's/ /+/g')
  open "https://www.google.com/search?q=${query}"
}

# lazygit
abbr -S -qq lg='lazygit'

# pnpm
abbr pd='pnpm dev'
abbr pi='pnpm install'
