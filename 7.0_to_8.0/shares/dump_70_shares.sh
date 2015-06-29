#!/bin/bash

mysql --default-character-set=utf8 -uowncloud7 -p owncloud7 -N -B \
    -e "SELECT st.id, f.path_hash, s.share_type, s.share_with, s.uid_owner, s.parent, s.item_type,
        s.file_target, s.permissions, s.stime, s.accepted, s.expiration, s.token, s.mail_send
        FROM oc_share s JOIN oc_filecache f JOIN oc_storages st ON f.fileid = s.file_source
        AND f.storage = st.numeric_id"
