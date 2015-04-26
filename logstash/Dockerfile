FROM muccg/debian8-base:latest
MAINTAINER ccg <devops@ccg.murdoch.edu.au>

RUN apt-get update && apt-get install -y --no-install-recommends \
  curl \
  openjdk-7-jre \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

# Install Logstash
RUN cd /opt \
  && curl -O https://download.elasticsearch.org/logstash/logstash/logstash-1.4.2.tar.gz \
  && tar xzf logstash-*.tar.gz \
  && rm logstash-*.tar.gz \
  && cd logstash-1.4.2 \
  && curl -O https://download.elasticsearch.org/logstash/logstash/logstash-contrib-1.4.2.tar.gz \
  && tar xzf logstash-contrib*.tar.gz --strip 1 \
  && rm logstash-contrib*.tar.gz \
  && cd /opt \
  && ln -s logstash-* logstash

RUN groupadd -r logstash \
  && useradd -c "Logstash" -g logstash -M -r -s /sbin/nologin logstash

RUN mkdir -p /opt/logstash/data/logstash \
  && mkdir -p /opt/logstash/logs \
  && chown -R logstash:logstash /opt/logstash/data \
  && chown -R logstash:logstash /opt/logstash/logs

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

COPY logstash.conf /opt/logstash/config/logstash.conf

VOLUME ["/opt/logstash/config", "/opt/logstash/data", "/opt/logstash/logs"]
EXPOSE 514 5140

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ['logstash']
