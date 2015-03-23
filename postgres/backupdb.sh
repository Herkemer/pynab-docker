#!/bin/bash

if [ -z $1 ]; then
    NOW=$(date +"%d-%m-%Y-%T")

    FILE=$DB_NAME.$NOW.gz
else
    FILE=$1
fi

echo "Backing up the $DB_NAME database to $FILE"

exec pg_dump --host "$POSTGRES_PORT_5432_TCP_ADDR" --port "$POSTGRES_PORT_5432_TCP_PORT" --username=$DB_USER --no-password --clean --compress=9 --dbname=$DB_NAME --file=/backup/$FILE --verbose
