#!/bin/bash -x
docker exec -it postgres /usr/bin/psql postgres postgres -c "ALTER TABLE message ALTER COLUMN payload_ TYPE text;"
