---
title: Argument Matching
summary: How Splice Machine maps SQL data types to Java data types and matches arguments when using stored procedures.
keywords: arg match, stored procedures
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sqlargmatching.html
folder: SQLReference/ArgMatching
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Argument Matching in Splice Machine   {#SQLArgumentMatching}

When you declare a function or procedure using `CREATE
FUNCTION/PROCEDURE`, Splice Machine does not verify whether a matching
Java method exists. Instead, Splice Machine looks for a matching method
only when you invoke the function or procedure in a later SQL statement.

At that time, Splice Machine searches for a public, static method having
the class and method name declared in the `EXTERNAL NAME `clause of the
earlier `CREATE FUNCTION/PROCEDURE` statement. Furthermore, the Java
types of the method's arguments and return value must match the SQL
types declared in the `CREATE FUNCTION/PROCEDURE `statement.

The following may happen:

<table summary="Pssible results of argument mismatches">
                <col />
                <col />
                <thead>
                    <tr>
                        <th>Result</th>
                        <th>Description</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="ItalicFont">Success
                    </td>
                        <td>If exactly one Java method matches, then Splice Machine invokes it.</td>
                    </tr>
                    <tr>
                        <td class="ItalicFont">Ambiguity
                    </td>
                        <td> If exactly one Java method matches, then Splice Machine invokes it.</td>
                    </tr>
                    <tr>
                        <td class="ItalicFont">Failure
                    </td>
                        <td> Splice Machine also raises an error if no method matches.</td>
                    </tr>
                </tbody>
            </table>
In mapping SQL data types to Java data types, Splice Machine considers
the following kinds of matches:

<table summary="Types of argument matches">
                <col />
                <col />
                <col />
                <thead>
                    <tr>
                        <th>Result</th>
                        <th>Description</th>
                        <th> </th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="ItalicFont">Primitive Match
                    </td>
                        <td>Splice Machine looks for a primitive	Java type corresponding to the SQL type. For instance, SQL <code>INTEGER </code>matches Java <em>int</em></td>
                    </tr>
                    <tr>
                        <td class="ItalicFont">Wrapper Match
                    </td>
                        <td> Splice Machine looks for a wrapper class in the <em>java.lang</em> or <em>java.sql</em> packages corresponding to the
					SQL type. For instance, SQL INTEGER matches <em>java.lang.Integer</em>. For a user-defined type (UDT), Splice Machine looks for the UDT's external name class.</td>
                    </tr>
                    <tr>
                        <td class="ItalicFont">Array Match
                    </td>
                        <td>For <code>OUT</code> and <code>INOUT</code> procedure arguments, Splice Machine looks for an array of the corresponding primitive or wrapper type. For
					example, an <code>OUT</code> procedure argument of type SQL <code>INTEGER </code>matches	<em>int[]</em> and <em>Integer[]</em>.</td>
                    </tr>
                    <tr>
                        <td class="ItalicFont">ResultSet Match
                    </td>
                        <td> If a procedure is declared to return <em>n</em> RESULT SETS, Splice Machine looks for a method whose last <em>n</em> arguments are of type <em>java.sql.ResultSet[]</em>.</td>
                    </tr>
                </tbody>
            </table>
Splice Machine resolves function and procedure invocations as follows:

<table summary="How Splice Machine resolves argments matches in function and procedure calls">
                <col />
                <col />
                <thead>
                    <tr>
                        <th>Call type</th>
                        <th>Resolution</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="ItalicFont">Function
                 </td>
                        <td>Splice Machine looks for a method whose argument and return types are <em>primitive match</em>es or <em>wrapper match</em>es for the function's SQL arguments and return value.</td>
                    </tr>
                    <tr>
                        <td><em>Procedure                    </em></td>
                        <td>
                            <p class="noSpaceAbove">Splice Machine looks for a method which returns void and whose argument types match as follows:
						</p>
                            <ul>
                                <li><code>IN</code> - Method arguments are <em>primitive match</em>es or <em>wrapper matches</em> for the procedure's <code>IN</code> arguments.</li>
                                <li><code>OUT and INOUT</code> - Method arguments are <em>array match</em>es for the
						procedure's <code>OUT</code> and <code>INOUT</code> arguments.</li>
                            </ul>
                            <p>
						In addition, if the procedure returns <em>n</em> RESULT SETS, then the last <em>n</em> arguments of the Java method must be of type <em>java.sql.ResultSet[]</em></p><![CDATA[					]]></td>
                    </tr>
                </tbody>
            </table>
## Example of argument matching

The following function:

<div class="preWrapperWide" markdown="1">
    CREATE FUNCTION TO_DEGREES
         ( RADIANS DOUBLE )
    RETURNS DOUBLE
    PARAMETER STYLE JAVA
    NO SQL LANGUAGE JAVA
    EXTERNAL NAME 'example.MathUtils.toDegrees'
    ;
{: .Example xml:space="preserve"}

</div>
would match all of the following methods:

<div class="preWrapperWide" markdown="1">
    
    public static double toDegrees( double arg ) {...}
    public static Double toDegrees( double arg ) {...}
    public static double toDegrees( Double arg ) {...}
    public static Double toDegrees( Double arg ) {...}
    		
{: .Example}

</div>
Note that Splice Machine raises an exception if it finds more than one
matching method.

## Mapping SQL data types to Java data types

The following table shows how Splice Machine maps specific SQL data
types to Java data types.

<table>
                <caption>SQL and Java type correspondence</caption>
                <col />
                <col />
                <col />
                <thead>
                    <tr>
                        <th>SQL Type</th>
                        <th>Primitive Match</th>
                        <th>Wrapper Match</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td style="font-family: monospace;">BOOLEAN</td>
                        <td style="font-family: monospace;"><em>boolean</em>
                        </td>
                        <td style="font-family: monospace;"><em>java.lang.Boolean</em>
                        </td>
                    </tr>
                    <tr>
                        <td style="font-family: monospace;">SMALLINT</td>
                        <td style="font-family: monospace;"><em>short</em>
                        </td>
                        <td style="font-family: monospace;"><em>java.lang.Integer</em>
                        </td>
                    </tr>
                    <tr>
                        <td style="font-family: monospace;">INTEGER</td>
                        <td style="font-family: monospace;"><em>int</em>
                        </td>
                        <td style="font-family: monospace;"><em>java.lang.Integer</em>
                        </td>
                    </tr>
                    <tr>
                        <td style="font-family: monospace;">BIGINT</td>
                        <td style="font-family: monospace;"><em>long</em>
                        </td>
                        <td style="font-family: monospace;"><em>java.lang.Long</em>
                        </td>
                    </tr>
                    <tr>
                        <td style="font-family: monospace;">DECIMAL</td>
                        <td>None</td>
                        <td style="font-family: monospace;"><em>java.math.BigDecimal</em>
                        </td>
                    </tr>
                    <tr>
                        <td style="font-family: monospace;">NUMERIC</td>
                        <td>None</td>
                        <td style="font-family: monospace;"><em>java.math.BigDecimal</em>
                        </td>
                    </tr>
                    <tr>
                        <td style="font-family: monospace;">REAL</td>
                        <td style="font-family: monospace;"><em>float</em>
                        </td>
                        <td style="font-family: monospace;"><em>java.lang.Float</em>
                        </td>
                    </tr>
                    <tr>
                        <td style="font-family: monospace;">DOUBLE</td>
                        <td style="font-family: monospace;"><em>double</em>
                        </td>
                        <td style="font-family: monospace;"><em>java.lang.Double</em>
                        </td>
                    </tr>
                    <tr>
                        <td style="font-family: monospace;">FLOAT</td>
                        <td style="font-family: monospace;"><em>double</em>
                        </td>
                        <td style="font-family: monospace;"><em>java.lang.Double</em>
                        </td>
                    </tr>
                    <tr>
                        <td style="font-family: monospace;">CHAR</td>
                        <td>None</td>
                        <td style="font-family: monospace;"><em>java.lang.String</em>
                        </td>
                    </tr>
                    <tr>
                        <td style="font-family: monospace;">VARCHAR</td>
                        <td>None</td>
                        <td style="font-family: monospace;"><em>java.lang.String</em>
                        </td>
                    </tr>
                    <tr>
                        <td style="font-family: monospace;">LONG VARCHAR</td>
                        <td>None</td>
                        <td style="font-family: monospace;"><em>java.lang.String</em>
                        </td>
                    </tr>
                    <tr>
                        <td style="font-family: monospace;">CLOB</td>
                        <td>None</td>
                        <td style="font-family: monospace;"><em>java.sql.Clob</em>
                        </td>
                    </tr>
                    <tr>
                        <td style="font-family: monospace;">BLOB</td>
                        <td>None</td>
                        <td style="font-family: monospace;"><em>java.sql.Blob</em>
                        </td>
                    </tr>
                    <tr>
                        <td style="font-family: monospace;">DATE</td>
                        <td>None</td>
                        <td style="font-family: monospace;"><em>java.sql.Date</em>
                        </td>
                    </tr>
                    <tr>
                        <td style="font-family: monospace;">TIME</td>
                        <td>None</td>
                        <td style="font-family: monospace;"><em>java.sql.Time</em>
                        </td>
                    </tr>
                    <tr>
                        <td style="font-family: monospace;">TIMESTAMP</td>
                        <td>None</td>
                        <td style="font-family: monospace;"><em>java.sql.Timestamp</em>
                        </td>
                    </tr>
                    <tr>
                        <td>User-defined type</td>
                        <td>None</td>
                        <td>Underlying Java class</td>
                    </tr>
                </tbody>
            </table>
## See Also

* [About Data Types](sqlref_datatypes_intro.html)

</div>
</section>

