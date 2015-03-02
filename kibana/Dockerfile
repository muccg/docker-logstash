FROM muccg/debian8-base:latest
MAINTAINER ccg <ccgdevops@googlegroups.com>

RUN apt-get update && apt-get install -y --no-install-recommends \
  curl \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Kibana
RUN cd /opt \
  && curl -O https://download.elasticsearch.org/kibana/kibana/kibana-4.0.0-linux-x64.tar.gz \
  && tar xzf kibana-*.tar.gz \
  && rm kibana-*.tar.gz \
  && ln -s kibana-* kibana

COPY kibana.yml /opt/kibana/config/kibana.yml

RUN groupadd -r kibana \
  && useradd -c "Kibana" -g kibana -M -r -s /sbin/nologin kibana

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

VOLUME /opt/kibana/config
EXPOSE 5601

# TODO can we use this to pass through elastic search URL?
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ['kibana']
