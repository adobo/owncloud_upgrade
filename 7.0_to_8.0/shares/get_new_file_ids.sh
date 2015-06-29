#!/bin/bash

mysql --default-character-set=utf8 -uowncloud8 -p owncloud8 -N -B \
    -e "SELECT storage, path_hash, fileid FROM oc_filecache"
