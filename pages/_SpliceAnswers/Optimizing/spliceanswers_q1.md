---
title: How do I know if my query is running?
summary: How to know if your Splice Machine query is currently running
keywords: optimization
toc: false
compatible_version: 2.7
product: all
category: Optimizing
sidebar: home_sidebar
permalink: spliceanswers_q1.html
folder: SpliceAnswers/Optimizing
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

# How do I know if my query is running?
This topic shows you how to determine if your Splice Machine query is currently running.

## Applies When?
Always.

## Answer: Use This System Procedure
You can call the `GET_RUNNING_OPERATIONS` system procedure, which displays the status of each currently running query, including in which engine (Control or Spark) each is running, and how much time has elapsed since the query was submitted. For example:

```
splice> CALL SYSCS_UTIL.SYSCS_GET_RUNNING_OPERATIONS();

|UUID                                    |USER     |HOSTNAME              |SESSION |SQL                                                           |SUBMITTED           |ELAPSED   |ENGINE |JOBTYPE            |
|34b0f479-be9a-4933-9b4d-900af218a19c    |SPLICE   |MacBookPro.local:1527 |264     |select * from sys.systables --splice-properties useSpark=true |2018-02-02 17:39:05 |26 sec(s) |SPARK  |Produce Result Set |
|4099f016-3c9d-4c62-8059-ff18d3b38a19    |SPLICE   |MacBook-Pro.local:1527|4       |call syscs_util.syscs_get_running_operations()                |2018-02-02 17:39:31 |0 sec(s)  |CONTROL|Call Procedure     |

2 rows selected
```
{: .Example}

## Related Questions:

* [When will my query finish?](spliceanswers_q2.html)

## Questions That Link to This Topic:

N/A

</div>
</section>
