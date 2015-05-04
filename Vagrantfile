# -*- mode: ruby -*-
# vi: set ft=ruby :

# http://duleorlovic.github.io/blog/ruby-on-rails/vagrant/digitalocean/2015/02/16/rails-through-vagrant-to-digitalocean/
# define some inputs... could grep from config
ADDITIONAL_PACKAGES="imagemagick libmagickwand-dev"
TARGET_RUBY_VERSION="2.2.1" # its better to specify since RUBY_VERSION is taken from vagrant

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  #config.vm.box = "hashicorp/precise32"
  config.vm.box = "ubuntu/trusty64"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 3000, host: 3000

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.
  config.vm.provider "virtualbox" do |vb|
    #vb.memory = "2048"
    vb.customize ["modifyvm", :id, "--memory", "2048"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline <<-SHELL
  #   sudo apt-get install apache2
  # SHELL

  config.vm.provision "shell", inline: <<-SHELL
    # Needed for docs generation and database default
    update-locale LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8
    apt-get -y update
    # install developlment tools
    apt-get -y install build-essential curl git nodejs #{ADDITIONAL_PACKAGES}
    # postresql
    apt-get -y install postgresql postgresql-contrib libpq-dev

    # Create user vagrant within postgres which can create databases
    su -l postgres -c 'createuser --createdb vagrant'
    # Update postgres config to allow local user to connect
    sed -i.bak -E 's/(local|host)(\s+?all\s+?all.*?)(peer|md5)/\\1\\2trust/' /etc/postgresql/9.3/main/pg_hba.conf
    /etc/init.d/postgresql restart

    # check if rvm is installed
    if [ "`su -l vagrant -c 'type -t rvm'`" != "function" ]; then
      echo install rvm, not so usefull in VMbut usefull if you want to set up locally and follow this steps
      # fix issue with signature https://github.com/wayneeseguin/rvm/issues/3110
      su -l vagrant -c 'gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3'
      su -l vagrant -c 'curl -sSL https://get.rvm.io | bash -s stable'
      # it is sucessfully installed in bash_... so no need to source
      su -l vagrant -c 'rvm use --install --default #{TARGET_RUBY_VERSION}'
      su -l vagrant -c 'cd /vagrant && gem install bundler'
    else
      echo "rvm already installed"
    fi

    echo installing bundler
    su -l vagrant -c 'cd /vagrant && bundle'
    su -l vagrant -c 'cd /vagrant && rake db:create'
    su -l vagrant -c 'cd /vagrant && rake db:migrate'
    su -l vagrant -c 'cd /vagrant && rake db:seed'
    # port need to be changed since rails 4.2 http://stackoverflow.com/questions/26570609/rails-4-2-0-beta2-cant-connect-to-localhost
    su -l vagrant -c 'cd /vagrant && rails s -d -b 0.0.0.0'
  SHELL
end
