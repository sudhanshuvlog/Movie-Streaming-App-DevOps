FROM nginx:alpine

# Copy your HTML files into the container
COPY . /usr/share/nginx/html

# Copy the entrypoint script into the container
COPY entrypoint.sh /entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /entrypoint.sh

# Set the entrypoint to the script
ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]