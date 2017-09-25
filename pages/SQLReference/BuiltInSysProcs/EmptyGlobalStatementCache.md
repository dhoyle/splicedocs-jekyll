---
title: SYSCS_UTIL.SYSCS_EMPTY_GLOBAL_STATEMENT_CACHE built-in system procedure
summary: Built-in system procedure that removes as many compiled statements (plans) as possible from the database-wide statement cache (across all region servers).
keywords: statement cache, empty statement cache, empty_statement_cache
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_emptyglobalcache.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.SYSCS_EMPTY_GLOBAL_STATEMENT_CACHE   {#BuiltInSysProcs.EmptyStatementCache}

The `SYSCS_UTIL.SYSCS_EMPTY_GLOBAL_STATEMENT_CACHE` stored procedure
removes as many compiled statements (plans) as possible from the
database-wide statement cache (across all region servers).This procedure
does not remove statements related to currently executing queries or to
activations that are about to be garbage collected, so the cache is not
guaranteed to be completely empty after it completes.

The related procedure
[`SYSCS_UTIL.SYSCS_EMPTY_STATEMENT_CACHE`](sqlref_sysprocs_emptycache.html) performs
the same operation on a single region server.
{: .noteNote}

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.SYSCS_EMPTY_GLOBAL_STATEMENT_CACHE()
{: .FcnSyntax xml:space="preserve"}

</div>
## Results

This procedure does not return a result.

## Execute Privileges

If authentication and SQL authorization are both enabled, only the
database owner has execute privileges on this function by default. The
database owner can grant access to other users.

## JDBC Example

<div class="preWrapper" markdown="1">
    CallableStatement cs = conn.prepareCall
      ("CALL SYSCS_UTIL.SYSCS_EMPTY_GLOBAL_STATEMENT_CACHE()");
      cs.execute();
      cs.close();
{: .Example xml:space="preserve"}

</div>
## SQL Example

<div class="preWrapper" markdown="1">
    splice> CALL SYSCS_UTIL.SYSCS_EMPTY_GLOBAL_STATEMENT_CACHE();
    Statement executed.
{: .Example xml:space="preserve"}

</div>
## See Also

* [`SYSCS_UTIL.SYSCS_EMPTY_STATEMENT_CACHE`](sqlref_sysprocs_emptycache.html)
* [`SYSCS_UTIL.SYSCS_INVALIDATE_STORED_STATEMENTS`](sqlref_sysprocs_invalidatestoredstmts.html)

</div>
</section>

