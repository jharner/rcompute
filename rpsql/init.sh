#!/bin/sh

PGDATA="/opt/pg-data"
pgversion="12"

export PATH=/usr/lib/postgresql/${pgversion}/bin:$PATH
initdb -D $PGDATA
pg_ctl -D $PGDATA start
sleep 10
psql --command "create user rstudio createdb"
psql --command "create user hive"

# Create databases
createdb -O rstudio rstudio
createdb -O hive hive
createdb -O rstudio dataexpo
createdb -O rstudio testdb
createdb -O rstudio nycflights13

# Build databases
psql -U rstudio dataexpo < /opt/dataexpo.sql  > /dev/null
gunzip -c /opt/nycflights13.sql.gz | psql -U rstudio nycflights13 > /dev/null

# Grant privileges
psql --command "GRANT ALL PRIVILEGES ON DATABASE dataexpo TO rstudio"
psql --command "GRANT ALL PRIVILEGES ON DATABASE nycflights13 TO rstudio"
psql --command "GRANT ALL PRIVILEGES ON DATABASE testdb TO rstudio"
service postgresql stop

