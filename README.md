# rcompute
Enhanced R compute environment with PostgreSQL

The `rconnect` image can be built by issuing the following docker command from the rconnect directory:
docker build --tag rconnect .

The `rconnect` container can be run using the following docker command from the rconnect directory:
docker run -e PASSWORD=rstudiojh  -p 8787:8787 rconnect

