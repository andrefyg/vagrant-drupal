##Description
Completes environment configuration:
* PHPUnit
* xdebug
* memchache
* Virtual host
* Install Drush
* Download and install drupal

##Requirements
* [apache2](https://github.com/opscode-cookbooks/apache2) - opscode apache2 w/ LWRP
* [php](https://github.com/opscode-cookbooks/php) - php/pear 
* [drush](https://github.com/ksorokin/chef-drush.git) - drupal shell


##Attributes

Apache config

    default["finalize"]["server_name"] =                "drupal-site"
    default["finalize"]["apache2"]["docroot"] =         "/vagrant/www"


Drupal config

    default["finalize"]["drupal"]["sites_subdir"] =     "default"
    default["finalize"]["drupal"]["major_version"] = "7"
    default["finalize"]["drupal"]["install_profile"] =  "standard"
    default["finalize"]["drupal"]["account_name"] =     "admin"
    default["finalize"]["drupal"]["account_pass"] =     "admin"
    default["finalize"]["drupal"]["preferred_state"] =  "stable"
    default["finalize"]["drupal"]["theme"] = "omega"
    default["finalize"]["drupal"]["modules_preset"] =   %w{entity
                                                            features
                                                            libraries
                                                            panels
                                                            devel
                                                            token
                                                            ctools
                                                            pathauto
                                                            rules
                                                            admin_menu}

##Recipes

### default
Completes apache and php configuration. 

### apache2

Creates viratual host

### iptables

Disables iptables firewall if installed

### drupal

Download drupal sources, default modules preset, theme and installs them

