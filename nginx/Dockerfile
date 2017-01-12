FROM nginx:1.10
MAINTAINER https://github.com/muccg/

RUN rm -rf /etc/nginx
COPY nginx /etc/nginx

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 443

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ['nginx']
