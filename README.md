chef-solo-infrastructure
========================

Infrastructure based on chef solo, especially oriented for a raspberry pi. This 
includes a shell script, deploy.sh, which is used to deploy and/or install chef.

Folder Structure:
  - config includes json configurations for hosts.
  - cookbooks is where all cookbooks are saved to be deloyed to the rpi.
  - resources is a place to put other which need to be on the rpi when provisioning such as binaries.
    (Files that are not approriate for file/template/etc provided by chef for whatever reason.) 

    