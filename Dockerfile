# Use nginx lightweight image
FROM nginx:alpine

# Copy your HTML into nginx's web root
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80 inside container
EXPOSE 80

# nginx will auto-start with default CMD
