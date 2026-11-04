#!/usr/bin/env bash
# Creates the second ("dual instance") database for bayeos-gateway inside the
# shared postgresdb container, next to the bayeos database used by bayeos-api.
#
set -euo pipefail

: "${GW_DB:?GW_DB is required}"
: "${GW_DB_USER:?GW_DB_USER is required}"
: "${GW_DB_PASSWORD:?GW_DB_PASSWORD is required}"
: "${POSTGRES_USER:?POSTGRES_USER is required}"
: "${POSTGRES_DB:?POSTGRES_DB is required}"

echo "Creating gateway database ${GW_DB} and role ${GW_DB_USER} ..."

psql -v ON_ERROR_STOP=1 --username "${POSTGRES_USER}" --dbname "${POSTGRES_DB}" <<-EOSQL
	CREATE ROLE ${GW_DB_USER} LOGIN PASSWORD '${GW_DB_PASSWORD}';
	CREATE DATABASE ${GW_DB} OWNER ${GW_DB_USER} ENCODING 'UTF8';
EOSQL
