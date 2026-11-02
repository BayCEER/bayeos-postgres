#!/usr/bin/env bash
# Creates the second ("dual instance") database for bayeos-gateway inside the
# shared postgresdb container, next to the bayeos database used by bayeos-api.
#
set -euo pipefail

: "${GW_DB:=xbee}"
: "${GW_DB_USER:=xbee}"
: "${GW_DB_PASSWORD:=bayeos}"

echo "Creating gateway database ${GW_DB} and role ${GW_DB_USER} ..."

psql -v ON_ERROR_STOP=1 --username "${POSTGRES_USER}" --dbname "${POSTGRES_DB}" <<-EOSQL
	CREATE ROLE ${GW_DB_USER} LOGIN PASSWORD '${GW_DB_PASSWORD}';
	CREATE DATABASE ${GW_DB} OWNER ${GW_DB_USER} ENCODING 'UTF8';
EOSQL
