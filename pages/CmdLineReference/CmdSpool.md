---
title: Spool command
summary: Logs Splice Machine command line session data to a file.
keywords: spool, spool command, log, logging, log to file
toc: false
product: all
sidebar: home_sidebar
permalink: cmdlineref_spool.html
folder: CmdLineReference
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Spool Command

The <span class="AppCommand">spool</span> command logs Splice Machine command line session data to a specified file on the local file system.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SPOOL fileName;

    SPOOL STOP;

    SPOOL CLEAR;
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
fileName
{: .paramName}

The name of the target log file for the command line session data.
{: .paramDefnFirst}

Session data is appended to the end of the file.
{: .paramDefn}

If a log file is already in use, subsequent data is written to the new file.
{: .paramDefn}

The session data that is logged to the file includes:
  * SQL statements issued
  * SQL output messages (errors, row counts when successful, etc.)
  * Data returned
{: .paramDefn}

STOP
{: name="paramName" .paramName}

Stops logging command line session data.
{: .paramDefnFirst}


CLEAR
{: name="paramName" .paramName}

Clears all data in the currently specified log file.
{: .paramDefnFirst}



</div>


## Examples

<div class="preWrapperWide" markdown="1">
    splice> analyze table test.t2;
    schemaName |tableName |partition |rowsCollec&|partitionSize |partitionCount  |statsType  |sampleFraction
    -----------------------------------------------------------------------------------------------------------------
    TEST       |T2        |-All-     |39226      |235356        |1               |2          |0

    1 rows selected
    splice>splice> analyze table test.t2 estimate statistics sample 50 percent;
    schemaName |tableName |partition |rowsCollec&|partitionSize |partitionCount  |statsType  |sampleFraction
    -----------------------------------------------------------------------------------------------------------------
    TEST       |T2        |-All-     |19613      |235356        |1               |3          |0.5

    1 rows selected
    splice>splice> analyze schema test;
    schemaName |tableName |partition |rowsCollec&|partitionSize |partitionCount  |statsType  |sampleFraction
    -----------------------------------------------------------------------------------------------------------------
    TEST       |T2        |-All-     |39226      |235356        |1               |2          |0
    TEST       |T5        |-All-     |39226      |235356        |1               |2          |0
    2 rows selected
    splice>
{: .AppCommand}

</div>
</div>
</section>
