#!/bin/sh

set -eu

export PGPASSWORD="$DB_ADMIN_PASSWORD"

echo "Checking PostgreSQL..."

until pg_isready \
    -h "$DB_POSTGRESDB_HOST" \
    -p "$DB_POSTGRESDB_PORT" \
    -U "$DB_ADMIN_USER"
do
    sleep 1
done

echo "PostgreSQL available."

DATABASE_EXISTS=$(psql \
    -h "$DB_POSTGRESDB_HOST" \
    -p "$DB_POSTGRESDB_PORT" \
    -U "$DB_ADMIN_USER" \
    -d "$DB_ADMIN_DATABASE" \
    -tAc "SELECT 1 FROM pg_database WHERE datname='$DB_POSTGRESDB_DATABASE'")

if [ "$DATABASE_EXISTS" = "1" ]; then

    echo "Database '$DB_POSTGRESDB_DATABASE' already exists."

else

    echo "Creating database '$DB_POSTGRESDB_DATABASE'..."

    psql \
        -h "$DB_POSTGRESDB_HOST" \
        -p "$DB_POSTGRESDB_PORT" \
        -U "$DB_ADMIN_USER" \
        -d "$DB_ADMIN_DATABASE" \
        -c "CREATE DATABASE \"$DB_POSTGRESDB_DATABASE\" OWNER \"$DB_POSTGRESDB_USER\";"

    echo "Database '$DB_POSTGRESDB_DATABASE' created."

fi