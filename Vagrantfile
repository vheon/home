Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"

  config.vm.provision "shell", path: "bootstrap.sh"
  config.vm.provision "ansible_local" do |ansible|
    ansible.playbook = "main.yml"
  end
end
