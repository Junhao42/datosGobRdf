FROM ontotext/graphdb:10.1.5

RUN mkdir /root/graphdb-import

WORKDIR /root/graphdb-import

RUN curl -O https://www.zaragoza.es/sede/servicio/urbanismo-infraestructuras/estacion-bicicleta.ttl

EXPOSE 7200