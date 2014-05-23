chef-solo-infrastructure
========================

Infrastructure based on chef solo, especially oriented for a raspberry pi. This 
includes a shell script, deploy.sh, which is used to deploy and/or install chef.

Quick Start
========================

For an rpi named "pi00" which has ssh running do the following to get started:

copy config/example.json to config/pi00.json
run ./deploy.sh pi00 pi
log in if you are prompted and chef will install everything you need. 

Additional Information
========================

Folder Structure:
  - config includes json configurations for hosts.
  - cookbooks is where all cookbooks are saved to be deloyed to the rpi.
  - resources is a place to put other which need to be on the rpi when provisioning such as binaries.
    (Files that are not approriate for file/template/etc provided by chef for whatever reason.) 

To add a cookbook of your own, download it into cookbooks. All cookbooks are ignored by default so that you 
can have your own infrastructure setup without committing back to this repository. Then add your cookbook 
and any properties to the runlist of the node you care about.

You may need to update your /etc/hosts file in order to make the deploy script run if you do not have
some sort of DNS/host resolution otherwise available.  