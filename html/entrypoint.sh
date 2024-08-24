#!/bin/sh

# Use envsubst to replace placeholders with environment variables in the HTML files
envsubst '${API_URL}' < /usr/share/nginx/html/gallery.html > /usr/share/nginx/html/gallery.tmp.html
mv /usr/share/nginx/html/gallery.tmp.html /usr/share/nginx/html/gallery.html

envsubst '${API_URL}' < /usr/share/nginx/html/register.html > /usr/share/nginx/html/register.tmp.html
mv /usr/share/nginx/html/register.tmp.html /usr/share/nginx/html/register.html

envsubst '${API_URL}' < /usr/share/nginx/html/watch.html > /usr/share/nginx/html/watch.tmp.html
mv /usr/share/nginx/html/watch.tmp.html /usr/share/nginx/html/watch.html

envsubst '${API_URL}' < /usr/share/nginx/html/search.html > /usr/share/nginx/html/search.tmp.html
mv /usr/share/nginx/html/search.tmp.html /usr/share/nginx/html/search.html


# Start Nginx
nginx -g 'daemon off;'