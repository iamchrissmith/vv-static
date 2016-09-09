#!/usr/bin/env bash
# run this in vagrant's www folder to create a simple blank site
#

cd ~/vagrant-local/www/

printf "What is the name of the directory you want to delete? "
read DIRECTORY

rm -rf $DIRECTORY

# move from our new DIRECTORY back to www then one higher to find our config files
rm -rf ../config/nginx-config/sites/"$DIRECTORY.conf"

printf "Do you want to provision Vagrant now? (Y/n)"
read PROVISION

if [ 'Y' = "$PROVISION" ] ; then
	vagrant provision
else 
	echo "remember to 'vagrant provision' for your site to be fully removed"
fi

exit 0