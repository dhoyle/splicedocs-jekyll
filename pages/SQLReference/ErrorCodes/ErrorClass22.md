---
title: Splice Machine Error Codes - Class 22&#58; Data Exception
summary: Summary of Splice Machine Class 22 Errors
keywords: 22 errors, error 22
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_errcodes_class22.html
folder: SQLReference/ErrorCodes
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Error Class 22: Data Exception

<table>
    <caption>Error Class 22: Data Exception</caption>
    <thead>
        <tr>
            <th>SQLSTATE</th>
            <th>Message Text</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>22001</code></td>
            <td>A truncation error was encountered trying to shrink <span class="VarName">&lt;value&gt;</span> '<span class="VarName">&lt;value&gt;</span>' to length <span class="VarName">&lt;value&gt;</span>.</td>
        </tr>
        <tr>
            <td><code>22003</code></td>
            <td>The resulting value is outside the range for the data type <span class="VarName">&lt;datatypeName&gt;</span>.</td>
        </tr>
        <tr>
            <td><code>22003.S.0</code></td>
            <td>The modified row count was larger than can be held in an integer which is required by the JDBC spec. The real modified row count was <span class="VarName">&lt;modifiedRowCount&gt;</span>.</td>
        </tr>
        <tr>
            <td><code>22003.S.1</code></td>
            <td>Year (<span class="VarName">&lt;value&gt;</span>) exceeds the maximum '<span class="VarName">&lt;value&gt;</span>'.</td>
        </tr>
        <tr>
            <td><code>22003.S.2</code></td>
            <td>Decimal may only be up to 38 digits.</td>
        </tr>
        <tr>
            <td><code>22003.S.3</code></td>
            <td>Overflow occurred during numeric data type conversion of '<span class="VarName">&lt;datatypeName&gt;</span>' to <span class="VarName">&lt;datatypeName&gt;</span>.</td>
        </tr>
        <tr>
            <td><code>22003.S.4</code></td>
            <td>The length (<span class="VarName">&lt;number&gt;</span>) exceeds the maximum length (<span class="VarName">&lt;datatypeName&gt;</span>) for the data type.</td>
        </tr>
        <tr>
            <td><code>22005.S.1</code></td>
            <td>Unable to convert a value of type '<span class="VarName">&lt;typeName&gt;</span>' to type '<span class="VarName">&lt;typeName&gt;</span>' : the encoding is not supported.</td>
        </tr>
        <tr>
            <td><code>22005.S.2</code></td>
            <td>The required character converter is not available.</td>
        </tr>
        <tr>
            <td><code>22005.S.3</code></td>
            <td>Unicode string cannot convert to Ebcdic string</td>
        </tr>
        <tr>
            <td><code>22005.S.4</code></td>
            <td>Unrecognized JDBC type. Type: <span class="VarName">&lt;typeName&gt;</span>, columnCount: <span class="VarName">&lt;value&gt;</span>, columnIndex: <span class="VarName">&lt;value&gt;</span>.</td>
        </tr>
        <tr>
            <td><code>22005.S.5</code></td>
            <td>Invalid JDBC type for parameter <span class="VarName">&lt;parameterName&gt;</span>.</td>
        </tr>
        <tr>
            <td><code>22005.S.6</code></td>
            <td>Unrecognized Java SQL type <span class="VarName">&lt;datatypeName&gt;</span>.</td>
        </tr>
        <tr>
            <td><code>22005.S.7</code></td>
            <td>Unicode string cannot convert to UTF-8 string</td>
        </tr>
        <tr>
            <td><code>22005</code></td>
            <td>An attempt was made to get a data value of type '<span class="VarName">&lt;datatypeName&gt;</span>' from a data value of type '<span class="VarName">&lt;datatypeName&gt;</span>'.</td>
        </tr>
        <tr>
            <td><code>22007.S.180</code></td>
            <td>The string representation of a datetime value is out of range.</td>
        </tr>
        <tr>
            <td><code>22007.S.181</code></td>
            <td>The syntax of the string representation of a datetime value is incorrect.</td>
        </tr>
        <tr>
            <td><code>22008.S</code></td>
            <td>'<span class="VarName">&lt;argument&gt;</span>' is an invalid argument to the <span class="VarName">&lt;functionName&gt;</span> function.</td>
        </tr>
        <tr>
            <td><code>2200H.S</code></td>
            <td>Sequence generator '<span class="VarName">&lt;schemaName&gt;</span>.<span class="VarName">&lt;sequenceName&gt;</span>' does not cycle. No more values can be obtained from this sequence generator.</td>
        </tr>
        <tr>
            <td><code>2200L</code></td>
            <td>Values assigned to XML columns must be well-formed DOCUMENT nodes.</td>
        </tr>
        <tr>
            <td><code>2200M</code></td>
            <td>Invalid XML DOCUMENT: <span class="VarName">&lt;parserError&gt;</span></td>
        </tr>
        <tr>
            <td><code>2200V</code></td>
            <td>Invalid context item for <span class="VarName">&lt;operatorName&gt;</span> operator; context items must be well-formed DOCUMENT nodes.</td>
        </tr>
        <tr>
            <td><code>2200W</code></td>
            <td>XQuery serialization error: Attempted to serialize one or more top-level Attribute nodes.</td>
        </tr>
        <tr>
            <td><code>22011</code></td>
            <td>The second or third argument of the SUBSTR function is out of range.</td>
        </tr>
        <tr>
            <td><code>22011.S.1</code></td>
            <td>The range specified for the substring with offset <span class="VarName">&lt;operatorName&gt;</span> and len <span class="VarName">&lt;len&gt;</span> is out of range for the String: <span class="VarName">&lt;str&gt;</span>.</td>
        </tr>
        <tr>
            <td><code>22012</code></td>
            <td>Attempt to divide by zero.</td>
        </tr>
        <tr>
            <td><code>22013</code></td>
            <td>Attempt to take the square root of a negative number, '<span class="VarName">&lt;value&gt;</span>'.</td>
        </tr>
        <tr>
            <td><code>22014</code></td>
            <td>The start position for LOCATE is invalid; it must be a positive integer. The index  to start the search from is '<span class="VarName">&lt;startIndex&gt;</span>'.  The string to search for is '<span class="VarName">&lt;searchString&gt;</span>'.  The string to search from is '<span class="VarName">&lt;fromString&gt;</span>'. </td>
        </tr>
        <tr>
            <td><code>22015</code></td>
            <td>The '<span class="VarName">&lt;functionName&gt;</span>' function is not allowed on the following set of types.  First operand is of type '<span class="VarName">&lt;typeName&gt;</span>'.  Second operand is of type '<span class="VarName">&lt;typeName&gt;</span>'.  Third operand (start position) is of type '<span class="VarName">&lt;typeName&gt;</span>'.</td>
        </tr>
        <tr>
            <td><code>22018</code></td>
            <td>Invalid character string format for type <span class="VarName">&lt;typeName&gt;</span>.</td>
        </tr>
        <tr>
            <td><code>22019</code></td>
            <td>Invalid escape sequence, '<span class="VarName">&lt;sequenceName&gt;</span>'. The escape string must be exactly one character. It cannot be a null or more than one character.</td>
        </tr>
        <tr>
            <td><code>22020</code></td>
            <td>Invalid trim string, '<span class="VarName">&lt;string&gt;</span>'. The trim string must be exactly one character or NULL. It cannot be more than one character.</td>
        </tr>
        <tr>
            <td><code>22021</code></td>
            <td>Unknown character encoding '<span class="VarName">&lt;typeName&gt;</span>'.</td>
        </tr>
        <tr>
            <td><code>22025</code></td>
            <td>Escape character must be followed by escape character, '_', or '%'. It cannot be followed by any other character or be at the end of the pattern.</td>
        </tr>
        <tr>
            <td><code>22027</code></td>
            <td>The built-in TRIM() function only supports a single trim character.  The LTRIM() and RTRIM() built-in functions support multiple trim characters.</td>
        </tr>
        <tr>
            <td><code>22028</code></td>
            <td>The string exceeds the maximum length of <span class="VarName">&lt;number&gt;</span>.</td>
        </tr>
        <tr>
            <td><code>22501</code></td>
            <td>An ESCAPE clause of NULL returns undefined results and is not allowed.</td>
        </tr>
        <tr>
            <td><code>2201X</code></td>
            <td>Invalid row count for OFFSET, must be &gt;= 0.</td>
        </tr>
        <tr>
            <td><code>2201Y</code></td>
            <td>Invalid LEAD, LAG for OFFSET, must be greater or equal to 0 and less than Integer.MAX_VALUE. Got '<span class="VarName">&lt;value&gt;</span>'.</td>
        </tr>
        <tr>
            <td><code>2202A</code></td>
            <td>Missing argument for first(), last() function.</td>
        </tr>
        <tr>
            <td><code>2202B</code></td>
            <td>Missing argument for lead(), lag() function.</td>
        </tr>
        <tr>
            <td><code>2202C</code></td>
            <td>"default" argument for lead(), lag() function is not implemented.</td>
        </tr>
        <tr>
            <td><code>2202D</code></td>
            <td>NULL value for data type <span class="VarName">&lt;string&gt;</span> not supported.</td>
        </tr>
        <tr>
            <td><code>2202E</code></td>
            <td>A <span class="VarName">&lt;string&gt;</span> column cannot be aggregated.</td>
        </tr>
        <tr>
            <td><code>2201W</code></td>
            <td>Row count for FIRST/NEXT/TOP must be &gt;= 1 and row count for LIMIT must be &gt;= 0.</td>
        </tr>
        <tr>
            <td><code>2201Z</code></td>
            <td>NULL value not allowed for <span class="VarName">&lt;string&gt;</span> argument.</td>
        </tr>
    </tbody>
</table>
</div>
</section>
