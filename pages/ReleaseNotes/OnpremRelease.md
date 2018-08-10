---
title: On-Premise Product Release Notes
summary: Splice Machine On-Premise Product Release Notes
keywords: release notes, on-premise
toc: false
product: all
sidebar:  releasenotes_sidebar
permalink: releasenotes_onprem.html
folder: ReleaseNotes
---
{% include splicevars.html %}
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Release Notes for the Splice Machine On-Premise Product

This topic includes release notes that are specific to the Splice Machine *On-Premise Database* product, in these sections:

* [Supported Platforms](#supported-platforms)
* [Enterprise-only Features](#enterprise-only-features)
* [Running the Standalone Version](#running-the-standalone-version)

Most of the information about changes in the Splice Machine database that underlies this product are found in the individual release note pages for each major and patch release of the database.

## After Updating

After updating to a new release of Splice Machine, you may need to update your stored statement metadata by calling these system procedures:

<div class="preWrapperWide"><pre class="Example">
CALL <a href="sqlref_sysprocs_emptyglobalcache.html">SYSCS_UTIL.SYSCS_EMPTY_GLOBAL_STATEMENT_CACHE();</a>
CALL <a href="sqlref_sysprocs_invalidatestoredstmts.html">SYSCS_UTIL.SYSCS_INVALIDATE_STORED_STATEMENTS();</a>
CALL <a href="sqlref_sysprocs_updatemetastmts.html">SYSCS_UTIL.SYSCS_UPDATE_METADATA_STORED_STATEMENTS();</a>
</pre></div>

## Supported Platforms {#supported-platforms}
The supported platforms for release {{site.build_version}} are:

* {{splvar_requirements_CDH-Versions}}
* MapR 5.2.0
* HortonWorks HDP2.6.4,  2.6.3, 2.5.5

## Enterprise-only Features {#enterprise-only-features}
Some features only work on the *Enterprise Edition* of Splice Machine; they __do not__ work on the Community Edition of Splice Machine. To obtain a license for the Splice Machine *Enterprise Edition*, please [Contact Splice Machine Sales](http://www.splicemachine.com/company/contact-us/)
today.

These are the enterprise-only features in our *On-Premise Database*:

* Backup/Restore
* LDAP integration
* Column-level user privileges
* Kerberos enablement
* Encryption at rest


## Running the Standalone Version {#running-the-standalone-version}
The supported operating systems for the STANDALONE release of Splice Machine are:

* Mac OS X (10.8 or greater)
* Centos (6.4 or equivalent)

</div>
</section>
