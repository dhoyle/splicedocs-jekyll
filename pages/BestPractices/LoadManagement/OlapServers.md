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

Multiple OLAP servers are sometimes referred to as *multiple swim lanes;* they allow you to specify how different queries are prioritized into lanes. You can take advantage of this feature to:

* Isolate certain workloads (*resource isolation*) so that they don't interfere with other workloads.
* Reserve cluster capacity for specific queries so that those queries will not  be blocked by other long-running queries.
* Track the resources consumed by each server/role.
* Manage resource capacity for specific kinds of queries.


## A Brief Overview of YARN Schedulers and Queues

The YARN *ResourceManager* keeps track of the resources on your cluster, assigning them to applications that need them. The Resource Manager uses a policy-driven scheduler when sharing resources; YARN provides a choice of queue-based schedulers and configurable policies:

* The _FIFO scheduler_ is a simple first-in, first-out scheduler that runs jobs in the order of submission.
* The _Fair scheduler_ is a policy that enables the allocation of resources to applications in a way that all applications get, on average, an equal share of the cluster resources over a given period.
* The _Capacity scheduler_ allows you to share cluster resources in a simple, predictable fashion by using job queues whose resource allocation you can preconfigure.


### About the Fair Scheduler

The YARN Fair Scheduler enables the allocation of resources to applications in a way that all applications get, on average, an equal share of the cluster resources over a given time period:

* If one app is running on the cluster, it can request all resources for its execution. When other apps are submitted, the free resources are distributed such that each app gets a fairly equal share of cluster resources.
* Fair scheduling ensures that every queue gets a minimum share of the cluster resources, and excess resources are distributed equally among the running apps.

### About the Capacity Scheduler
The YARN Capacity Scheduler uses hierarchically organized queues, with the topmost queue as the root/parent of the queues for your cluster. Each queue is configured with two values:

* The *minimum capacity* value specifies the smallest amount of resources a single user should get access to upon request.
* The maximum capacity is defined by the *user limit factor* and limits the maximum amount of resources a single user can consume.

The minimum capacity percentage of the child queues at any single level in the hierarchy always add up to 100%. Here's a simple example:

<img src="images/yarnqueues1.png" class="indentedTightSpacing" alt="Yarn queue hierarchy example">

Your cluster administrator can configure your YARN queues to accommodate your organization's typical workflows.

## Splice Machine Queues

You can define Splice Machine queues and map those queues to YARN queues. This allows you to create *swim lanes* that are intended for different kinds of database operations, or for queries that are run by different kinds of users. You can use Splice Machine queues with both _Fair Scheduler_ and _Capacity Scheduler_ queues.

Splice Machine queues are role-based: the roles assigned to a user define which queue(s) will used for that user's queries. Here's a simple illustration:

<img src="images/OlapServerQueues1.png" class="indentedTightSpacing" alt="Splice Machine Role-Based OLAP Queues">

## Configuring Multiple Olap Servers and Queues

Each OLAP Server and its corresponding Spark application is associated with a specific Splice Machine queue. Each queue can be associated with specific [*user roles*](tutorials_security_authorization.html).

You can configure the queues using the `splice.olap_server` properties. To associate specific roles with specific queues, use the `splice.olap_server.isolated.roles` property. For example:

```
splice.olap_server.isolated.roles=ROLE1=spliceQueue1,ROLE2=spliceQueue2,ROLE3=spliceQueue1
```
{: .Example}

You can then map each Splice Machine queue to its own YARN queue. For example:

```
splice.olap_server.queue.spliceQueue1=root.YarnQueue1
splice.olap_server.queue.spliceQueue2=root.YarnQueue2
```
{: .Example}

You can also specify a dedicated queue to use for compaction jobs by setting the following property value to `true` (the default value is `false`):
```
splice.olap_server.isolated.compaction=true
```
{: .Example}

You can also configure the name of the dedicated compaction queue with the following property:
```
splice.olap_server.isolated.compaction.queue_name=myCompactionQueue
```
{: .Example}

### About the Default Queue

YARN defines a `default` queue, which handles jobs that are not assigned to a specific queue.

Splice Machine also defines a default queue, `splice.olap_server.queue.default`. This queue is initially mapped to the YARN `default` queue; however, you can override that and map it to a different YARN queue; for example:

```
splice.olap_server.queue.default=root.someYarnQueue
```
{: .Example}

If you don't map a Splice Machine queue to a YARN queue, that Splice Machine queue will be mapped to the YARN `default` queue.
{: .noteIcon}

### OLAP Queue Properties Summary

The following table summarizes the property values you can use to configure your OLAP servers.

<table>
    <col width="65%"/>
    <col />
    <thead>
        <tr>
            <th>Property</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><p><span class="CodeFont">splice.olap_server.isolated.roles</span></p>
                <p>Example:</p>
                <pre class="Example">splice.olap_server.isolated.roles=ROLE1=spliceQueue1,ROLE2=spliceQueue2,ROLE3=spliceQueue1</pre>
            </td>
            <td><p>A string value that specifies which Splice Machine queue to use for each role. You can specify multiple role/queue pairs, as shown in the example.</p>
            </td>
        </tr>
        <tr>
            <td><p><span class="CodeFont">splice.olap_server.queue.</span><span class="HighlightedCode">&lt;queueName&gt;</span></p>
                <p>Example:</p>
                <pre class="Example">splice.olap_server.queue.spliceQueue1=YarnQueue1</pre>
            </td>
            <td><p>A string value that maps the Splice Machine queue name to a YARN queue name.</p>
                <p><em>Default value:</em> the default YARN queue.</p>
            </td>
        </tr>
        <tr>
            <td><p><span class="CodeFont">splice.olap_server.queue.default</span></p>
                <p>Example:</p>
                <pre class="Example">splice.olap_server.queue.default=myDefaultYarnQueue</pre>
            </td>
            <td><p>A string value that specifies the name of the YARN queue to use for jobs that are not assigned to a specific queue.</p>
                <p><em>Default value:</em> the default YARN queue.</p>
            </td>
        </tr>
        <tr>
            <td><p><span class="CodeFont">splice.olap_server.isolated.compaction</span></p>
                <p>Example:</p>
                <pre class="Example">splice.olap_server.isolated.compaction=true</pre>
            </td>
            <td><p>A Boolean value that specifies whether a dedicated compaction queue should be used.</p>
                <p><em>Default value:</em> <code>false</code>.</p>
            </td>
        </tr>
        <tr>
            <td><p><span class="CodeFont">splice.olap_server.isolated.compaction.queue_name</span></p>
                <p>Example:</p>
                <pre class="Example">splice.olap_server.isolated.compaction.queue_name=myCompactionQueue</pre>
            </td>
            <td><p>A string value that names the dedicated compaction queue.</p>
                <p><em>Default value:</em> <code>compaction</code>.</p>
            </td>
        </tr>
    </tbody>
</table>


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
