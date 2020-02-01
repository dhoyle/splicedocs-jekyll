---
title: Using Splice Machine Time Travel
summary: Describes the time travel mechanism.
keywords: select, time travel
toc: false
product: all
sidebar: home_sidebar
permalink: developers_fundamentals_timetravel.html
folder: DeveloperTopics/Fundamentals
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Using Time Travel

This topic describes the Splice Machine *Time Travel* mechanism, which you can use to query data in your database as it existed at some point in the past. To do so, you provide the snapshot/transaction ID for the date/time at which you want to query, in your connection URL. For example:

```
connect 'jdbc:splice://localhost:1527/splicedb;user=myUserId;password=myPswd;snapshot=15798'
```
{: .Example}

You can find the transaction ID in one of two ways:

* For a running transaction, you can call the &nbsp;[`SYSCS_UTIL.SYSCS_GET_CURRENT_TRANSACTION()`](sqlref_sysprocs_getcurrenttransaction.html)

* For a previously run transaction, you can use one of these options:
  * Find it in the `splice` logs.
  * Find it in the Spark UI.
  * Use the &nbsp;[`SYSCS_UTIL.SYSCS_GET_RUNNING_OPERATIONS()`](sqlref_sysprocs_getrunningops.html) system procedure.

{% comment %}
## Enabling Time Travel

Time Travel is disabled by default. You can enable it on a per-table basis. You can also specify the time period for which historical information is available for point-in-time queries.

<span class="Highlighted">TBD: Configuration details, including cost/performance considerations.</span>

{% endcomment %}

</div>
</section>
