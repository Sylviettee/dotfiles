# Atuin is used for history
fc -p

# Use Emacs-style bindings
# <C>-E = end
# <C>-A = home
bindkey -e

fpath=(
  $HOME/.zsh/completions
  $fpath
)

zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit

# Variables
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.go/bin:$PATH"
export EDITOR="nvim"
export GOPATH="$HOME/.go"

# Check for tools

source "$HOME/.zsh/fetch/fetch.zsh"
check-tool eza bat starship atuin zoxide carapace direnv

# Aliases
alias ls="eza --group-directories-first"
alias la="ls -lah"
alias cat="bat -pp"

# Tools
eval "$(starship init zsh)"
eval "$(atuin init zsh)"
eval "$(zoxide init zsh --cmd cd)"
eval "$(direnv hook zsh)"

# these tools are annoying to automatically install
if command -v batpipe >/dev/null 2>&1; then
  eval "$(batpipe)"
fi

if command -v batman >/dev/null 2>&1; then
  eval "$(batman --export-env)"
fi

if [ -f /usr/share/doc/pkgfile/command-not-found.zsh ]; then
  source /usr/share/doc/pkgfile/command-not-found.zsh
fi

if [ -f /etc/zsh_command_not_found ]; then
  source /etc/zsh_command_not_found
fi

if [ -f /usr/share/nvm/init-nvm.sh ]; then
  source /usr/share/nvm/init-nvm.sh
fi

if [ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
else
  source "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

if [ -f /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh ]; then
  source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
else
  source "$HOME/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
fi

zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace)
