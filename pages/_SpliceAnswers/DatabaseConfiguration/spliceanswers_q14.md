---
title: How can I flush memstore for a specific table?
summary: Flushing memstore for a Splice Machine table
keywords:
toc: false
compatible_version: 2.7
product: all
category: Database Configuration
sidebar: home_sidebar
permalink: spliceanswers_q14.html
folder: SpliceAnswers/DatabaseConfiguration
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

# How can I flush memstore for a specific table?

## Applies When?
Always.

## Answer:

You can flush memstore for a specific Splice Machine table directly from Splice Machine, by calling the `Flush_Table` system procedure. For example:

```
CALL SYSCS_UTIL.SYSCS_FLUSH_TABLE( mySchema, myTable );
```
{: .Example}


## Related Questions:

## Questions That Link to This Topic:



</div>
</section>
