#!/bin/bash

## Introduce important environment variables
PGDATA="/opt/pg-data"
pgversion="12"
appdir=/usr/lib/postgresql/${pgversion}/bin/

export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

##Start the database.
/usr/bin/pg_ctlcluster 12 main start --foreground