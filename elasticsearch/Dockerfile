FROM muccg/debian8-base:latest
MAINTAINER ccg <devops@ccg.murdoch.edu.au>

RUN apt-get update && apt-get install -y --no-install-recommends \
  curl \
  openjdk-7-jre \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

# Install Elasticsearch
RUN cd /opt \
  && curl -O https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.4.4.tar.gz \
  && tar xzf elasticsearch-*.tar.gz \
  && rm elasticsearch-*.tar.gz \
  && ln -s elasticsearch-* elasticsearch

RUN groupadd -r elasticsearch \
  && useradd -c "Elasticsearch" -g elasticsearch -M -r -s /sbin/nologin elasticsearch

RUN mkdir -p /opt/elasticsearch/data/elasticsearch \
  && mkdir -p /opt/elasticsearch/logs \
  && chown -R elasticsearch:elasticsearch /opt/elasticsearch/data \
  && chown -R elasticsearch:elasticsearch /opt/elasticsearch/logs

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

VOLUME ["/opt/elasticsearch/config", "/opt/elasticsearch/data"]
EXPOSE 9200
EXPOSE 9300

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ['elasticsearch']
