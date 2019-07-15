
## About Resource Isolation and Capacity Management


## Working with Multiple Olap Servers:

Splice Machine supports the use of multiple OLAP (analytical query processing) servers, each of which has its own YARN queue. The Splice Machine queues are role-based, which means that the role assigned to the user submitting a query defines which OLAP server will run the query.

Multiple OLAP servers are also referred to as *multiple swim lanes;* they allow you to specify how different queries are prioritized, which allows you to:

* Isolate certain workloads (*resource isolation*) 
resource capacity management, res

 different kinds of queries with preferential (or non-preferential) resource management and resource isolation to different query to compete for resources at dif
You can use this feature to separate workloads into different YARN queues, which you can use for:

* _Resource isolation,_ which allows you to isolate some workloads so they don't interfere with others
* _Capacity management,_ xxx
* _Resource budgeting,_ meaning that you can see the resources consumed by each server/role.


In the Resource Isolation case the customer might want to isolate some workloads so they don't interfere with others, or maybe he wants to reserve cluster capacity for some specific queries in order for them never to be blocked by long running Spark queries.


## Configuring Multiple Olap Servers and Queues

There will be an OlapServer instance (and correspoding Spark application) per Splice queue. When a user submits a Spark query it will be routed to one OlapServer based on the user's roles and his chosen olapQueue. The user can specifically choose an olapQueue by running

set session_property olapQueue='chosenQueue';

To configure queues assigned to different roles one would set the following parameter to a mapping of roles to queues:

splice.olap_server.isolated.roles=ROLE1=queue1,ROLE2=queue2,ROLE3=queue1

Then each queue can be mapped to its own YARN queue:

splice.olap_server.queue.queue1=yarnQueue1splice.olap_server.queue.queue2=yarnQueue2

There's a default queue that's also mapped to the YARN queue "default", that can be overriden:

splice.olap_server.queue.default=someOtherYarnQueue

Any queue that doesn't have it's own Yarn queue will use splice.olap_server.queue.default



### About the Default Queue


## Setting the OLAP Queue Session Property


## How Splice Machine Selects a Queue for a Query

If the `olapQueue` session property is set, then Splice Machine select a queue for a query as follows:

* If the user has a role that is mapped to a specific queue, then that queue is selected; otherwise, the default queue is selected.

If the `olapQueue` session property is not set, then Splice Machine selects a query for a query as follows:

* If the user has a role for which that queue is assigned, the query is routed to that queue; otherwise, the query is routed to the default queue.
