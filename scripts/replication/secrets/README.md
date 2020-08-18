Files in this folder represent examples of various secrets which need to be tuned for a specific deployments. These are the roles of the files:
* `auth_key` - the authorization key for the REST services, ingest and export services of the Replicatin/Ingest system
* `db_root_password` - a password of the MySQL `root` account of the database service (teh Replication/Ingest system only)
* `qserv_master_db_password` - a password of the MySQL `root` account of Qserv `czar`
* `qserv_worker_db_password` - a password of the MySQL `root` account of Qserv `workers`

To set up the secreats one has to make a copy of each file, for exmaple like shown below:
```
cp auth_key.example auth_key
```
Then replace the content of the resulting file with the site-specific secret.
