FROM trinodb/trino:latest

COPY ./plugin-opa /usr/lib/trino/plugin/opa
COPY ./config.properties /etc/trino/config.properties 
COPY ./access-control-opa.properties  /etc/trino/access-control-opa.properties
COPY ./log.properties  /etc/trino/log.properties

CMD ["/usr/lib/trino/bin/run-trino"]