# wsrep-keepalived

This PoC helps you to simply use a quorum consensus approach with `wsrep` (GALERA) and `keepalived`.

[SST](https://galeracluster.com/library/documentation/sst.html) is a very important component of GALERA and you should keep it in mind when deploying a new cluster. There are different types of SST (logical and physical), but the most important thing is which one blocks the Donor. `wsrep` helps you with the option [`wsrep_sst_donor_rejects_queries`](https://galeracluster.com/library/documentation/mysql-wsrep-options.html#wsrep-sst-donor-rejects-queries) but this is not enough, you must select the right backend.

## Useful links
 - [codership/galera] - [state-transfers](https://galeracluster.com/library/documentation/state-transfer.html)
 - [codership/galera] - [state-snapshot-transfer](https://galeracluster.com/library/documentation/sst.html)
 - [codership/galera] - [logical-state-snapshot](https://galeracluster.com/library/documentation/sst-logical.html)
 - [codership/galera] - [physical-state-snapshot](https://galeracluster.com/library/documentation/sst-physical.html) 
 - [codership/galera] - [sst-physical-xtrabackup](https://galeracluster.com/library/documentation/sst-physical.html#sst-physical-xtrabackup)
 - [codership/galera] - [node-states](https://galeracluster.com/library/documentation/node-states.html)
 - [codership/galera] - [notification-cmd/node-status](https://galeracluster.com/library/documentation/notification-cmd.html#node-status)
