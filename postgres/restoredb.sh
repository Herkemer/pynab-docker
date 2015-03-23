#!/bin/bash

FILE=/backup/$1

if [ -e $FILE ]; then
    echo "Restoring database using $1 file."
    gunzip -c $FILE | psql --host "$POSTGRES_PORT_5432_TCP_ADDR" --port "$POSTGRES_PORT_5432_TCP_PORT" --username=$DB_USER --no-password --dbname=$DB_NAME --quiet
else
    echo "Unable to find $1 file to restore from."
fi
