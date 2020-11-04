---
title: AS OF clause
summary: The `AS OF` clause returns data from tables as it existed at the time of a specified Transaction ID or timestamp.
keywords: as of, transaction ID, time travel
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_clauses_asof.html
folder: SQLReference/Clauses
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# AS OF

The `AS OF` clause is an optional element of the &nbsp;[`SELECT`](sqlref_statements_select.html) statement and can also be used in a [`SELECT Expression`](sqlref_expressions_select.html).

The `AS OF` clause returns data from tables as it existed at the time of a specified Transaction ID or timestamp.

## Syntax

<div class="fcnWrapperWide"><pre class="FcnSyntax">
AS OF [ <a href="sqlref_identifiers_types.html#txnId">transactionID</a> ]
      [ <a href="sqlref_datatypes_timestamp.html">TIMESTAMP</a> ]
</pre>
</div>

<div class="paramList" markdown="1">
transactionID
{: .paramName}

The ID of a completed transaction. You can find the transaction ID of a specific SQL statement in the <code>splice-derby.log</code> file. You can also use <a href="sqlref_sysprocs_getcurrenttransaction.html"><code>GET_CURRENT_TRANSACTION</code></a> to note a transaction ID for future reference.
{: .paramDefnFirst}

<div class="paramList" markdown="1">
TIMESTAMP
{: .paramName}

The <a href="sqlref_datatypes_timestamp.html"><code>TIMESTAMP</code></a> data type references a specific date and time.
{: .paramDefnFirst}

</div>

## Examples

Select from single table using `TIMESTAMP`:

<div class="preWrapper" markdown="1">
  SELECT * FROM TABLE_1 AS OF TIMESTAMP('2020-09-15 19:13:33.00');
{: .Example xml:space="preserve"}

</div>

Select from single table using transaction ID:

<div class="preWrapper" markdown="1">
  SELECT * FROM TABLE_1 AS OF 151044864;
{: .Example xml:space="preserve"}

</div>


Select from multiple tables:

<div class="preWrapper" markdown="1">

  SELECT * FROM TABLE_1 L AS OF 151047680,
  TABLE_2 R AS OF 151057664
  ORDER BY 1,2;
{: .Example xml:space="preserve"}

</div>


Create a new table:

<div class="preWrapper" markdown="1">
  CREATE TABLE TABLE_3 AS
  SELECT * FROM TABLE_1 AS OF 151318272
  WITH DATA;
{: .Example xml:space="preserve"}

</div>

## See Also

* [`SELECT`](sqlref_statements_select.html) statement
* [`SELECT Expression`](sqlref_expressions_select.html) statement

</div>
</section>
