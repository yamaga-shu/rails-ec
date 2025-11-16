FROM postgres:18-trixie

ENV TIMEZONE UTC

ENV POSTGRES_DB "postgres"
ENV POSTGRES_USER "postgres"
ENV POSTGRES_PASSWORD "postgres"

RUN chown -R postgres:postgres /var/lib/postgresql /docker-entrypoint-initdb.d
