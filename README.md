# rcompute
Enhanced R compute environment with PostgreSQL

The `rconnect` image can be built by issuing the following docker command from the rconnect directory:
docker build --tag rconnect .

The `rconnect` container can be run using the following docker command from the rconnect directory:
docker run -e PASSWORD=rstudiojh  -p 8787:8787 rconnect

To clear out containers, orphan images, hanging volumes, unused networks, etc., the 
`dockill.sh` script provided serves as a utility to clear the system.  CAUTION: Option 
`4` clears all images, so users may want to skip this step or delete images manually 
using Docker commands.  Option `6` only removes networks which are no longer connected 
to a container.

Execute from the command line with the following:
```shell script
bash ./dockill.sh
```

Users should see:
```shell script
1) Stop Containers
2) Delete Containers
3) Delete Orphan Images
4) Delete All Images
5) Delete Hanging Volumes
6) Remove Unused Networks
7) Quit
Docker Image Manager: 
```

