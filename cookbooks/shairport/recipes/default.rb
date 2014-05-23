#
# Cookbook Name:: shairport
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{libssl-dev libcrypt-openssl-rsa-perl libao-dev libio-socket-inet6-perl libwww-perl avahi-utils pkg-config}.each do |pkg|
  package pkg
end

git node['shairport']['directory'] do
  not_if { File.exists?("#{node['shairport']['directory']}/shairport") }
  repository 'https://github.com/abrasive/shairport'
  action 'sync'
end

execute 'configure' do
  not_if { File.exists?("#{node['shairport']['directory']}/shairport") }
  command './configure'
  cwd node['shairport']['directory']
end

execute 'make' do
  not_if { File.exists?("#{node['shairport']['directory']}/shairport") }
  command 'make'
  cwd node['shairport']['directory']
end

execute "copy" do
  not_if { File.exists?("/usr/bin/shairport") }
  command "ln -s #{node['shairport']['directory']}/shairport /usr/bin/shairport"
end

execute "set mode" do
  command "chmod 555 #{node['shairport']['directory']}/shairport"
end


template '/etc/init.d/shairport' do
  source 'shairport.init.erb'
  mode 0544
  owner 'root'
  group 'root'

  variables :name => node['shairport']['name'], :directory => node['shairport']['directory']

  notifies :restart, 'service[shairport]'
end

service 'shairport' do
  action [:enable, :start]
end

