# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source $HOME/.profile


export HONDA_WORKDIR="$HOME/projects/honda"
export HONDA_DEFAULT_CONTAINER_RUNTIME="podman"
export HONDA_DEFAULT_CONTAINER_NETWORK=private
export REGISTRY_AUTH_FILE=$HOME/.config/podman/auth.json
HONDA_ENVFILE="$HONDA_WORKDIR/hri-tools/shell/honda.env"
_HONDA_LOADER="$HONDA_WORKDIR/hri-tools/shell/zshrc.honda"
export ANSIBLE_VAULT_PASSWORD_FILE=".vault_pass"
test -f "$_HONDA_LOADER" && source $HOME/projects/honda/hri-tools/shell/zshrc.honda


export PYTHON_KEYRING_BACKEND=keyring.backends.null.Keyring
export TERM=xterm


export PATH=$HOME/projects/honda/hri-tools:$PATH
export PATH=$HOME/go/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/utils/.venv/bin2:$PATH


export OATH=$HOME/.dotnet/tools:$PATH
export PATH=$PATH:~/.platformio/penv/bin:/opt/cuda-11.1/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/cuda-11.1/lib64

#export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
export PATH="$PATH:$GEM_HOME/bin"

# ===== ZSH =====

export ZSH=$HOME/.oh-my-zsh
export CLICOLOR=1
export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    ansible
    archlinux
    cp
    docker
    docker-compose
    git
    history
    kubectl-autocomplete
    poetry
    poetry-env
    screen 
    sudo
    systemd
    zsh-you-should-use
    z
    zsh-autocomplete
    zsh-autosuggestions
    zsh-history-substring-search
    zsh-syntax-highlighting
)

#autoload -Uz history-beginning-search-menu
#zle -N history-beginning-search-menu
#bindkey '^X^X' history-beginning-search-menu

## Keybindings section
bindkey -e
bindkey '^[[7~' beginning-of-line                               # Home key
bindkey '^[[H' beginning-of-line                                # Home key
if [[ "${terminfo[khome]}" != "" ]]; then
  bindkey "${terminfo[khome]}" beginning-of-line                # [Home] - Go to beginning of line
fi
bindkey '^[[8~' end-of-line                                     # End key
bindkey '^[[F' end-of-line                                     # End key
if [[ "${terminfo[kend]}" != "" ]]; then
  bindkey "${terminfo[kend]}" end-of-line                       # [End] - Go to end of line
fi
#bindkey '^[[2~' overwrite-mode                                  # Insert key
#bindkey '^[[3~' delete-char                                     # Delete key
#bindkey '^[[C'  forward-char                                    # Right key
#bindkey '^[[D'  backward-char                                   # Left key
#bindkey '^[[5~' history-beginning-search-backward               # Page up key
#bindkey '^[[6~' history-beginning-search-forward                # Page down key

# Navigate words with ctrl+arrow keys
#bindkey '^[Oc' forward-word                                     #
#bindkey '^[Od' backward-word                                    #
#bindkey '^[[1;5D' backward-word                                 #
#bindkey '^[[1;5C' forward-word                                  #
#bindkey '^H' backward-kill-word                                 # delete previous word with ctrl+backspace
#bindkey '^[[Z' undo                                             # Shift+tab undo last action

zstyle ':completion:*' menu select
zmodload zsh/complist
bindkey '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete

# all Tab widgets
zstyle ':autocomplete:*complete*:*' insert-unambiguous yes

# all history widgets
zstyle ':autocomplete:*history*:*' insert-unambiguous yes

# ^S
zstyle ':autocomplete:menu-search:*' insert-unambiguous yes

bindkey '\t' menu-select "$terminfo[kcbt]" menu-select
bindkey -M menuselect '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete

## Options section
#setopt correct                                                  # Auto correct mistakes
setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
setopt nocaseglob                                               # Case insensitive globbing
setopt rcexpandparam                                            # Array expension with parameters
setopt nocheckjobs                                              # Don't warn about running processes when exiting
setopt numericglobsort                                          # Sort filenames numerically when it makes sense
setopt nobeep                                                   # No beep
setopt appendhistory                                            # Immediately append history instead of overwriting
setopt histignorealldups                                        # If a new command is a duplicate, remove the older one
setopt autocd                                                   # if only directory path is entered, cd there.
setopt inc_append_history                                       # save commands are added to the history immediately, otherwise only when shell exits.

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                              # automatically find new executables in path 
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000
export EDITOR=/usr/bin/nano
export VISUAL=/usr/bin/nano
WORDCHARS=${WORDCHARS//\/[&.;]}   

source $ZSH/oh-my-zsh.sh

# Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-R

## Alias section 
alias cp="cp -i"                                                # Confirm before overwriting something
alias df='df -h'                                                # Human-readable sizes
alias free='free -m'                                            # Show sizes in MB
alias gitu='git add . && git commit && git push'
alias ls='ls --color=auto -h'
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'
alias np='nano -w PKGBUILD'
alias more=less
alias pacman='pacman --color=auto'
alias dmesg='dmesg -T --color'
alias subl="subl -a"
alias lsblk="lsblk -o name,mountpoint,size,type,ro,label,uuid"
alias mosquitto_sub="mosquitto_sub -F '%t %r %p'"
alias github-git-config='git config user.email "debauer@users.noreply.github.com" && git config user.name "debauer"'
alias tr33="tree . -L 2 -u -D"
alias uptime='uptime --pretty'
alias inxi='inxi -F'

alias gitk="gitk --all"
alias gk="gitk --all"
alias g="git"
alias gg="git gui"
alias gs="git status"
alias gfp="git fetch --prune"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

alias lsh='ls -lah'
alias l='lsd -l'
alias la='lsd -la'

alias sudo='sudo '

alias path='echo -e ${PATH//:/\\n}'
alias pythonpath='echo -e ${PYTHONPATH//:/\\n}'

alias j="journalctl"
alias jf="journalctl -f"
alias sctl="systemctl"


## Function section 
function avault() { ansible-vault "$1" --vault-password-file .vault_pass "$2";}
function backlight() { echo "$1" > /sys/class/backlight/amdgpu_bl1/brightness;}
function aplaybook() { ansible-playbook --vault-password-file .vault_pass -i hosts.yml "$@";}
function install_zsh_plugins () {
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions;
  git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search;
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
}


#
# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

function gi {                                                                                                                                                                                                                                   
    x="$@"                                                                                                                                                                                                                                      
                                                                                                                                                                                                                                                
    if [[ $1 == t* ]] || [[ $1 == "status" ]] ; then                                                                                                                                                                                            
        echo -e "Probably mistyped 'git' again, executing:\n\ngit ${1:1} ${@:2}\n"            
        git ${1:1} ${@:2}                                                                                                                                                                                                                                                                                                                                                                                
    else                                                                                                                                                                                                                                        
        curl -L -s "https://www.gitignore.io/api/${x// /,}"                                                                                                                                                                                     
    fi                                                                                                                                                                                                                                          
}   

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

eval "$(atuin init zsh --disable-up-arrow)"

