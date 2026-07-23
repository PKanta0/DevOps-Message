FROM alpine:3.22 AS build

WORKDIR /site
COPY index.html .

FROM nginxinc/nginx-unprivileged:alpine

COPY --from=build /site/index.html /usr/share/nginx/html/index.html

EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
