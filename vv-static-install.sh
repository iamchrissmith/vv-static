#!/usr/bin/env bash
# run this in vagrant's www folder to create a simple blank site
#

cd ~/vagrant-local/www/

printf "What is the name of the directory you want to create? "
read DIRECTORY

mkdir $DIRECTORY
cd $DIRECTORY
#setup our hosts file
touch vvv-hosts
echo "$DIRECTORY.dev" >> vvv-hosts

# setup our basic HTML site
mkdir htdocs && cd htdocs
mkdir js && cd js
touch scripts.js
cd ..
mkdir css && cd css
touch styles.css
cd ..
cp ../../../vv-static/index-sample.html index.html
cd ..



# move from our new DIRECTORY back to www then one higher to find our config files
cd ../../config/nginx-config/sites/

# make and populate our new one based off our sample file
touch "$DIRECTORY.conf"
sed -e "s%include /etc/nginx/nginx-wp-common.conf%# include /etc/nginx/nginx-wp-common.conf%g;s%testserver.com%$DIRECTORY.dev ~^$DIRECTORY\.\d+\.\d+\.\d+\.\d+\.xip\.io$%g;s%wordpress-local%$DIRECTORY/htdocs%g" <"local-nginx-example.conf-sample" >"$DIRECTORY.conf"

printf "Do you want to provision Vagrant now? (Y/n)"
read PROVISION

if [ 'Y' = "$PROVISION" ] ; then
	vagrant provision
else 
	echo "remember to 'vagrant provision' for your site to work"
fi

exit 0