#
# Cookbook Name:: finalize
# Recipe:: php
#
# Copyright 2013, Konstantin Sorokin
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Finalize php installation with extras
packages_list = ["memcached",
                "ImageMagick",
                "ImageMagick-devel",
                "php-pecl-apc",
                "php-pecl-memcache",
                "php-pdo",
                "php-common",
                "php-mbstring",
                "php-xml",
                "php-xmlrpc",
                "php-soap",
                "php-gd",
                "php-intl",
                "php-mysql"]

packages_list.each do |rpm|
    package rpm do
        action :install
    end
end

#Pear auto discover option
execute "pear clear-cache"
execute "pear config-set auto_discover 1"

#Update the main pecl/pear channels
["pecl.php.net", "pear.php.net", "pear.symfony.com"].each do |channel|
    php_pear_channel channel do
      action :update
    end
end

#PHPUnit and dependencies

# PHPUnit_channel = php_pear_channel "pear.phpunit.de" do
#   action :discover
# end

# php_pear "PHPUnit" do
#   channel PHPUnit_channel.channel_name
#   action :install
# end

#Install pecl/pear packages
["PHP_CodeSniffer","imagick","xdebug"].each do |package_name|
    php_pear package_name do
        action :install
    end
end

#Xdebug config. Include module as zend_extension
template "#{node['php']['ext_conf_dir']}/xdebug.ini" do
  source "xdebug.ini.erb"
  owner "root"
  group "root"
  mode "0644"
end