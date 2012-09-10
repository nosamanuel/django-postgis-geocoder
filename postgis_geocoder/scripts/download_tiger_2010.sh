#!/bin/bash
wget http://www2.census.gov/geo/pvs/tiger2010st/ --no-parent --relative --recursive --level=2 --accept=zip,txt --mirror --reject=html
