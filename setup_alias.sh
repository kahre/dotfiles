#!/bin/bash

if [ ! -d ${HOME}/.config ]; then
  echo "Creating .config directory"
  mkdir ${HOME}/.config
fi

if [ -d ${HOME}/.config/shell ]; then
  echo "Shell config directory exists, exiting"
  exit
fi

echo "Linking aliases directory"
ln -s ${PWD}/config/shell ${HOME}.config/shell

if [ -f ${HOME}/.zshrc ]; then
  echo "source ${HOME}/.config/shell/aliases" >> ${HOME}/.zshrc
fi

if [ -f ${HOME}/.bashrc ]; then
  echo "source ${HOME}/.config/shell/aliases" >> ${HOME}/.bashrc
fi

