FROM nginx:stable
RUN mkdir /var/wwww
COPY nginx.conf /etc/nginx/nginx.conf
COPY index.html /var/www/
EXPOSE 80 
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
