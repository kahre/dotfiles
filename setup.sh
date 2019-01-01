#!/bin/bash

CL_RED='\033[0;31m'
CL_CYAN='\033[0;36m'
CL_RESET='\033[0m'

function err {
  echo -e "${CL_RED} !!${CL_RESET} $1"
}

function msg {
  echo -e "${CL_CYAN} --${CL_RESET} $1"
}

msg "Initializing all configurations"

if [ ! -d $HOME/.oh-my-zsh ]; then
  err "Oh my zsh is not configured, start again when you've set it up."
  exit
fi

BACKUP_DIR=${HOME}/dotfiles-backup
if [ ! -d ${BACKUP_DIR} ]; then
  msg "Creating backup directory \"${BACKUP_DIR}\"."
  mkdir $BACKUP_DIR
else
  err "Backup directory \"${BACKUP_DIR}\" exists, halting run."
  exit
fi

function link {
  msg "Backing up $2 to ${BACKUP_DIR}."
  msg "Linking $2 -> $1."
  cp -r $2 ${BACKUP_DIR}
  rm -r $2
  ln -s $1 $2
  echo -e "\n"
}

link ${PWD}/config/dunst ${HOME}/.config/dunst
link ${PWD}/config/i3 ${HOME}/.config/i3
link ${PWD}/config/polybar ${HOME}/.config/polybar
link ${PWD}/config/rofi ${HOME}/.config/rofi
link ${PWD}/config/shell ${HOME}/.config/shell
link ${PWD}/config/systemd ${HOME}/.config/systemd
link ${PWD}/config/termite ${HOME}/.config/termite
link ${PWD}/config/tmux ${HOME}/.config/tmux
link ${PWD}/config/nvim ${HOME}/.config/nvim
link ${PWD}/prompt.zsh-theme ${HOME}/.oh-my-zsh/themes/customprompt.zsh-theme
link ${PWD}/scripts ${HOME}/.scripts
link ${PWD}/spacemacs ${HOME}/.spacemacs
link ${PWD}/tmux.conf ${HOME}/.tmux.conf
link ${PWD}/Xresources ${HOME}/.Xresources
link ${PWD}/zshrc ${HOME}/.zshrc
