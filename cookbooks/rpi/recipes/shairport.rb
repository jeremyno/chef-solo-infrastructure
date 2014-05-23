execute "change audio device" do
  command "amixer cset numid=3 1"
end

%w{git libao-dev libssl-dev libcrypt-openssl-rsa-perl libio-socket-inet6-perl libwww-perl avahi-utils libmodule-build-perl}.each do |pkg|
  package pkg do
    action :install
  end
end

git node['sdp']['directory'] do
  repository 'https://github.com/njh/perl-net-sdp.git'
  action 'sync'
end

execute "install sdp" do
  not_if { File.exists?("/usr/local/bin/sdp2rat") }
  cwd node['sdp']['directory']
  command "perl Build.PL && ./Build && ./Build test && ./Build install"
end

execute "change default front" do
  command "sed 's/pcm.front cards.pcm.front/pcm.front cards.pcm.default/' -i /usr/share/alsa/alsa.conf"
end

user "shairport";

include_recipe "shairport"

cron_d "shairport-stability" do
  minute 0
  hour "*/8"
  command "service shairport restart"
end

# for whatever reason, enable didn't do what it should
execute "enable shairport" do
  command "insserv shairport"
end