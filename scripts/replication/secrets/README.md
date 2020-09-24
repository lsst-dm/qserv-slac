Files in this folder represent various secrets which need to be tuned for specific deployments. These are the roles of the files which are required by each deployment:
* `auth_key` - the authorization key for the REST services, ingest and export services of the Replicatin/Ingest system
* `db_root_password` - a password of the MySQL `root` account of the database service (the Replication/Ingest system only)
* `qserv_master_db_password` - a password of the MySQL `root` account of Qserv `czar`
* `qserv_worker_db_password` - a password of the MySQL `root` account of Qserv `workers`

To set up deployment-specific secrets one has to make a copy of the corresponding "example" file:
```
cp auth_key.example auth_key
```
Then replace the content of the resulting file with the site-specific secret.
