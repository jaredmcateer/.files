# My own personal environment variables.
if [ -f ~/.environment-variables ]; then
  source ~/.environment-variables;
fi

# Fix terminal colors
if [ "$TERM" = "xterm" ]; then
  if [ -z "$COLORTERM" ]; then
    if [ -z "$XTERM_VERSION" ]; then
      echo "Warning: Terminal wrongly calling itself 'xterm'."
    else
      case "$XTERM_VERSION" in
        "XTerm(256)") TERM="xterm-256color" ;;
        "XTerm(88)") TERM="xterm-88color" ;;
        "XTerm") ;;
        *)
          echo "Warning: Unrecognized XTERM_VERSION: $XTERM_VERSION"
          ;;
      esac
    fi
  else
    case "$COLORTERM" in
      gnome-terminal)
        # Those crafty Gnome folks require you to check COLORTERM,
        # But don't allow you to just *favour* the setting over TERM.
        # Instead you need to compare it and perform guesses based 
        # upon the value. This is, perhaps too simplistic.
        TERM="xterm-256color"
        ;;
      *)
        echo "Warning: Unrecognized COLORTERM: $COLORTERM"
        ;;
    esac
  fi
fi
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Add home bin folder to path
export PATH="$HOME/bin:$PATH"

# Better prompt with git support
source ~/.files/.bash-git-prompt/gitprompt.sh 

# Init fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export PATH="$HOME/.composer/vendor/bin:$PATH"

[ -f ~/.secrets ] && source ~/.secrets

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
