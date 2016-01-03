echo "******** Running pgTune **********"

pgtune --debug -T OLTP --memory=${DB_MEM} -i "$PGDATA"/postgresql.conf -o "$PGDATA"/local.conf

echo "******** Adding include to postgresql.conf **********"
{ echo; echo "include = 'local.conf'"; } >> "$PGDATA"/postgresql.conf

echo "******** pgTune Complete **********"
