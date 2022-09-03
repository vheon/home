function vagrant --wraps vagrant --description 'run vagrant inside the libvirt container where everything is pre-configured'
  docker run --interactive --tty --rm \
    -e LIBVIRT_DEFAULT_URI \
    -v /var/run/libvirt/:/var/run/libvirt/ \
    -v ~/.vagrant.d:/.vagrant.d \
    -v (realpath "$PWD"):$PWD \
    -w (realpath "$PWD") \
    --network host \
    vagrantlibvirt/vagrant-libvirt:latest \
      vagrant $argv
end

