require 'pp'

rootdir = File.dirname(__FILE__)

def getProp(hash, val, default)
  unless hash.nil? or hash[val].nil?
    return hash[val]
  else
    return default
  end
end

basename = File.basename(rootdir)

Vagrant.configure("2") do |config|
  config.vm.box = "precise32"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"
  
  Dir[rootdir + "/config/**.json"].each do |cfgfile|
    boxname = File.basename(cfgfile).gsub(/.json/,"")
    unless boxname == "example"
      config.vm.define boxname do |box|
        displayname=basename+"_"+boxname
	      cfg = JSON.parse(IO.read(cfgfile))
	      vboxcfg = cfg["virtualbox"]
	      
        config.vm.provider :virtualbox do |vb|
          vb.name = displayname
          vb.customize ["modifyvm", :id, "--memory", getProp(vboxcfg,"memory","512")]
          vb.customize ["modifyvm", :id, "--cpus", getProp(vboxcfg,"cpus","1")]
          vb.customize ["modifyvm", :id, "--cpuexecutioncap", getProp(vboxcfg,"cpucap","100")]
        end
	      
	      config.vm.provision :chef_solo do |chef|
	        chef.cookbooks_path = rootdir+"/cookbooks"
	        chef.roles_path = rootdir+"/roles"
	        chef.json = cfg
	        cfg["run_list"].each do |runme|
	          match = runme.match(/(.*)\[(.*)\]/)
	          
	          if (match.nil?)
	            chef.add_recipe runme
	          elsif (match[1] == "recipe")
	            chef.add_recipe match[2]
	          elsif (match[1] == "role")
	            chef.add_role match[2]
	          else
	            puts "unknown type: " + runme 
	          end
	        end
	      end
      end
	end
  end 
end