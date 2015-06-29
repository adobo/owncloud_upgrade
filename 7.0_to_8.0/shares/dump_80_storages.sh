#!/bin/bash

mysql -uowncloud8 -p owncloud8 -N -B \
    -e "SELECT numeric_id, id FROM oc_storages"
