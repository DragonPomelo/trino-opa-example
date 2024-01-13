FROM trinodb/trino:latest

COPY ./plugin-opa /usr/lib/trino/plugin/opa

COPY ./etc/config.properties /etc/trino/config.properties 
COPY ./etc/access-control-opa.properties  /etc/trino/access-control-opa.properties
COPY ./etc/log.properties  /etc/trino/log.properties
COPY ./etc/catalog/datalake.properties  /etc/trino/catalog/datalake.properties


CMD ["/usr/lib/trino/bin/run-trino"]