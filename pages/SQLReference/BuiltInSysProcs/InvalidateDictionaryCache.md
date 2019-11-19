---
title: SYSCS_UTIL.INVALIDATE_DICTIONARY_CACHE built-in system procedure
summary: Built-in system procedure that invalidates the dictionary cache on the connection's region server.
keywords: dictionary, cache
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_sysprocs_invaldictcache.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.INVALIDATE_DICTIONARY_CACHE

The `SYSCS_UTIL.INVALIDATE_DICTIONARY_CACHE` system procedure
invalidates the dictionary cache on the connection's region server.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.INVALIDATE_DICTIONARY_CACHE()
{: .FcnSyntax xml:space="preserve"}

</div>
## Results

This procedure does not return a result.

## Example

<div class="preWrapperWide" markdown="1">
    splice> CALL SYSCS_UTIL.INVALIDATE_DICTIONARY_CACHE();
    Statement executed.
{: .Example xml:space="preserve"}

</div>
## See Also

* [`SYSCS_UTIL.INVALIDATE_GLOBAL_DICTIONARY_CACHE`](sqlref_sysprocs_invalglobaldictcache.html)

</div>
</section>
