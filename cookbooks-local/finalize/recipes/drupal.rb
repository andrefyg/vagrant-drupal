#
# Cookbook Name:: finalize
# Recipe:: drupal
#
# Copyright 2013, Konstantin Sorokin
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may 1obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "drush"

#Base drupal folder1
drupal_path = node["finalize"]["apache2"]["docroot"]

drush_execute "dl" do
    options %w{drupal-7.x
                --drupal-project-rename=drupal
                --destination=#{drupal_path}}
end

execute "drupal_extract" do
    command "mv #{drupal_path}/drupal/* #{drupal_path} && rm -rf #{drupal_path}/drupal"
end

#MySQL dsn
mysql_dsn = "mysql://root"
mysql_dsn << ":#{node.set_unless['mysql']['server_root_password']}"
mysql_dsn << "@localhost/#{node["finalize"]["server_name"]}"

#Install drupal
drush_execute "site-install" do
    options %w{standard
                --destination=#{drupal_path}
                --account-name=admin
                --account-pass=admin
                --db-url=#{mysql_dsn}}
end

