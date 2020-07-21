#! /bin/bash

while [[ $# -gt 0 ]]
do
key=$1

case $key in
	-b|--build|build)
	docker-compose -f rconnect-compose.yml build
	;;
	*)
	echo "unknown option $key"
	exit 1
	;;
esac
shift
done

docker-compose -f rconnect-compose.yml up -d
