# =============================================================
# Dockerfile — Damolak App
# Serves static HTML using Nginx on port 3000
# =============================================================

FROM nginx:alpine

# Remove default Nginx static files
RUN rm -rf /usr/share/nginx/html/*

# Copy Damolak app into Nginx html folder
COPY damolak/ /usr/share/nginx/html/

# Expose port 3000
EXPOSE 3000

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]