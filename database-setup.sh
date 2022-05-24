#!/usr/bin/env bash
export MSYS_NO_PATHCONV=1 &&
docker create --name postgres-demo -e POSTGRES_PASSWORD=Welcome -p 5432:5432 postgres:11.5-alpine &&
docker start postgres-demo &&
docker cp database-setup/create_tables.sql postgres-demo:/create_tables.sql &&
docker exec postgres-demo /bin/sh -c "psql -U postgres -c 'create database conference_app;'"
docker exec -it postgres-demo psql -d conference_app -f create_tables.sql -U postgres &&
docker cp database-setup/insert_data.sql postgres-demo:/insert_data.sql &&
docker exec -it postgres-demo psql -d conference_app -f insert_data.sql -U postgres &&
printf "All done. Database was created successfully!\n"
