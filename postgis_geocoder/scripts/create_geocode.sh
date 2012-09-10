#!/bin/bash
PGPORT=5432
PGHOST=localhost
PGUSER=geocoder
PGPASSWORD=geocoder
PGDB=geocoder
#psql -d "$PGDB" -U $PGUSER -c "CREATE EXTENSION fuzzystrmatch"
psql -d "$PGDB" -U $PGUSER -c "CREATE SCHEMA tiger"
psql -d "$PGDB" -U $PGUSER -c "ALTER DATABASE $PGDB SET search_path=public, tiger;"
psql -d "$PGDB" -U $PGUSER -f "tables/lookup_tables_2010.sql"
psql -d "$PGDB" -U $PGUSER -c "CREATE SCHEMA tiger_data"
psql -d "$PGDB" -U $PGUSER -f "tiger_loader.sql"
psql -d "$PGDB" -U $PGUSER -f "census_loader.sql"
psql -d "$PGDB" -U $PGUSER -c "SELECT tiger.create_census_base_tables();"
psql -d "$PGDB" -U $PGUSER -f "create_geocode.sql"
psql -d "$PGDB" -U $PGUSER -c "CREATE INDEX idx_tiger_addr_least_address ON addr USING btree (least_hn(fromhn,tohn));"
