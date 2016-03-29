# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' file-sort access
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list '' '+m:{a-z}={A-Z}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always
zstyle ':completion:::::' completer _complete _approximate
zstyle ':completion:*:approximate:*' max-errors 2
zstyle ':completion:*' completer _complete _prefix
zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct
zstyle ':completion:predict:*' completer _complete # Completion caching
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST # Expand partial paths
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-slashes 'yes' # Include non-hidden directories in globbed file completions
zstyle ':completion:*:complete:-command-::commands' ignored-patterns '*\~' # Separate matches into groups
zstyle ':completion:*:matches' group 'yes' # Describe each match group.
zstyle ':completion:*:descriptions' format "%B---- %d%b" # Messages/warnings format
zstyle ':completion:*:messages' format '%B%U---- %d%u%b'
zstyle ':completion:*:warnings' format '%B%U---- no match for: %d%u%b' # Describe options in full
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'

autoload -Uz compinit
compinit
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn hg
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' formats '%F{red}[%F{yellow}%s%F{red}-%F{magenta}%b%F{blue}%m%F{cyan}%u%F{green}%c%F{red}]%f'
zstyle ':vcs_info:*' stagedstr '+'
zstyle ':vcs_info:*' unstagedstr '?'
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=500
SAVEHIST=500
setopt autopushd prompt_subst appendhistory autocd
autoload -U colors && colors
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install

export PYTHONPATH=${HOME}/lib/python2.7/site-packages:${PYTHONPATH}
export PYTHONPATH=${HOME}/.local/usr/local/lib/python2.7/dist-packages:${PYTHONPATH}
export PYTHONPATH=${HOME}/.local/lib/python:${PYTHONPATH}
export PYTHONPATH=${HOME}/.local/lib/python2.7/site-packages:${PYTHONPATH}

# Private binaries path
[ -d ~/.local/bin ] && PATH=${HOME}/.local/bin:${HOME}/.local/usr/local/bin:"${PATH}"
export LD_LIBRARY_PATH=${HOME}/.local/lib:${HOME}/.local/usr/lib:${LD_LIBRARY_PATH}

export MANPATH=${HOME}/.local/share/man:${HOME}/.local/usr/local/share/man:${MANPATH}


alias ls='ls --color=auto'
alias ll='ls -l --color=auto'

#selector
#source zsh-selector.sh --hist --cd

#using vcprompt
PS1='${debian_chroot:+($debian_chroot)}%{$fg[yellow]%}%D_%*%{$fg_no_bold[red]%}|%{$fg_no_bold[magenta]%}%n@%m%{$fg_no_bold[red]%}|%{$fg_no_bold[cyan]%}%/$ %{$reset_color%}'
RPS1='${vcs_info_msg_0_}'

#crontab editor
export EDITOR=vim

precmd()
{
  vcs_info
  #log history
  echo "$(date +%Y-%m-%d--%H-%M-%S) $(hostname) $PWD $(fc -ln|tail -1)" >> ~/.full_history
}

function img {
  for image in "$@"; do
    convert -thumbnail $(tput cols) "$image" txt:- | awk -F '[)(,]' '!/^#/{gsub(/ /,"");printf"\033[48;2;"$3";"$4";"$5"m "}';
    echo -e "\e[0;0m";
  done;
}

#local settings
source $HOME/.zshrc_local
