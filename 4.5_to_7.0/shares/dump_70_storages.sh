#!/bin/bash

mysql -uowncloud7 -p owncloud7 -N -B \
    -e "SELECT numeric_id, id FROM oc_storages"
