---
title: Data Assignments and Comparisons
summary: Summarizes how assignment and comparison compatibility among the different SQL data types.
keywords:
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_datatypes_compatability.html
folder: SQLReference/DataTypes
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Splice Machine Data Assignments and Comparisons

The following table displays valid assignments between data types in
Splice Machine. A *Y* indicates that the assignment is valid.

<table summary="Summary of allowed data assignments and comparisons">
    <col />
    <col />
    <col />
    <col />
    <col />
    <col />
    <col />
    <col />
    <col />
    <col />
    <col />
    <col />
    <col />
    <col style="width: 25px;" />
    <col />
    <col />
    <col />
    <col />
    <col />
    <thead>
        <tr>
            <th>TYPES</th>
            <th style="vertical-align:bottom">B<br />O<br />O<br />L<br />E<br />A<br />N</th>
            <th style="vertical-align:bottom">T<br />I<br />N<br />Y<br />I<br />N<br />T</th>
            <th style="vertical-align:bottom">S<br />M<br />A<br />L<br />L<br />I<br />N<br />T</th>
            <th style="vertical-align:bottom">I<br />N<br />T<br />E<br />G<br />E<br />R</th>
            <th style="vertical-align:bottom">B<br />I<br />G<br />I<br />N<br />T</th>
            <th style="vertical-align:bottom">D<br />E<br />C<br />I<br />M<br />A<br />L</th>
            <th style="vertical-align:bottom">R<br />E<br />A<br />L</th>
            <th style="vertical-align:bottom">D<br />O<br />U<br />B<br />L<br />E</th>
            <th style="vertical-align:bottom">F<br />L<br />O<br />A<br />T</th>
            <th style="vertical-align:bottom">C<br />H<br />A<br />R</th>
            <th style="vertical-align:bottom">V<br />A<br />R<br />C<br />H<br />A<br />R</th>
            <th style="vertical-align:bottom">L<br />O<br />N<br />G<br /><br />V<br />A<br />R<br />C<br />H<br />A<br />R</th>
            <th style="vertical-align:bottom">C<br />L<br />O<br />B<br /><br />/ <br /><br />T<br />E<br />X<br />T</th>
            <th style="vertical-align:bottom">B<br />L<br />O<br />B<br /></th>
            <th style="vertical-align:bottom">D<br />A<br />T<br />E</th>
            <th style="vertical-align:bottom">T<br />I<br />M<br />E</th>
            <th style="vertical-align:bottom">T<br />I<br />M<br />E<br />S<br />T<br />A<br />M<br />P</th>
            <th style="vertical-align:bottom">U<br />s<br />e<br />r<br />-<br />d<br />e<br />f<br />i<br />n<br />e<br />d<br /> <br />t<br />y<br />p<br />e</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>BOOLEAN</td>
            <td>Y</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
        </tr>
        <tr>
            <td>TINYINT</td>
            <td>-</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
        </tr>
        <tr>
            <td>SMALLINT</td>
            <td>-</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
        </tr>
        <tr>
            <td>INTEGER</td>
            <td>-</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
        </tr>
        <tr>
            <td>BIGINT</td>
            <td>-</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
        </tr>
        <tr>
            <td>DECIMAL</td>
            <td>-</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
        </tr>
        <tr>
            <td>REAL</td>
            <td>-</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
        </tr>
        <tr>
            <td>DOUBLE</td>
            <td>-</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
        </tr>
        <tr>
            <td>FLOAT</td>
            <td>-</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
        </tr>
        <tr>
            <td>CHAR</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>-</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>-</td>
        </tr>
        <tr>
            <td>VARCHAR</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>-</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>-</td>
        </tr>
        <tr>
            <td>LONG VARCHAR</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
        </tr>
        <tr>
            <td>CLOB / TEXT</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
        </tr>
        <tr>
            <td>BLOB</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>Y</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
        </tr>
        <tr>
            <td>DATE</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>Y</td>
            <td>Y</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>Y</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
        </tr>
        <tr>
            <td>TIME</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>Y</td>
            <td>Y</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>Y</td>
            <td>-</td>
            <td>-</td>
        </tr>
        <tr>
            <td>TIMESTAMP</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>Y</td>
            <td>Y</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>Y</td>
            <td>-</td>
        </tr>
        <tr>
            <td>User-defined type</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>Y</td>
        </tr>
    </tbody>
</table>

A value of a user-defined type can be assigned to a value of any
supertype of that user-defined type. However, no explicit casts of
user-defined types are allowed.

The following table displays valid comparisons between data types in
Splice Machine. A *Y* indicates that the comparison is allowed.

