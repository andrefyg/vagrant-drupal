#
# Cookbook Name:: finalize
# Recipe:: default
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

default["finalize"]["server_name"] =                "drupal-site"
default["finalize"]["apache2"]["docroot"] =         "/vagrant/www"

default["finalize"]["drupal"]["pressflow"] = false
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
                                                        devel
                                                        token
                                                        ctools
                                                        pathauto
                                                        rules
                                                        admin_menu}