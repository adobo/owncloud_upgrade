#!/bin/bash

mysql --default-character-set=utf8 -uowncloud7 -p owncloud7 -N -B \
    -e "SELECT f.user, MD5(REPLACE(f.path, CONCAT('/', f.user, '/files'), 'files')) AS hash,
        s.share_with, s.item_type, s.file_target, s.permissions, s.stime, s.expiration, s.token
        FROM oc_fscache f INNER JOIN oc_share s ON f.id = s.item_source"
