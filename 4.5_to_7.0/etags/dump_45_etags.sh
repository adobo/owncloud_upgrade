#!/bin/bash

mysql --default-character-set=utf8 -uowncloud45 -p owncloud45 -N -B \
    -e "SELECT userid, CONCAT('files', propertypath) as path,
        MD5(CONCAT('files', propertypath)) as path_hash, REPLACE(propertyvalue, '\"', '')
        FROM oc_properties WHERE propertyname = '{DAV:}getetag'"
