# Pynab Docker


This project provides the Docker Compose configuration files necessary
to setup and run your own installation of the Pynab indexer using
Docker containers.  It includes running the Scanning, Postprocessing,
Prebot and API/WebUI features backed by a PostgreSQL database.

This project assumes the user has some familiarity with how Pynab
works.

## Installation

You must already have Docker and Docker Compose setup and running on
your host.

To complete he installation please run through the following steps:

1. Obtain the latest config sample file and edit to match your
configuration:
	wget -O config.py https://raw.githubusercontent.com/Murodese/pynab/master/config_sample.py
2. cp .dbenv-dist .dbenv and edit
   NOTE: If you modify the amount of memory available to your database
   here be sure to also edit docker-compose.yml for the postgres
   entry.
5. cp .apienv-dist .apienv and edit
   This should be the hostname that you expect to use when connecting
   to your api.
5. cp api/config.js-dist api/config.js and edit
   This should be where you expect the webui to be available, if
   you've chosen to not enable the webui then this value can be
   whatever you'd like.
6. docker-compose build
   This step will take some time as it pulls down various images and
   code and builds the required files.
7. docker-compose up -d postgres
   This will launch the postgres container for the first time,
   generate the required database and tuning files.

If you are updating from a previous release and have a database backup
you may restore that backup and proceed to the startup phase.

If you are starting from scratch or converting from a Newznab
installation please see below.

### Initialize System

  > docker-compose run --rm scan python3 install.py

This will setup the proper database tables and download a pre database
to get your started on your indexing.

Once this step completes you are free to add users, groups, etc and
proceed to the startup phase.

### Newznab Conversion

If you would like to pull in your old Newznab settings (users, groups,
etc) then run the following commands:

  > docker-compose run --rm scan python3 scripts/convert_from_newznab.py --mysql-passwd <passwd> <mysql host> <mysql db>

Run that command with --help to see other options, such as skipping
the conversion of some tables.

If you have nzb files to import you can run the following command

XXX - something about linking into backup first

  > docker-compose run --rm scan python3 scripts/import.py /backup/nzbfiles

You can now proceed to the startup phase.

## Startup

Once you have properly installed, configured and initialized your
instllation then you are ready for startup.

  > docker-compose up -d

## Interacting with Pynab Install

Generally you will use the pynab.py script to interact with your Pynab
install (add users, add groups, etc).  To perform this action while
running in Docker containers it takes a little more effort.

To print a list of users you can use this command:

  > docker-compose run --rm scan python3 pynab.py user list

Run with --help to see all of the commands available:

  > docker-compose run --rm scan python3 pynab.py --help

To make things easier you can always do this:

  > alias pynab="docker-compose run --rm scan python3 pynab.py"

This means you can simply run command such as this:

  > pynab regex
  > pynab group list

NOTE: The following pynab.py command do not work when running under
docker:

* start
* stop
* scan
* postprocess
* api
* update
* backfill
* pubsub
* preobt
* stats

Future releases may make these command more useful.

## Backup/Restore

The backup directory is a special mount point for the scan and
postgres containers.  This allows you to perform
backup/exports/restores/imports with the system.

Special scripts have been added to the postgres container to help
facilitate backups and restores.

To perform a backup you can run:

  > docker-compose run --rm postgres /backupdb.sh

To perform a restore, place the file you wish to restore from in the
backup directory and run:

  > docker-compose run --rm postgres /restoredb.sh <restore file>

NOTE: That file MUST exist in the backup directory.


