template "/etc/wpa_supplicant/wpa_supplicant.conf" do
  source "wpasupplicant.conf.erb"
  mode 0600
  notifies :run, "execute[restart-wlan]", :immediately
end

execute "restart-wlan" do
  command "wpa_action wlan0 stop ; ifup wlan0"
  action :nothing
end
