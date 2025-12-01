# Pure pipeline container: serves static repo content via nginx
FROM nginx:alpine
COPY . /usr/share/nginx/html
