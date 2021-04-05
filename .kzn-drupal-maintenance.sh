#!/bin/bash
read -p "Continue to run Drupal maintenance? (y/n)" -n 1 -r
echo -e "\n"  # move to new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo -e "Running Drupal maintenance \n"
    set -x

    drush cr
    drush updb -y -y
    drush entup -y
    find -type d -exec chmod 755 {} +
    find -type f -exec chmod 644 {} + 
    find sites/all modules themes .dev vendor libraries -type f -exec chmod u+w {} +
    #find sites/default modules themes .dev libraries vendor -type d -exec chmod u+w {} +
    #find sites/default/files -type f -exec chmod u+w {} +
    #find sites/default/files -type d -exec chmod u+w {} +
    find themes/custom -type f -exec chmod 666 {} +
    find themes/custom -type d -exec chmod 777 {} +
    chown -R cccdns:cccdns .

    sudo /usr/bin/systemctl restart php-fpm74
    #bin/magento deploy:mode:set default -s
    #grunt watch
    set +x
   echo -e "\n***  BAM! All caches cleared *** \n"
fi
