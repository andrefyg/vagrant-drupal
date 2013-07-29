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

["php-xml", "php-pdo", "php-gd"].each do |package_name|
    package package_name do
      action :install
    end
end

#Pear auto discover option
execute "pear_config" do
	command "pear config-set auto_discover 1"
end

#Update the main pecl/pear channel
["pecl.php.net", "pear.php.net"].each do |channel|
    php_pear_channel channel do
      action :update
    end
end

#PHPUnit
PHPUnit_de = php_pear_channel "pear.phpunit.de" do
  action :discover
end

php_pear "PHPUnit" do
  channel PHPUnit_de.channel_name
  action :install
end

#Install pecl/pear packages
["PHP_CodeSniffer", "xdebug"].each do |package_name|
    php_pear package_name do
        action :install
    end
end

#Xdebug config. Include module as zend extension
template "#{node['php']['ext_conf_dir']}/xdebug.ini" do
  source "xdebug.ini.erb"
  owner "root"
  group "root"
  mode "0644"
end