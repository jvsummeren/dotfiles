# Prevent accidental execution from non-zsh shells
if [ -z "$ZSH_VERSION" ]; then
  echo "ERROR: This file is intended for zsh only"
  echo "Attempted from: $0:$LINENO"
  return 1 2>/dev/null || exit 1
fi

ZIM_HOME=~/Development/dotfiles/.zim
# Install missing modules and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZIM_CONFIG_FILE:-${ZDOTDIR:-${HOME}}/.zimrc} ]]; then
  source /opt/homebrew/opt/zimfw/share/zimfw.zsh init
fi

export ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# SSH in prompt
zstyle ':completion:*' use-cache on
zstyle ':completion:*' hosts $(awk '/^Host / {for (i=2; i<=NF; i++) if ($i !~ "[*?]") print $i}' ~/.ssh/config)

# Initialize modules
source ${ZIM_HOME}/init.zsh

# Load modular files (if they exist)
for file in ~/.{path,exports,aliases,aliases-macos,functions,extra}; do
  [ -r "$file" ] && source "$file"
done
unset file

# Zsh options
setopt AUTO_CD              # Type a directory name = cd into it
setopt CORRECT              # Suggest spelling corrections for commands
setopt EXTENDED_GLOB        # More powerful pattern matching
setopt HIST_IGNORE_DUPS     # Ignore duplicate entries in history
setopt NO_BEEP              # Disable beep sound on errors
setopt HIST_REDUCE_BLANKS   # Remove extra spaces in history entries
setopt SHARE_HISTORY        # Share history across multiple sessions

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# Locale
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Import zoxide
eval "$(zoxide init zsh)"