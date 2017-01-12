logstash
========

A largely redundant repo that previously had some rather crufty containers for running logstash ELK stack (elasticsearch, kibana, logstash). The official containers have come along and made this redundant.

image: kibana:5.1
image: elasticsearch:5.1-alpine
image: logstash:5.1-alpine


Remember to set:

sudo sysctl vm.max_map_count=262144

Note that a single docker-compose 'up' won't bring that stack up gracefully due to container dependencies (startup ordering).
