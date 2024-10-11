# wsrep-keepalived

This PoC helps you to simply use a quorum consensus approach with `wsrep` (GALERA) and `keepalived`.

## wsrep
[SST](https://galeracluster.com/library/documentation/sst.html) is a very important component of GALERA and you should keep it in mind when deploying a new cluster. There are different types of SST (logical and physical), but the most important thing is which one blocks the Donor. `wsrep` helps you with the option [`wsrep_sst_donor_rejects_queries`](https://galeracluster.com/library/documentation/mysql-wsrep-options.html#wsrep-sst-donor-rejects-queries) but this is not enough, you must select the right backend.

## keepalived
With `keepalived 2.0.0+` you can use the `track_file` function instead of `track_script` which allows a more faster convergence; in that case, `keepalived` will automatically detect the machine state of `wsrep` by reading such file content; for mor informations see [this example](examples/keepalived-2.0.0+.conf) or `keepalived`'s documentation.

Starting with commit [`6f9ace3c`](https://github.com/acassen/keepalived/commit/6f9ace3c1033d38fe282e6959e78ce58e02135ab), `keepalived` introduced microsecond timers in `track_script`; this adjustment allows a fine-grained configuration with VRRRP instances.

## Useful links
 - [codership/galera] - [state-transfers](https://galeracluster.com/library/documentation/state-transfer.html)
 - [codership/galera] - [state-snapshot-transfer](https://galeracluster.com/library/documentation/sst.html)
 - [codership/galera] - [logical-state-snapshot](https://galeracluster.com/library/documentation/sst-logical.html)
 - [codership/galera] - [physical-state-snapshot](https://galeracluster.com/library/documentation/sst-physical.html) 
 - [codership/galera] - [sst-physical-xtrabackup](https://galeracluster.com/library/documentation/sst-physical.html#sst-physical-xtrabackup)
 - [codership/galera] - [node-states](https://galeracluster.com/library/documentation/node-states.html)
 - [codership/galera] - [notification-cmd/node-status](https://galeracluster.com/library/documentation/notification-cmd.html#node-status)
 - [keepalived/manual] - [keepalived.conf](https://keepalived.org/manpage.html)
