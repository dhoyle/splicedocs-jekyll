---
title: SET SESSION_PROPERTY command
summary: Sets properties connection's session.
keywords: session properties
toc: false
product: all
sidebar:  cmdlineref_sidebar
permalink: cmdlineref_setsessionproperty.html
folder: CmdLineReference
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SET SESSION_PROPERTY

The `SET SESSION_PROPERTY` command sets or unsets specific session-level property values. This allows you to, for example, activate the `useSpark` hint for every query in a session, without having to specify the hint in each query.

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
  ( skipStats = [true | false | null] )
| ( useSpark  = [true | false | null] )
| ( defaultSelectivityFactor = [ <em>unitInterval</em> | null] )</pre>
</div>
{: paramDefnFirst}
</div>

A *unitInterval* is a numeric value between `0` and `1`, which can be expressed using scientific notation; for example:
`1.0E-4` or `1e-4`.
{: .indentLevel2}

## Usage

To unset a session property, assign `null` as its value.

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

That query will run on the control side (using HBase), and not on Spark.
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

You can use the `values` expression to display the current `session_property` values. Note that only properties that you have explicitly set to non-null values are displayed.

## Examples

Here's an example of setting two session properties:

<div class="preWrapperWide" markdown="1"><pre class="Example">
splice> set session_property useSpark=true,defaultSelectivityFactor=1e-4;
0 rows inserted/updated/deleted
splice> values current session_property;
1
------------------------------------------------------------------
USESPARK=true; DEFAULTSELECTIVITYFACTOR=1.0E-4;

1 row selected</pre>
</div>

And here's an example of unsetting those values (resetting them to their connection default values):

<div class="preWrapperWide" markdown="1"><pre class="Example">
splice> set session_property useSpark=null,defaultSelectivityFactor=null;
0 rows inserted/updated/deleted
splice> values current session_property;
1
------------------------------------------------------------------


1 row selected</pre>
</div>

## See Also
* [Query Optimization](developers_tuning_queryoptimization.html#queryhints)

</div>
</section>
