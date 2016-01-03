FROM postgres:9.3

RUN apt-get -q update

ADD local.conf /local.conf
ADD tuning.sh /docker-entrypoint-initdb.d/
RUN chmod 755 /docker-entrypoint-initdb.d/tuning.sh

ADD setupRemoteConnections.sh /docker-entrypoint-initdb.d/
RUN chmod 755 /docker-entrypoint-initdb.d/setupRemoteConnections.sh

ADD setup-database.sh /docker-entrypoint-initdb.d/
RUN chmod 755 /docker-entrypoint-initdb.d/setup-database.sh

ADD backupdb.sh /backupdb.sh
RUN chmod 755 /backupdb.sh

ADD restoredb.sh /restoredb.sh
RUN chmod 755 /restoredb.sh
