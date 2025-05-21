# ~/.zshrc

# Load modular files (if they exist)
for file in ~/.{path,exports,aliases,aliases-macos,functions,extra}; do
  [ -r "$file" ] && source "$file"
done
unset file

# Completion & history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# Locale
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Prompt
[[ -o login ]] || exec zsh -l
autoload -Uz promptinit && promptinit
zstyle ':completion:*' use-cache on
zstyle ':completion:*' hosts $(awk '/^Host / {for (i=2; i<=NF; i++) if ($i !~ "[*?]") print $i}' ~/.ssh/config)

# Private
[ -f ~/.zsh_private ] && source ~/.zsh_private