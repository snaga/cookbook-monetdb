#
# Cookbook Name:: monetdb
# Recipe:: createdb
#
# Copyright 2013, Uptime Technologies, LLC.
#
# All rights reserved - Do Not Redistribute
#
bash "monetdb-createdb" do
  dbname = node['monetdb']['dbname']
  code <<-EOC
    if [ ! -d "/var/lib/monetdb/#{dbname}" ]; then
      sudo -u monetdb monetdb create #{dbname}
      sudo -u monetdb monetdb release #{dbname}
    fi
  EOC
end
