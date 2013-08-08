# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "CentOS-6.4-x86_64-v20130427.box"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  #
  # ***CentOS 6.4 x86_64 Minimal (VirtualBox Guest Additions 4.2.12, Chef 11.4.4, Puppet 3.1.1)
  config.vm.box_url = "http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.4-x86_64-v20130427.box"

  # Boot with a GUI so you can see the screen. (Default is headless)
  # config.vm.boot_mode = :gui

  # Assign this VM to a host-only network IP, allowing you to access it
  # via the IP. Host-only networks can talk to the host machine as well as
  # any other machines on the same network, but cannot be accessed (through this
  # network interface) by any external networks.
  config.vm.network :hostonly, "192.168.33.50"

  # Assign this VM to a bridged network, allowing you to connect directly to a
  # network using the host's network device. This makes the VM appear as another
  # physical device on your network.
  # config.vm.network :bridged

  # Forward a port from the guest to the host, which allows for outside
  # computers to access the VM, whereas host only networking does not.
  # config.vm.forward_port 80, 8080

  # Set RAM to 1 GB
  config.vm.customize ["modifyvm", :id, "--memory", 1024]

  # enable symlinks for windows
  config.vm.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]

  # Share an additional folder to the guest VM. The first argument is
  # an identifier, the second is the path on the guest to mount the
  # folder, and the third is the path on the host to the actual folder.
  #config.vm.share_folder "v-root", "/vagrant", ".", :nfs => true

  # Provision with a shell script
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["cookbooks-local", "cookbooks"]
    chef.add_recipe "yum::yum"
    chef.add_recipe "php"
    chef.add_recipe "nginx"
    chef.add_recipe "apache2"
    chef.add_recipe "solr"
    chef.add_recipe "mysql"
    chef.add_recipe "mysql::server"
    chef.add_recipe "finalize"
    chef.add_recipe "finalize::drupal"
    chef.json = {
      :php => {
        "directives" => {
          "memory_limit" => "256M",
          "error_log" => "/vagrant/logs/php.log",
          "display_errors" => "On"
        }
      },
      :apache => {
        :listen_ports => [8080]
      },
      :mysql => {
        "server_root_password" => "root",
        "server_repl_password" => "root",
        "server_debian_password" => "root"
      },
      :finalize => {
        :server_name => "drupal-site",
        :drupal => {
          # If pressflow set to true, drupal core will be pulled out from https://github.com/pressflow/<major_version>.git
          # for more info visit http://pressflow.org/faq
          "pressflow" => true,           # Default false
          "sites_subdir" => "default",   # Default "default"
          "major_version" => "7",        # Default "7"
          "preferred_state" => "stable", # Default "stable"
          "theme" => "omega"             # Default "omega"
        }
      },
      :solr => {
        "version" => "4.4.0"
      },
      :drush => {
        "install_method" => "git",
        "version" => "7.x-5.9"
      }
    }
end
end