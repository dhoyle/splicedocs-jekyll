---
title: MaximumDisplayWidth command
summary: Sets the maximum displayed width for each column of results displayed by the command line interpreter.
keywords: display width, column width
toc: false
product: all
sidebar: cmdlineref_sidebar
permalink: cmdlineref_maximumdisplaywidth.html
folder: CmdLineReference
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# MaximumDisplayWidth Command

The <span class="AppCommand">maximumdisplaywidth</span> command sets the
largest display width, in characters, for displayed columns in the
command line interpreter.

This is generally used to increase the default value in order to display
large blocks of text.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    MAXIMUMDISPLAYWIDTH integer_value
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
integer_value
{: .paramName}

The maximum width of each column that is displayed by the command line
intepreter.
{: .paramDefnFirst}

Set this value to `0` to display the entire content of each column.
{: .paramDefn}

</div>
## Examples

<div class="preWrapper" markdown="1">
    splice> maximumdisplaywidth 3;
    splice> VALUES 'NOW IS THE TIME!';
    1
    ---
    NOW
    splice> maximumdisplaywidth 30;
    splice> VALUES 'NOW IS THE TIME!';
    1
    ----------------
    NOW IS THE TIME!
{: .AppCommand xml:space="preserve"}

</div>
</div>
</section>

