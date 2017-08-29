FROM nginx:1.13-alpine
LABEL maintainer "https://github.com/muccg/"

RUN apk --no-cache add \
    bash

RUN rm -rf /etc/nginx
COPY nginx /etc/nginx

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 443

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ['nginx']
