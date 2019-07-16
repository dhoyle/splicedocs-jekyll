---
title: Working with Application Server Queues
summary: Configuring application server queues
keywords: YARN, queues
toc: false
product: all
sidebar: home_sidebar
permalink: bestpractices_appservers_intro.html
folder: BestPractices/LoadManagement
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

# Working with Application Server Queues

Splice Machine supports the use of multiple OLAP (analytical query processing) servers, each of which has its own YARN queue. The Splice Machine queues are role-based, which means that the role assigned to the user submitting a query defines which OLAP server will run the query.

Multiple OLAP servers are also referred to as *multiple swim lanes;* they allow you to specify how different queries are prioritized into lanes. You can take advantage of this feature to:

* Isolate certain workloads (*resource isolation*) so that they don't interfere with other workloads.
* Reserve cluster capacity for specific queries so that those queries will be blocked by other long-running queries.
* Track the resources consumed by each server/role.
* Manage resource capacity for specific kinds of queries.


## A Brief Overview of YARN Queues

YARN includes a queue-based *capacity scheduler*. YARN Queues are organized hierarchically, with the topmost queue as the root/parent of the queues for your cluster. Each queue is configured with two values:

* The *minimum capacity* value specifies the smallest amount of resources a single user should get access to upon request.
* The maximum capacity is defined by the *user limit factor* and limits the maximum amount of resources a single user can consume.

The minimum capacity percentage of the child queues at any single level in the hierarchy always add up to 100%. Here's a simple example:

<img src="images/yarnqueues1.png" class="indentedTightSpacing" alt="Yarn queue hierarchy example">

Your cluster administrator can configure your YARN queues to accommodate your organization's typical workflows.

### Splice Machine Queues

You can define Splice Machine queues and map those queues to YARN queues. This allows you to create *swim lanes* that are intended for different kinds of database operations, or for queries that are run by different kinds of users.

Splice Machine queues are role-based: the roles assigned to a user define which queue(s) will used for that user's queries.


## Configuring Multiple Olap Servers and Queues

Each OLAP Server and its corresponding Spark application is associated with a specific Splice Machine queue. Each queue can be associated with specific [*user roles*](tutorials_security_authorization.html).

You can configure the queues using the `splice.olap_server` properties. To associate specific roles with specific queues, use the `splice.olap_server.isolated.roles` property. For example:

```
splice.olap_server.isolated.roles=ROLE1=spliceQueue1,ROLE2=spliceQueue2,ROLE3=spliceQueue1
```
{: .Example}

You can then map each Splice Machine queue to its own YARN queue. For example:

```
splice.olap_server.queue.spliceQueue1=YarnQueue1
splice.olap_server.queue.spliceQueue2=YarnQueue2
```
{: .Example}

### About the Default Queue

YARN defines a `default` queue, which handles jobs that are not assigned to a specific queue.

Splice Machine also defines a default queue, `splice.olap_server.queue.default`. This queue is initially mapped to the YARN `default` queue; however, you can override that and map it to a different YARN queue; for example:

```
splice.olap_server.queue.default=someYarnQueue
```
{: .Example}

If you don't map a Splice Machine queue to a YARN queue, that Splice Machine queue will be mapped to the YARN `default` queue.
{: .noteIcon}


## Setting the OLAP Queue Session Property

You can use the `set_session_property` command to specify which queue to use for queries that you submit. For example:

```
splice> set session_property olapQueue='chosenQueue';
```
{: .Example}

## How Splice Machine Selects a Queue for a Query

How Splice Machine selects the queue to use for a query depends on whether or not the `olapQueue` session property is set:

<table class="oddEven">
    <col />
    <col />
    <thead>
        <tr>
            <th>Is <span class="CodeFont">olapQueue</span> set?</th>
            <th>How Splice Machine selects the queue to use:</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Yes</td>
            <td>
                <p>If the user has a role for which the assigned <code>olapQueue</code> is assigned, then the query is routed to the <code>olapQueue</code> queue.</p>
                <p>Otherwise, the query is routed to the default queue.</p>
            </td>
        </tr>
        <tr>
            <td>No</td>
            <td>
                <p>If the user has a role that is mapped to a specific queue, the query is routed to that queue.</p>
                <p>Otherwise, the query is routed to the default queue.</p>
            </td>
        </tr>
    </tbody>
</table>

</div>
</section>
