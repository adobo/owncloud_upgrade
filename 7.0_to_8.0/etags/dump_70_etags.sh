#!/bin/bash

mysql --default-character-set=utf8 -uowncloud7 -p owncloud7 -N -B \
    -e "SELECT s.id, f.path_hash, f.etag FROM oc_filecache f INNER JOIN oc_storages s ON f.storage = s.numeric_id"
