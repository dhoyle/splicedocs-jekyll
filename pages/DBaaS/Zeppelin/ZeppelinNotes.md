---
summary: Notes About Using Zeppelin
title: Zeppelin Usage Notes
keywords: zep, notebook, dbaas, paas, classpath
sidebar: getstarted_sidebar
toc: false
product: dbaas
permalink: dbaas_zep_notes.html
folder: DBaaS/Zeppelin
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Zeppelin Usage Notes

This page currently contains exactly one tip about using Zeppelin with the
Splice Machine database service; this will grow into a loose collection of tips over
time.

## Use Full Classpath!

If you're coding a Zeppelin notebook in Java, you must specify the full
class of imported classes, such as `java.sql.Timestamp`; otherwise, an
error occurs.

For example, this generates an error:

<div class="preWrap" markdown="1">
    %spark
    import java.util.Date
    import java.sql.
    {Connection, Timestamp}
    classOfTimestamp
    classOffoo
    val tt = Timestamp.valueOf("2261-12-31 00:00:00")
    class foo extends Object { val xx: Timestamp = Timestamp.valueOf("2261-12-31 00:00:00") }

    import java.util.Date
    import java.sql.{Connection, Timestamp}
    res12: Classjava.sql.Timestamp = class java.sql.Timestamp
    res13: Classfoo = class foo
    tt: java.sql.Timestamp = 2261-12-31 00:00:00.0
    <console>:13: error: not found: type Timestamp
    val xx: Timestamp = Timestamp.valueOf("2261-12-31 00:00:00")
    ^
    <console>:13: error: not found: value Timestamp
    val xx: Timestamp = Timestamp.valueOf("2261-12-31 00:00:00")
    ^
    ERROR
{: .Example}

</div>
The error is resolved by specifying the full classpath:
{: .spaceAbove}

<div class="preWrap" markdown="1">
    %spark
    import java.util.Date
    import java.sql.
    {Connection, Timestamp}
    classOfTimestamp
    classOffoo
    val tt = Timestamp.valueOf("2261-12-31 00:00:00")
    class foo extends Object { val xx: java.sql.Timestamp = java.sql.Timestamp.valueOf("2261-12-31 00:00:00") }

    import java.util.Date
    import java.sql.{Connection, Timestamp}
    res14: Classjava.sql.Timestamp = class java.sql.Timestamp
    res15: Classfoo = class foo
    tt: java.sql.Timestamp = 2261-12-31 00:00:00.0
    defined class foo
    FINISHED
{: .Example}

</div>
</div>
</section>
