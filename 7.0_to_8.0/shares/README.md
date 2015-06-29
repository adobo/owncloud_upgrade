Instructions
============

Change all scripts to reflect your actual ownCloud database names, users and
passwords.

Shares backup
-------------

Run this against your old ownCloud database:

```
./dump_shares.sh > shares_70
```

Shares restore
-------------

Run this after scanning all your user files:

```
./dump_80_storages.sh > storages_80
./get_new_file_ids.sh > file_ids_80
./generate_updates.pl storages_80 file_ids_80 shares_70
```

The `generate_updates.pl` script connects to the database and executes all 
required SQL queries.
