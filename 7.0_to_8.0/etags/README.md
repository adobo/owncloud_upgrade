Instructions
============

Change all scripts to reflect your actual ownCloud database names, users and
passwords.

ETags backup
------------

Run this against your old ownCloud database:

```
./dump_70_etags.sh > etags_70
```

ETags restore
-------------

Run this after scanning all your user files:

```
./dump_80_storages.sh > storages_80
./generate_updates.pl storages_80 etags_70 > restore_etags.sql
 cat restore_etags.sql | mysql --default-character-set=utf8 -uowncloud8 -p owncloud8
```
