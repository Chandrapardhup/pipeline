# Use a lightweight nginx image as base
FROM nginx:alpine

# Copy HTML file into nginx's default web folder
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80 so container can serve web pages
EXPOSE 80

# Run nginx in foreground to keep container alive
CMD ["nginx", "-g", "daemon off;"]
