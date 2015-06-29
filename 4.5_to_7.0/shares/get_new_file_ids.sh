#!/bin/bash

mysql --default-character-set=utf8 -uowncloud7 -p owncloud7 -N -B \
    -e "SELECT storage, path_hash, fileid FROM oc_filecache"
