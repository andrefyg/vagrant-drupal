
package "php-pear" do
  action :install
end

execute "pear_config" do
	command "pear config-set auto_discover 1"
end

service "httpd" do
    action :restart
end

# update the main pecl channel
php_pear_channel 'pecl.php.net' do
  action :update
end

#PHPUnit
package "phpunit" do
  action :install
end

php_pear "PHP_CodeSniffer" do
  action :install
end

php_pear "xdebug" do
  action :install
end

template "/vagrant/www/hosts.txt" do
	source "hosts.erb"
	owner "vagrant"
    group "vagrant"
    mode "0777"
end