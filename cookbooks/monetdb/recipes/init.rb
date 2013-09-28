#
# Cookbook Name:: monetdb
# Recipe:: init
#
# Copyright 2013, Uptime Technologies, LLC.
#
# All rights reserved - Do Not Redistribute
#
bash "monetdb-init" do
  not_if { File.exists?( '/var/lib/monetdb' ) }
  code <<-EOC
    mkdir -p /var/lib/monetdb
    chown monetdb:monetdb /var/lib/monetdb
    sudo -u monetdb monetdbd create /var/lib/monetdb
  EOC
  notifies :start, 'service[monetdbd]'
end

cookbook_file "/etc/rc.d/init.d/monetdbd" do
  mode 00755
  checksum "23d45f2a14f27f39c5be8a585d39144daa87db10a3e85c9787f6278d3afced8c"
end

bash "monetdb-service" do
  only_if { File.exists?( '/etc/rc.d/init.d/monetdbd' ) }
  code <<-EOC
    chkconfig --add monetdbd
    chkconfig monetdbd on
  EOC
  notifies :start, 'service[monetdbd]'
end

service "monetdbd" do
  supports :status => true , :restart => true , :reload => true
  action [ :start ]
end

