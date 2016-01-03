echo "******** Adding Tuning Config **********"

cp /local.conf "$PGDATA"/local.conf

echo "******** Adding include to postgresql.conf **********"
{ echo; echo "include = 'local.conf'"; } >> "$PGDATA"/postgresql.conf

echo "******** Tuning Complete **********"
