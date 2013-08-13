#
# Author::  Konstantin Sorokin (<k.n.sorokin@gmail.com>)
# Cookbook Name:: finalize
# Libraries:: helpers
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
require 'chef/mixin/shell_out'
include Chef::Mixin::ShellOut

module Finalize
    module Helper
        def php_ext_dir
            cmd = shell_out("php -i | grep -e '^extension_dir'").stdout.split("\n").last
            if !cmd
                "/usr/lib/php/modules"
            else
                cmd.split(" ").last
            end
        end

        def php_xdebug_module
            shell_out("find / -name xdebug.so").stdout.split("\n").last
        end
    end
end