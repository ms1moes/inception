#!/bin/bash

# Start the MariaDB service
service mariadb start
sleep 3

# Create the database specified in the environment variables
mysql -u root -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DB}\`;"

# Create a user with the credentials from the environment variables
mysql -u root -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"

# Grant all privileges to the created user
mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO \`${MYSQL_USER}\`@'%';"

# Apply the changes to the privilege table
mysql -u root -e "FLUSH PRIVILEGES;"

# Set a root password using the environment variable
mysqladmin -u root password "$MYSQL_ROOT_PASSWORD"

# Shutdown MariaDB gracefully after initialization
mysqladmin -u root -p"$MYSQL_ROOT_PASSWORD" shutdown

# Display a success message
echo "DATABASE CREATED!!"

# Start the MariaDB server in safe mode and bind it to all IP addresses
exec mysqld_safe --bind-address=*
