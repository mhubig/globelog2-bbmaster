# -*- mode: ruby -*-
# vi: set ft=ruby :

BOX_NAME     = "docker"
SSH_PRIVKEY  = ENV['SSH_PRIVKEY']  || "~/.ssh/id_docker"
KEYPAIR_NAME = ENV['KEYPAIR_NAME'] || "docker"

DO_API_KEY   = ENV['DIGITALOCEAN_API_KEY']   || "your digital ocean api key"
DO_CLIENT_ID = ENV['DIGITALOCEAN_CLIENT_ID'] || "your digital ocean client id"

Vagrant.configure("2") do |config|

  config.vm.define :docker do |t|
  end

  config.vm.box = BOX_NAME
  config.ssh.forward_agent = true
  config.ssh.username = "vagrant"
  config.ssh.private_key_path = SSH_PRIVKEY

  config.vm.provider :digital_ocean do |digitalocean, override|
    override.vm.box_url = 'docker_digitalocean.box'
    override.vm.synced_folder ".", "/vagrant", disabled: true
    digitalocean.ssh_key_name = KEYPAIR_NAME
    digitalocean.client_id = DO_CLIENT_ID
    digitalocean.api_key = DO_API_KEY
    digitalocean.setup = false
    digitalocean.size = '512MB'
  end

end
