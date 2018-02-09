---
title: SYSCS_UTIL.SYSCS_GET_VERSION_INFO built-in system procedure
summary: Built-in system procedure that returns information about the version of Splice Machine that is installed on each server in your cluster.
keywords: get version info, get_version_info
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_getversioninfo.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.SYSCS_GET_VERSION_INFO

The `SYSCS_UTIL.SYSCS_GET_VERSION_INFO` system procedure displays the
version of Splice Machine installed on each node in your cluster.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.SYSCS_GET_VERSION_INFO()
{: .FcnSyntax xml:space="preserve"}

</div>
## Results

This procedure does not return a result.

## Example

<div class="preWrapperWide" markdown="1">
    splice> call SYSCS_UTIL.SYSCS_GET_VERSION_INFO();
    HOSTNAME       |RELEASE            |IMPLEMENT&|BUILDTIME              |URL
    --------------------------------------------------------------------------------------------------
    localhost:52897|2.5.0.1708-SNAPSHOT|85caa07187|2017-02-25 04:56 +0000 |http://www.splicemachine.com

    1 row selected
{: .Example xml:space="preserve"}

</div>
</div>
</section>
