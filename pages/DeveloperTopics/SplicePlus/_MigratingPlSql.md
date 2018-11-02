---
title: Migrating to Splice*Plus
toc: false
keywords:
product: all
summary:
sidebar: developers_sidebar
permalink: developers_spliceplus_migrating.html
folder: DeveloperTopics/SplicePlus
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Migrating to Splice*Plus

This topic details the Splice*Plus implementation of PL/SQL and
describes any modifications that may be required to migrate your
existing PL/SQL code to Splice Machine, in the following sections:

This section is not yet available.
{: .noteIcon}

{::comment}
* [*Splice*Plus Coverage*](coverage) describes the basic language
  features as implemented in Splice*Plus.
* [*Data Type Conversions*](types) calls out any data type differences
  between Splice*Plus and other PL/SQL dialects, and how to accomodate
  to those differences.
* [*Unavailable Features*](unavailable) describes features that may not
  be available in Splice*plus and the workarounds for migrating those
  features.

## Splice*Plus Coverage   {#coverage}

<table>
    <col />
    <col />
    <thead>
        <tr>
            <th> </th>
            <th> </th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Types</td>
            <td>
                <ul class="bulletCell">
                    <li>Numeric, string, date and time</li>
                    <li>Large object types</li>
                    <li>User-defined types: scalar, structure, table</li>
                    <li>Collections: Varrays, Nested Tables, Records</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td>Conversions</td>
            <td>
                <ul class="bulletCell">
                    <li>Type casts</li>
                    <li>Value set conversions</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td>Variables</td>
            <td>Declaration, initialization, assignment</td>
        </tr>
        <tr>
            <td>Flow control</td>
            <td><code>IF, FOR, WHILE, RETURN, EXIT, GOTO</code>, and so on</td>
        </tr>
        <tr>
            <td>Functions,<br />Procedures</td>
            <td>
                <ul class="bulletCell">
                    <li>Named parameters with default values</li>
                    <li>Closures</li>
                    <li>Nesting </li>
                </ul>
            </td>
        </tr>
        <tr>
            <td>Arithmetic </td>
            <td>
                <p>On 7 different numeric forms.</p>
                <p>On date and time types</p>
            </td>
        </tr>
        <tr>
            <td>SQL</td>
            <td><code>SELECT, INSERT, UPDATE, DELETE, CREATE, DROP</code>
            </td>
        </tr>
        <tr>
            <td>Exceptions</td>
            <td><code>RAISE</code>, Catch, custom definitions</td>
        </tr>
        <tr>
            <td>Cursors</td>
            <td><code>OPEN, FETCH, BULK COLLECTION, %ROWCOUNT</code>
            </td>
        </tr>
        <tr>
            <td>Execution</td>
            <td><code>EXECUTE IMMEDIATE</code>
            </td>
        </tr>
        <tr>
            <td>Transactions</td>
            <td>Transaction stack</td>
        </tr>
    </tbody>
</table>
## Data Type Conversions   {#types}

Some of the data types in PL/SQL are not part of Splice Machine SQL;
however, our PL/SQL compiler automatically converts such data types into
native, Splice Machine SQL data types, including these conversions:

<table>
    <col />
    <col />
    <col />
    <thead>
        <tr>
            <th>PL/SQL data type</th>
            <th>Splice Machine data type</th>
            <th>Notes</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td> </td>
            <td> </td>
            <td> </td>
        </tr>
        <tr>
            <td> </td>
            <td> </td>
            <td> </td>
        </tr>
        <tr>
            <td> </td>
            <td> </td>
            <td> </td>
        </tr>
        <tr>
            <td> </td>
            <td> </td>
            <td> </td>
        </tr>
        <tr>
            <td> </td>
            <td> </td>
            <td> </td>
        </tr>
    </tbody>
</table>

## Splice*Plus: Features Not Available   {#unavailable}

{:/comment}

</div>
</section>
