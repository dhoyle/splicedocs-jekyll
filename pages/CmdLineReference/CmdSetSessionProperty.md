---
title: SET SESSION_PROPERTY command
summary: Sets properties connection's session.
keywords: session properties
toc: false
product: all
sidebar:  home_sidebar
permalink: cmdlineref_setsessionproperty.html
folder: CmdLineReference
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SET SESSION_PROPERTY

The `SET SESSION_PROPERTY` command sets or unsets specific session-level property values. Session-level properties assign an initial value to certain Splice Machine [query hints](bestpractices_optimizer_hints.html), which allows you to supply the hint by default in all queries.

This command should __only be used by advanced users__. Query hints are very powerful, and applying them by default can lead to unforeseen and unfortunate consequences.
{: .noteIcon}

## Syntax

<div class="fcnWrapperWide"><pre class="FcnSyntax">
SET SESSION_PROPERTY {
   <em>propertySetting</em> [, <em>propertySetting</em>]*
}</pre>
</div>

<div class="paramList" markdown="1">
propertySetting
{: .paramName}

<div class="fcnWrapperWide"><pre class="FcnSyntax">
useSpark  = [true | false | null]</pre>
</div>
{: paramDefnFirst}
</div>

Splice Machine will include additional session properties in the future.
{: .noteNote}


## Usage

Specifying a hint in a query overrides the session-level property setting. For example, if you use this command to tell Splice Machine to use Spark to process every query in the session:

```
SET SESSION_PROPERTY useSpark=true
```
{: .Example}

and then submit a query with the hint:
{: .spaceAbove}

```
--splice-properties useSpark=false
```
{: .Example}

That query will run on the control side (using HBase), and not on Spark. Other, unhinted queries will continue to assume the `useSpark=true` default hint value.
{: .spaceAbove}

The following table summarizes the currently available session properties:
<table>
    <col />
    <col />
    <thead>
        <tr>
            <th>Session Property</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont">useSpark</td>
            <td>
                <p>Setting this to <code>true</code> is equivalent to having the <code>useSpark=true</code> hint applied by default for every query.</p>
                <p>Setting this to <code>false</code> is equivalent to specifying the <code>useSpark=false</code> hint applied by default for every query.</p>
                <p>Setting this to <code>null</code> unsets the property, which is equivalent to not specifying the <code>useSpark=false</code> hint by default in any query.</p>
            </td>
        </tr>
    </tbody>
</table>

### Unsetting a Property
To unset a session property, assign `null` as its value.

### Displaying Current Session Properties
You can use the `values current session_property` expression to display the current `session_property` values. Note that only properties that you have explicitly set to non-null values are displayed.

## Examples
Here's an example of setting a session property:

<div class="preWrapperWide" markdown="1"><pre class="Example">
splice> set session_property useSpark=true;
0 rows inserted/updated/deleted
splice> values current session_property;
1
------------------------------------------------------------------
USESPARK=true;

1 row selected</pre>
</div>

And here's an example of unsetting those values (resetting them to their connection default values):

<div class="preWrapperWide" markdown="1"><pre class="Example">
splice> set session_property useSpark=null;
0 rows inserted/updated/deleted
splice> values current session_property;
1
------------------------------------------------------------------


1 row selected</pre>
</div>

## See Also
* [Using Hints to Improve Performance](bestpractices_optimizer_hints.html)

</div>
</section>
