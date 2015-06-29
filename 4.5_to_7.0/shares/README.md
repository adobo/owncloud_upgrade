Instructions
============

Change all scripts to reflect your actual ownCloud database names, users and
passwords.

Shares backup
-------------

Run this against your old ownCloud database:

```
./dump_shares.sh > shares_45
```

Shares restore
-------------

Run this after scanning all your user files:

```
./dump_70_storages.sh > storages_70
./get_new_file_ids.sh > file_ids_70
./generate_updates.pl storages_70 file_ids_70 shares_45
```

The `generate_updates.pl` script connects to the database and executes all 
required SQL queries.
