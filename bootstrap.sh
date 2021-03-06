#!/bin/bash

install_ansible_macos()
{
  python3 -m pip install --user ansible
}

install_ansible_ubuntu()
{
  sudo apt update && sudo apt install -y ansible
}

if [[ $(uname) = "Darwin" ]]; then
  install_ansible_macos
else
  install_ansible_ubuntu
fi

exit $?
