---
title: Splice Machine Best Practices - Software Updates
summary: Best practices for importing data
keywords: importing
toc: false
product: all
sidebar: bestpractices_sidebar
permalink: bestpractices_onprem_updating.html
folder: BestPractices
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Best Practices for Updating Your Splice Machine Software


This section contains best practice and troubleshooting information related to updating your Splice Machine *On-Premise Database* product software, in these topics:

* [Updating Stored Query Plans after a Splice Machine Update](#SpliceUpdate)

{% include splice_snippets/onpremonlytopic.md %}

## Updating Stored Query Plans after a Splice Machine Update {#SpliceUpdate}

When you install a new version of your Splice Machine software, you may need to
make these calls:

<div class="preWrapperWide"><pre class="Example">
CALL <a href="sqlref_sysprocs_emptyglobalcache.html">SYSCS_UTIL.SYSCS_EMPTY_GLOBAL_STATEMENT_CACHE();</a>
CALL <a href="sqlref_sysprocs_invalidatestoredstmts.html">SYSCS_UTIL.SYSCS_INVALIDATE_STORED_STATEMENTS();</a>
CALL <a href="sqlref_sysprocs_updatemetastmts.html">SYSCS_UTIL.SYSCS_UPDATE_METADATA_STORED_STATEMENTS();</a>
</pre></div>

These calls will update the stored metadata query plans and purge the statement cache, which is required because the query plan APIs have changed. This is true for both minor (patch) releases and major new releases.

</div>
</section>
