Instructions
============

Change all scripts to reflect your actual ownCloud database names.


ETags backup
------------

Run this against your old ownCloud database:

```
./dump_45_etags.sh > etags_45
```

ETags restore
-------------

Run this after scanning all your user files:

```
./dump_70_storages.sh > storages_70
./generate_updates.pl storages_70 etags_45 > restore_etags.sql
 cat restore_etags.sql | mysql --default-character-set=utf8 -uowncloud7 -p owncloud7
```
