# =============================================================
# Dockerfile — Damolak App
# Static website served with Nginx
# =============================================================

FROM nginx:alpine

# Remove default content
RUN rm -rf /usr/share/nginx/html/*

# Copy website files
COPY damolak/ /usr/share/nginx/html/

# Internal nginx port
EXPOSE 80

# Run nginx foreground
CMD ["nginx", "-g", "daemon off;"]

