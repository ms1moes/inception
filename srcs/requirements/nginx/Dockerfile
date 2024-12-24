# Use the penultimate stable version of Debian as the base image
FROM debian:bullseye

# Update the package list and upgrade existing packages
RUN apt-get update && apt-get upgrade -y

# Install NGINX (web server) and OpenSSL (for generating SSL certificates)
RUN apt-get install -y nginx openssl

# Create a directory to store SSL certificates
RUN mkdir -p /etc/nginx/ssl

# Generate a self-signed SSL certificate and private key
# -x509: Creates a self-signed certificate
# -nodes: Skips the option to encrypt the private key
# -out: Path to save the certificate
# -keyout: Path to save the private key
# -subj: Provides certificate details (replace with your login and info)
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/incept.crt -keyout \
    /etc/nginx/ssl/incept.key -subj "/C=PT/ST=Lisbon/L=Lisbon/O=42/OU=42/CN=msimoes-.42.fr/"

# Copy the custom NGINX configuration file into the container
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# Create the WordPress directory (where website files will be stored)
RUN mkdir -p /var/www/wordpress

# Change ownership of the WordPress directory to 'www-data'
# 'www-data' is the default user and group that NGINX uses to serve files
RUN chown -R www-data:www-data /var/www/wordpress

# Run NGINX in the foreground (daemon mode disabled)
# This ensures the container keeps running and doesn't stop
CMD ["nginx", "-g", "daemon off;"]