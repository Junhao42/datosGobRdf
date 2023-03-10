FROM ontotext/graphdb:tag

RUN mkdir /root/graphdb-import

COPY *.ttl /root/graphdb-import

EXPOSE 7200