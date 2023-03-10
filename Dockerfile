FROM ontotext/graphdb:10.1.5

RUN mkdir /root/graphdb-import

COPY *.ttl /root/graphdb-import

EXPOSE 7200
