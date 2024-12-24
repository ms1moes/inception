# Use the penultimate stable version of Debian as the base image
FROM debian:bullseye

# Update the package list and upgrade existing packages
RUN apt-get update && apt-get upgrade -y

# Install MariaDB server
RUN apt-get install -y mariadb-server

# Copy the initialization script into the container
COPY ./conf/mariadb-init.sh /mariadb-init.sh

# Make the initialization script executable
RUN chmod +x /mariadb-init.sh

# Set the initialization script as the container's entrypoint
ENTRYPOINT ["./mariadb-init.sh"]
