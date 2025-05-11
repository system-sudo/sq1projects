FROM nginx:alpine

COPY index.html /usr/share/nginx/html/index.html

COPY slides/ /usr/share/nginx/html/slides/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
