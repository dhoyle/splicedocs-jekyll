---
title: ElapsedTime command
summary: Enables or disables display of elapsed time for command execution.
keywords: elapsed time
toc: false
product: all
sidebar: cmdlineref_sidebar
permalink: cmdlineref_elapsedtime.html
folder: CmdLineReference
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# ElapsedTime Command

The <span class="AppCommand">elapsedtime</span> command enables or
disables having the command line interface display the amount of time
required for a command to complete its execution.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    ELAPSEDTIME { ON | OFF }
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
ON
{: .paramName}

Enables display of the elapsed time by the command line interface. When
this is enabled, you'll see how much time elapsed during execution of
the command line.
{: .paramDefnFirst}

OFF
{: .paramName}

Disables display of the elapsed time.
{: .paramDefnFirst}

</div>
## Examples

<div class="preWrapper" markdown="1">
    splice> elapsedtime on;
    splice> VALUES current_date;
    1
    ----------
    2014-06-24
    ELAPSED TIME = 2134 milliseconds
    splice>
{: .AppCommand xml:space="preserve"}

</div>
</div>
</section>

