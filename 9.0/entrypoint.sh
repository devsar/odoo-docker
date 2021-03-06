#!/bin/bash

set -e

# set odoo database host, port, user and password
: ${PGHOST:=$DB_PORT_5432_TCP_ADDR}
: ${PGPORT:=$DB_PORT_5432_TCP_PORT}
: ${PGUSER:=${DB_ENV_POSTGRES_USER:='postgres'}}
: ${PGPASSWORD:=$DB_ENV_POSTGRES_PASSWORD}

#Give permissions to odoo if mounted externally
chown -R odoo /var/lib/odoo

export PGHOST PGPORT PGUSER PGPASSWORD

case "$1" in
    --)
	shift
	exec gosu odoo openerp-server "$@"
	;;
    -*)
	exec gosu odoo openerp-server "$@"
	;;
    openerp-server)
	exec gosu odoo "$@"
	;;
    *)
	exec "$@"
esac

exit 1