<table summary="Summary of valid data type comparisons in Splice Machine">
    <col />
    <col />
    <col />
    <col />
    <col />
    <col />
    <col />
    <col />
    <col />
    <col />
    <col />
    <col />
    <col style="width: 25px;" />
    <col />
    <col />
    <col />
    <col />
    <col />
    <thead>
        <tr>
            <th style="vertical-align:bottom">TYPES</th>
            <th style="vertical-align:bottom">B<br />O<br />O<br />L<br />E<br />A<br />N</th>
            <th style="vertical-align:bottom">T<br />I<br />N<br />Y<br />I<br />N<br />T</th>
            <th style="vertical-align:bottom">S<br />M<br />A<br />L<br />L<br />I<br />N<br />T</th>
            <th style="vertical-align:bottom">I<br />N<br />T<br />E<br />G<br />E<br />R</th>
            <th style="vertical-align:bottom">B<br />I<br />G<br />I<br />N<br />T</th>
            <th style="vertical-align:bottom">D<br />E<br />C<br />I<br />M<br />A<br />L</th>
            <th style="vertical-align:bottom">R<br />E<br />A<br />L</th>
            <th style="vertical-align:bottom">D<br />O<br />U<br />B<br />L<br />E</th>
            <th style="vertical-align:bottom">F<br />L<br />O<br />A<br />T</th>
            <th style="vertical-align:bottom">C<br />H<br />A<br />R</th>
            <th style="vertical-align:bottom">V<br />A<br />R<br />C<br />H<br />A<br />R</th>
            <th style="vertical-align:bottom">L<br />O<br />N<br />G<br /><br />V<br />A<br />R<br />C<br />H<br />A<br />R</th>
            <th style="vertical-align:bottom">C<br />L<br />O<br />B<br /><br />/ <br /><br />T<br />E<br />X<br />T</th>
            <th style="vertical-align:bottom">B<br />L<br />O<br />B<br /></th>
            <th style="vertical-align:bottom">D<br />A<br />T<br />E</th>
            <th style="vertical-align:bottom">T<br />I<br />M<br />E</th>
            <th style="vertical-align:bottom">T<br />I<br />M<br />E<br />S<br />T<br />A<br />M<br />P</th>
            <th style="vertical-align:bottom">U<br />s<br />e<br />r<br />-<br />d<br />e<br />f<br />i<br />n<br />e<br />d<br /> <br />t<br />y<br />p<br />e</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>BOOLEAN</td>
            <td>Y</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
        </tr>
        <tr>
            <td>SMALLINT</td>
            <td>-</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
        </tr>
        <tr>
            <td>INTEGER</td>
            <td>-</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
        </tr>
        <tr>
            <td>BIGINT</td>
            <td>-</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
        </tr>
        <tr>
            <td>DECIMAL</td>
            <td>-</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
        </tr>
        <tr>
            <td>REAL</td>
            <td>-</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
        </tr>
        <tr>
            <td>DOUBLE</td>
            <td>-</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
        </tr>
        <tr>
            <td>FLOAT</td>
            <td>-</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
        </tr>
        <tr>
            <td>CHAR</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>Y</td>
            <td>Y</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>-</td>
        </tr>
        <tr>
            <td>VARCHAR</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>Y</td>
            <td>Y</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>Y</td>
            <td>Y</td>
            <td>Y</td>
            <td>-</td>
        </tr>
        <tr>
            <td>LONG VARCHAR</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
        </tr>
        <tr>
            <td>CLOB / TEXT</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
        </tr>
        <tr>
            <td>BLOB</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
        </tr>
        <tr>
            <td>DATE</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>Y</td>
            <td>Y</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>Y</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
        </tr>
        <tr>
            <td>TIME</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>Y</td>
            <td>Y</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>Y</td>
            <td>-</td>
            <td>-</td>
        </tr>
        <tr>
            <td>TIMESTAMP</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>Y</td>
            <td>Y</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>Y</td>
            <td>-</td>
        </tr>
        <tr>
            <td>User-defined type</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
        </tr>
    </tbody>
</table>

<p class="noteIcon" markdown="1">Splice Machine performs implicit type conversion when performing joins to allow mismatched column types to match. Specifically, when joining a `CHAR` or `VARCHAR` column on a column of the following types: `BOOLEAN`, `DATE`, `TIME`, or `TIMESTAMP`,  an attempt is made to convert the string value into that column's type. See the &nbsp;&nbsp;&nbsp;[`CAST`](sqlref_builtinfcns_cast.html) page for more information.</p>

</div>
</section>
