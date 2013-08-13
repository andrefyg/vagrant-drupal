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
include_recipe "php"

template "/usr/bin/logmail" do
	source "logmail.sh.erb"
	owner "root"
    group "root"
    mode "0775"
end

# Finalize php installation with extras
node["finalize"]["php"]["packages"].each do |rpm|
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
        preferred_state node["finalize"]["php"]["preferred_state"]
    end
end

#Xdebug config. Include module as zend_extension
ruby_block "xdebug configuration" do
    block do
        Chef::Resource::RubyBlock.send(:include, Finalize::Helper)
        extensions_dir = php_ext_dir
        xdebug_location = php_xdebug_module

        if "#{extensions_dir}/xdebug.so" != xdebug_location
            link = Chef::Resource::Link.new "#{extensions_dir}/xdebug.so", run_context
            link.to xdebug_location
            link.ignore_failure true
            link.run_action :create
        end

        template = Chef::Resource::Template.new "#{node['php']['ext_conf_dir']}/xdebug.ini", run_context
        template.source "xdebug.ini.erb"
        template.cookbook "finalize"
        template.owner "root"
        template.group "root"
        template.mode "0644"
        template.variables(:ext_dir => extensions_dir)
        template.run_action :create
    end
end