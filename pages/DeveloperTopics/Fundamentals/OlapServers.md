
## About YARN Queues, Resource Isolation, and Capacity Management


## Working with Multiple Olap Servers:

Splice Machine supports the use of multiple OLAP (analytical query processing) servers, each of which has its own YARN queue. The Splice Machine queues are role-based, which means that the role assigned to the user submitting a query defines which OLAP server will run the query.

Multiple OLAP servers are also referred to as *multiple swim lanes;* they allow you to specify how different queries are prioritized. You can take advantage of this feature to:

* Isolate certain workloads (*resource isolation*) so that they don't interfere with other workloads.
* Reserve cluster capacity for specific queries so that those queries will be blocked by other long-running queries.
* Track the resources consumed by each server/role.
* Manage resource capacity for specific kinds of queries.

## Configuring Multiple Olap Servers and Queues

Each OLAP Server and its corresponding Spark application is associated with a specific Splice Machine queue. Each queue can be associated with specific [*user roles*](tutorials_security_authorization.html).

You can configure the queues using the `splice.olap_server` properties. To associate specific roles with specific queues, use the `splice.olap_server.isolated.roles` property. For example:

```
splice.olap_server.isolated.roles=ROLE1=spliceQueue1,ROLE2=spliceQueue2,ROLE3=spliceQueue1
```
{: .Example}

You can then map each Splice Machine queue to its own YARN queue. For example:

```
splice.olap_server.queue.spliceQueue1=yarnQueue1
splice.olap_server.queue.spliceQueue2=yarnQueue2
```
{: .Example}

If you don't map a Splice Machine queue to a YARN queue, the Splice Machine queue will be mapped to the YARN default queue, `splice.olap_server.queue.default`.



### About the Default Queue


## Setting the OLAP Queue Session Property

Splice Machine defines the `olapQueue` session property. *** START HERE****


## How Splice Machine Selects a Queue for a Query

If the `olapQueue` session property is set, then Splice Machine select a queue for a query as follows:

* If the user has a role that is mapped to a specific queue, then that queue is selected; otherwise, the default queue is selected.

If the `olapQueue` session property is not set, then Splice Machine selects a query for a query as follows:

* If the user has a role for which that queue is assigned, the query is routed to that queue; otherwise, the query is routed to the default queue.

There will be an OlapServer instance (and correspoding Spark application) per Splice queue. When a user submits a Spark query it will be routed to one OlapServer based on the user's roles and his chosen olapQueue. The user can specifically choose an olapQueue by running

set session_property olapQueue='chosenQueue';

To configure queues assigned to different roles one would set the following parameter to a mapping of roles to queues:

splice.olap_server.isolated.roles=ROLE1=queue1,ROLE2=queue2,ROLE3=queue1

Then each queue can be mapped to its own YARN queue:

splice.olap_server.queue.queue1=yarnQueue1splice.olap_server.queue.queue2=yarnQueue2

There's a default queue that's also mapped to the YARN queue "default", that can be overriden:

splice.olap_server.queue.default=someOtherYarnQueue

Any queue that doesn't have it's own Yarn queue will use splice.olap_server.queue.default
