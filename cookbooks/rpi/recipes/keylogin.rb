directory "/home/pi/.ssh" do
  owner "pi"
  group "pi"
  mode 00700
end

template "/home/pi/.ssh/authorized_keys" do
  source "authorized-keys.erb"
  mode "0600"
  owner "pi"
  group "pi"
end