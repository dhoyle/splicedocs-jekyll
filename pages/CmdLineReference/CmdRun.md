---
title: Run command
summary: Runs commands from a file.
keywords: commands file, cli
toc: false
product: all
sidebar: home_sidebar
permalink: cmdlineref_run.html
folder: CmdLineReference
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Run Command

The <span class="AppCommand">run</span> command redirects the command
line interpreter to read and process commands from the specified file.
This continues until the end of the file is reached, or an
[exit](cmdlineref_exit.html) command is executed. Note that the file
*can* contain `run` commands.

You can specify a file that is in the directory where you are running
the command, or you can include the full file path so that the `run`
command can find it.
{: .noteNote}

The command line interpreter prints out the statements in the file as it
executes them.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    RUN String
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
String
{: .paramName}

The name of the file containing commands to execute.
{: .paramDefnFirst}

</div>
## Examples

<div class="preWrapperWide" markdown="1">
    splice> run 'setupMenuConn.spl';
    splice> -- this is setupMenuConn.spl
    -- splice displays its contents as it processes file
    splice> connect 'jdbc:splice://xyz:1527/splicedb';
    splice> autocommit off;
    splice> -- this is the end of setupMenuConn.spl
    -- there is now a connection to splicedb on xyz and no autocommit.
    -- input will now resume from the previous source.
    ;
    splice>
{: .AppCommand xml:space="preserve"}

</div>
</div>
</section>

