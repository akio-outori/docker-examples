FROM postgres:9.5-alpine
USER postgres
RUN PGDATA=/var/lib/postgresql/data /usr/local/bin/initdb

COPY entrypoint.sh /
EXPOSE 5432

ENTRYPOINT ["/entrypoint.sh"]
