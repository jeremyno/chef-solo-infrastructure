package "watchdog" do
  action :install
end

template "/etc/watchdog.conf" do
  mode 0655
  source"watchdog.erb"
end

file "/etc/systemd/system.conf" do
  content "RuntimeWatchdogSec=14"
end

template "/etc/modprobe.d/bcm2708_wdog.conf" do
  source "bcm2708_wdog.conf.erb"
end

template "/etc/default/watchdog" do
  source "watchdog.keepalive.erb"
end

service "watchdog" do
  action [:enable]
end

service "watchdog" do
  action [:start]
end

cron_d "watch-uptime" do
  minute "*/5"
  hour "*"
  command "uptime >> /var/log/uptime.log"
  action ( node[:rpi][:watchdog][:debug].nil? ? :delete : :create )
end