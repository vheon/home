#!/bin/bash

install_ansible_macos()
{
  python3 -m pip install --user ansible
}

install_ansible_ubuntu()
{
  sudo apt update && sudo apt install -y ansible
}

install_ansible()
{
  if [[ $(uname) = "Darwin" ]]; then
    install_ansible_macos
  else
    install_ansible_ubuntu
  fi
}

if ! command -v ansible-playbook &> /dev/null; then
  install_ansible
fi

exit $?
