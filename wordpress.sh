 #!/bin/bash

# Before using please change the dir wariable
  dir="/home/yk/dev/public/" # Here !
# Before using please change the dir wariable

  echo "Welcome to wordpress Installation script made by https://github.com/yasarkaancan"
  echo "Please edit the dir before using in the code editor !"

 echo "Enter database name:"
 read db_name
 
 echo "Enter database username:"
 read db_username
 
 echo "Enter database password:"
 read db_password
 
 echo "Enter database host (default is localhost):"
 read db_host
 
 if [ -z "$db_host" ]
 then
   db_host="localhost"
 fi
 
 echo "Enter folder name:"
 read folder_name

 echo "Creating database..."
 
 echo "---------------------"
 echo "This is the database password !"
 
 mysql -u root -p <<MYSQL_SCRIPT
 CREATE DATABASE IF NOT EXISTS $db_name;
 CREATE USER '$db_username'@'$db_host' IDENTIFIED BY '$db_password';
 GRANT ALL PRIVILEGES ON $db_name.* TO '$db_username'@'$db_host';
 FLUSH PRIVILEGES;
 MYSQL_SCRIPT
 
 echo "Done!"
 
 echo "Downloading latest Wordpress version..."
wget https://wordpress.org/latest.zip
 
 echo "Extracting latest Wordpress version..."
 unzip latest.zip
 
 echo "Moving Wordpress files to $folder_name folder..."
 mv wordpress $dir$folder_name
 
 echo "Remove the latest.zip..."
 rm -rf latest.zip
 
 
 echo "Configuring Wordpress with database details..."
 cp $dir$folder_name/wp-config-sample.php $dir$folder_name/wp-config.php
 sed -i "s/database_name_here/$db_name/g" $dir$folder_name/wp-config.php
 sed -i "s/username_here/$db_username/g" $dir$folder_name/wp-config.php
 sed -i "s/password_here/$db_password/g" $dir$folder_name/wp-config.php

 echo "Wordpress installation complete."
