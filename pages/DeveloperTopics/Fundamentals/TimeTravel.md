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

This topic describes the Splice Machine *Time Travel* mechanism, which you can use to query data in your database as it existed at some point in the past.

You can issue these *point-in-time* queries using the *AS OF* option in `SELECT` statements. For example, if you use the following query to determine a customer's home phone number:

```
splice> SELECT home_phone FROM customer WHERE cust_id = 1020;
splice> (555) 555-1212
```
{: .Example}

Then you could use the following query to find what the same customer's home phone number was as of a previous date:

```
splice> SELECT home_phone FROM customer WHERE cust_id = 1020 AS OF `2019-01-20`;
splice> (555) 555-1234
```
{: .Example}

## Enabling Time Travel

Time Travel is disabled by default. You can enable it on a per-table basis. You can also specify the time period for which historical information is available for point-in-time queries.

<span class="Highlighted">TBD: Configuration details, including cost/performance considerations.</span>

</div>
</section>
