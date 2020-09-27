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
    SPOOL 'fileName';

    SPOOL STOP;

    SPOOL CLEAR;
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
fileName
{: .paramName}

The name of the target log file for the command line session data. Include the full path on the local file system, and enclose the path in single quotes.
  * If the file does not exist, a new file is created.
  * If the file exists, session data is appended to the end of the file.
  * If a log file is already in use and a new file is specified, subsequent data is written to the new file.
{: .paramDefnFirst}

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

Log to a new file:

<div class="preWrapperWide" markdown="1"><pre class="Example">
  splice> spool '/Library/splicelogs/splicelog1';
  Create new spool file /Library/splicelogs/splicelog1.
  splice>
</pre></div>

Stop logging to the file:

<div class="preWrapperWide" markdown="1"><pre class="Example">
  splice> spool stop;
  splice>
</pre></div>

Resume logging to the file:

<div class="preWrapperWide" markdown="1"><pre class="Example">
  splice> spool '/Library/splicelogs/splicelog1';
  Warning: spool is set to /Library/splicelogs/splicelog1 which already exists, future commands will be appended to it.
  splice>  
</pre></div>

Clear the contents of the file:

<div class="preWrapperWide" markdown="1"><pre class="Example">
  splice> spool clear;
  splice>   
</pre></div>

Switch to a new log file:

<div class="preWrapperWide" markdown="1"><pre class="Example">
  splice> spool '/Library/splicelogs/splicelog2';
  Create new spool file /Library/splicelogs/splicelog2.
  splice>
</pre></div>

Example of data logged to the file:

<div class="preWrapperWide" markdown="1"><pre class="Example">
  splice> show schema;
  ERROR 42X01: Syntax error: Encountered "show" at line 1, column 1.
  Issue the 'help' command for general information on Splice command syntax.
  Any unrecognized commands are treated as potential SQL commands and executed directly.
  Consult your DBMS server reference documentation for details of the SQL syntax supported by your server.
  splice> show schemas;
  TABLE_SCHEM                   
  ------------------------------
  NULLID                        
  SPLICE                        
  SQLJ                          
  SYS                           
  SYSCAT                        
  SYSCS_DIAG                    
  SYSCS_UTIL                    
  SYSFUN                        
  SYSIBM                        
  SYSIBMADM                     
  SYSPROC                       
  SYSSTAT                       
  SYSVW                         

  13 rows selected
  ELAPSED TIME = 622 milliseconds
  splice>
</pre></div>

</div>
</section>
