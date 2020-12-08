#!/bin/bash

install_ansible_macos()
{
  python3 -m pip install --user ansible
}

install_ansible_ubuntu()
{
  sudo apt update && sudo apt install software-properties-common && sudo apt-add-repository --yes --update ppa:ansible/ansible && sudo apt install ansible
}

if [[ $(uname) = "Darwin" ]]; then
  install_ansible_macos
else
  install_ansible_ubuntu
fi

exit $?
