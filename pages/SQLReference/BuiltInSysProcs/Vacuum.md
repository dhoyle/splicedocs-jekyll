---
title: SYSCS_UTIL.VACUUM built-in system procedure
summary: Built-in system procedure that performs clean-up operations on the system.
keywords: vacuum, vacuuming, vacuum procedure
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_vacuum.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.VACUUM   {#BuiltInSysProcs.Vacuum}

The `SYSCS_UTIL.VACUUM` system procedure performs the following clean-up
operations:

1.  Waits for all previous transactions to complete; at this point, it
    must be all. If it waits past a certain point, the call terminates,
    and you will need to run it again.
2.  Gets all the conglomerates that are seen in `sys.sysconglomerates`
    (e.g. <span class="AppCommand">select conglomeratenumber from
    sys.sysconglomerates</span>).
3.  Gets a list of all of the HBase tables.
4.  If an HBase table is not in the conglomerates list and is not a
    system table (`conglomeratenumber < 1100 or 1168`), then it is
    deleted.
    If this does not occur, check the `splice.log`.

You are ready to go when you see the <span class="AppCommand">Ready to
accept connections</span> message.

If you see an exception, but do not see the <span
class="AppCommand">Ready to accept connections</span> message, please
retry the command.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.VACUUM()
{: .FcnSyntax xml:space="preserve"}

</div>
## Example

<div class="preWrapper" markdown="1">
    splice> CALL SYSCS_UTIL.VACUUM();
    Ready to accept connections.
{: .Example xml:space="preserve"}

</div>
</div>
</section>

