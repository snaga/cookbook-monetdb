#
# Cookbook Name:: monetdb
# Recipe:: default
#
# Copyright 2013, Uptime Technologies, LLC.
#
# All rights reserved - Do Not Redistribute
#
template "resolv.conf" do
  path "/etc/resolv.conf"
  source "resolv.conf.erb"
  owner "root"
  group "root"
  mode 0644
end

template "iptables" do
  path "/etc/sysconfig/iptables"
  source "iptables.erb"
  owner "root"
  group "root"
  mode 0600
  notifies :restart, 'service[iptables]'
end

service "iptables" do
  supports :status => true , :restart => true , :reload => false
  action [ :enable, :restart ]
end

cookbook_file "/etc/yum.repos.d/uptime-beta-rhel6.repo" do
  mode 00644
  checksum "4ae6f23c6affd4bd0e37d223a21c6d6f1ca63c078e16df090d18b66bf2ef9bbb"
end

cookbook_file "/etc/pki/rpm-gpg/RPM-GPG-KEY-uptime-beta" do
  mode 00644
  checksum "6d13e13c09bba254ed83033784c0e31e9eaddb97a16d113607e261ed14a30773"
end


%w{MonetDB MonetDB-SQL-server5 MonetDB-client MonetDB-client-perl MonetDB-client-tools MonetDB-stream MonetDB5-server}.each do |pkg|
  package pkg do
    action :install
  end
end

