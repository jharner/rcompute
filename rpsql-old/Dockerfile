FROM library/ubuntu:bionic
MAINTAINER Jim Harner <ejharner@gmail.com>

# Define Postgres Versions
ARG pgversion=9.6
ARG APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1

ENV PGDATA /opt/pg-data
ENV PGDIR /usr/lib/postgresql/${pgversion}/bin/
ENV PGVERSION ${pgversion}

# Add the PostgreSQL PGP key to verify their Debian packages.
COPY postgresKey.asc /tmp/

RUN apt-get update && apt-get install -y  apt-utils apt-transport-https ca-certificates \
	wget dirmngr gnupg software-properties-common tzdata && \
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
	add-apt-repository --yes 'deb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main' && \
    apt-get update && \
    apt-get clean
    
# Install packages and postgresql
RUN apt-get install -y postgresql-${pgversion} postgresql-client-${pgversion} postgresql-contrib-${pgversion} libpq-dev
# removed python-software-properties from install:  no installation candidate
RUN mkdir -p /opt/pg-data; chown -R postgres /opt/pg-data; chmod 700 /opt/pg-data

RUN locale-gen en_US.UTF-8

# Delete default cluster and create new cluster
RUN pg_dropcluster ${pgversion} main

# Copy data file
COPY dataexpo.sql nycflights13.sql.gz init.sh /opt/

# Become user Postgres (superuser)
USER postgres

# Copy connection configuration file
COPY pg_hba.conf postgresql.conf /etc/postgresql/${pgversion}/main/
COPY runpg.sh /var/lib/postgresql/runpg.sh
RUN /opt/init.sh

# Define environment variables
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

EXPOSE 5432

# Execute Postgres setup script "runpg.sh"
CMD ["var/lib/postgresql/runpg.sh", "${pgversion}"]

