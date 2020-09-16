#!/bin/sh

PGDATA="/opt/pg-data"
pgversion="12"

# Run the server with a non-standard port during setup.
tmpport=5431

export PATH=/usr/lib/postgresql/${pgversion}/bin:$PATH
initdb -D $PGDATA
pg_ctl -o "-p ${tmpport}" -D $PGDATA start
sleep 10

psql -p ${tmpport} --command "create user rstudio createdb"
psql -p ${tmpport} --command "create user hive"

# Create databases
createdb -p ${tmpport} -O rstudio rstudio
createdb -p ${tmpport} -O hive hive
createdb -p ${tmpport} -O rstudio dataexpo
createdb -p ${tmpport} -O rstudio testdb
createdb -p ${tmpport} -O rstudio nycflights13

# Build databases
psql -p ${tmpport} -U rstudio dataexpo < /opt/dataexpo.sql  > /dev/null
gunzip -c /opt/nycflights13.sql.gz | psql -p ${tmpport} -U rstudio nycflights13 > /dev/null

# Grant privileges
psql -p ${tmpport} --command "GRANT ALL PRIVILEGES ON DATABASE dataexpo TO rstudio"
psql -p ${tmpport} --command "GRANT ALL PRIVILEGES ON DATABASE nycflights13 TO rstudio"
psql -p ${tmpport} --command "GRANT ALL PRIVILEGES ON DATABASE testdb TO rstudio"
service postgresql stop

