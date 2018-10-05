---
title: Restarting Your Database
summary: Best practices for restarting your database
keywords: importing
toc: false
product: all
sidebar: bestpractices_sidebar
permalink: bestpractices_onprem_restarts.html
folder: BestPractices
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Restarting Your Splice Machine Database


This section contains best practice and troubleshooting information related to restarting Splice Machine after a forced or unexpected shutdown, in these topics:

* [Restarting Splice Machine after an HMaster Failure](#HMasterRestart)
* [Slow Restart After Forced Shutdown](#ForcedShutdown)

{% include splice_snippets/onpremonlytopic.md %}

## Restarting Splice Machine After HMaster Failure {#HMasterRestart}

If you run Splice Machine without redundant HMasters, and you lose your HMaster, follow these steps to restart Splice Machine:

1. Restart the HMaster node
2. Restart every HRegion Server node

## Slow Restart After Forced Shutdown {#ForcedShutdown}

We have seen a situation where HMaster doesn't exit when you attempt a shutdown, and a forced shutdown is used. The forced shutdown means that HBase may not be able to flush all data and delete all write-ahead logs (WALs); as a result, it can take longer than usual to restart HBase and Splice Machine.

Splice Machine now sets the HBase *Graceful Shutdown Timeout* to 10 minutes, which should be plenty of time. If the shutdown is still hanging up after 10 minutes, a forced shutdown is appropriate.

</div>
</section>
