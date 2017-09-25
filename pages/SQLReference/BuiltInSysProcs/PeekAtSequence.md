---
title: SYSCS_PEEK_AT_SEQUENCE built-in system function
summary: Built-in system function that allows users to observe the current value of a sequence generator without querying a system table
keywords: peek_at_sequence, peek, sequence
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_peekatseq.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.SYSCS_PEEK_AT_SEQUENCE Function   {#BuiltInSysFcns.PeekAtSequence}

The `SYSCS_UTIL.SYSCS_PEEK_AT_SEQUENCE` function allows users to observe
the instantaneous current value of a sequence generator without having
to query the [`SYSSEQUENCES` system
table](sqlref_systables_syssequences.html).

Querying the `SYSSEQUENCES` table does not actually return the current
value; it only returns an upper bound on that value, which is the end of
the chunk of sequence values that has been pre-allocated but not yet
used.

The `SYSCS_UTIL.SYSCS_PEEK_AT_SEQUENCE` function shows you the very next
value that will be returned by a `NEXT VALUE FOR` clause. Users should
never directly query the `SYSSEQUENCES` table, because that will cause
sequence generator concurrency to slow drastically.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    BIGINT SYSCS_UTIL.SYSCS_PEEK_AT_SEQUENCE(
    			IN SchemaName VARCHAR(128),
    			IN SequenceName VARCHAR(128)
    			)
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
SchemaName
{: .paramName}

The name of the schema.
{: .paramDefnFirst}

SequenceName
{: .paramName}

The name of the sequence.
{: .paramDefnFirst}

</div>
## Results

Returns the next value that will be returned for the sequence.

## Execute Privileges

By default, all users have execute privileges on this function.

## Example

<div class="preWrapperWide" markdown="1">
    splice> VALUES SYSCS_UTIL.SYSCS_PEEK_AT_SEQUENCE('SPLICE', 'PlayerID_seq');
{: .Example xml:space="preserve"}

</div>
## See Also

* [`SYSSEQUENCES`](sqlref_systables_syssequences.html) system table

</div>
</section>

