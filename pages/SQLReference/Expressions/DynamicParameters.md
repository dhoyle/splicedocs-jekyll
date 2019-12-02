---
title: Dynamic Parameters
summary: Descriptions of using dynamic parameters in expressions in Splice Machine SQL prepared statements
keywords:
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_expressions_dynamicparams.html
folder: SQLReference/Expressions
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Dynamic Parameters

You can prepare statements that are allowed to have parameters for which
the value is not specified when the statement is repared using
*PreparedStatement* methods in the JDBC API. These parameters are called
dynamic parameters and are represented by a ?.

The JDBC API documents refer to dynamic parameters as `IN`, `INOUT`, or
`OUT` parameters. In SQL, they are always `IN` parameters.

You must specify values for dynamic parameters before executing the
statement, and the types of the specified values must match the expected
types.

## Example

<div class="preWrapperWide" markdown="1">
    PreparedStatement ps2 = conn.prepareStatement(
      "UPDATE HotelAvailability SET rooms_available = " +
      "(rooms_available - ?) WHERE hotel_id = ? " +
      "AND booking_date BETWEEN ? AND ?");

           -- this sample code sets the values of dynamic parameters
           -- to be the values of program variables
    ps2.setInt(1, numberRooms);
    ps2.setInt(2, theHotel.hotelId);
    ps2.setDate(3, arrival);
    ps2.setDate(4, departure);
    updateCount = ps2.executeUpdate();
{: .Example xml:space="preserve"}

</div>
## Where Dynamic Parameters are Allowed   {#DynamicParametersAllowed}

You can use dynamic parameters anywhere in an expression where their
data type can be easily deduced.

* Use as the first operand of `BETWEEN` is allowed if one of the second
  and third operands is not also a dynamic parameter. The type of the
  first operand is assumed to be the type of the non-dynamic parameter,
  or the union result of their types if both are not dynamic parameters.
  <div class="preWrapper" markdown="1">
      WHERE ? BETWEEN DATE('1996-01-01') AND ?
         -- types assumed to be DATE
  {: .Example}

  </div>

* Use as the second or third operand of `BETWEEN` is allowed. Type is
  assumed to be the type of the left operand.
  <div class="preWrapper" markdown="1">
      WHERE DATE('1996-01-01') BETWEEN ? AND ?
         -- types assumed to be DATE
  {: .Example}

  </div>

* Use as the left operand of an `IN` list is allowed if at least one
  item in the list is not itself a dynamic parameter. Type for the left
  operand is assumed to be the union result of the types of the
  non-dynamic parameters in the list.
  <div class="preWrapper" markdown="1">
      WHERE ? NOT IN (?, ?, 'Santiago')
         -- types assumed to be CHAR
  {: .Example}

  </div>

* Use in the values list in an `IN` predicate is allowed if the first
  operand is not a dynamic parameter or its type was determined in the
  previous rule. Type of the dynamic parameters appearing in the values
  list is assumed to be the type of the left operand.
  <div class="preWrapper" markdown="1">
      WHERE FloatColumn IN (?, ?, ?)
         -- types assumed to be FLOAT
  {: .Example}

  </div>

* For the binary operators (<span class="Example">+,&nbsp;&nbsp;-,&nbsp;&nbsp;*,&nbsp;&nbsp;/,&nbsp;&nbsp;AND,&nbsp;&nbsp;OR,&nbsp;&nbsp;&lt;,&nbsp;&nbsp;&gt;,&nbsp;&nbsp;=,&nbsp;&nbsp;&lt;&gt;,&nbsp;&nbsp;!=,&nbsp;&nbsp;^=,&nbsp;&nbsp;&lt;=,&nbsp;&nbsp;&gt;=</span>), use of a dynamic parameter as one operand but not both is
  permitted. Its type is taken from the other side.
  <div class="preWrapper" markdown="1">
      WHERE ? < CURRENT_TIMESTAMP
         -- type assumed to be a TIMESTAMP
  {: .Example}

  </div>

* Use in a `CAST` is always permitted. This gives the dynamic parameter
  a type.
  <div class="preWrapper" markdown="1">
      CALL valueOf(CAST (? AS VARCHAR(10)))
  {: .Example}

  </div>

* Use on either or both sides of `LIKE` operator is permitted. When used
  on the left, the type of the dynamic parameter is set to the type of
  the right operand, but with the maximum allowed length for the type.
  When used on the right, the type is assumed to be of the same length
  and type as the left operand. (`LIKE` is permitted on `CHAR` and
  `VARCHAR` types; see [Concatenation
  operator](sqlref_builtinfcns_concat.html) for more information.)
  <div class="preWrapper" markdown="1">
      WHERE ? LIKE 'Santi%'
         -- type assumed to be CHAR with a length of
         -- java.lang.Integer.MAX_VALUE
  {: .Example}

  </div>

* In a conditional expression, which uses a `?`, use of a dynamic
  parameter (which is also represented as a `?`) is allowed. The type of
  a dynamic parameter as the first operand is assumed to be boolean.
  Only one of the second and third operands can be a dynamic parameter,
  and its type will be assumed to be the same as that of the other (that
  is, the third and second operand, respectively).
  <div class="preWrapper" markdown="1">
      SELECT c1 IS NULL ? ? : c1
         -- allows you to specify a "default" value at execution time
         -- dynamic parameter assumed to be the type of c1
         -- you cannot have dynamic parameters on both sides
         -- of the :
  {: .Example}

  </div>

* A dynamic parameter is allowed as an item in the values list or select
  list of an `INSERT` statement. The type of the dynamic parameter is
  assumed to be the type of the target column.
  <div class="preWrapper" markdown="1">
      INSERT INTO t VALUES (?)
         -- dynamic parameter assumed to be the type
         -- of the only column in table t
      INSERT INTO t SELECT ?
      FROM t2
         -- not allowed
  {: .Example}

  </div>

* A `?` parameter in a comparison with a subquery takes its type from
  the expression being selected by the subquery. For example:
  <div class="preWrapper" markdown="1">
      SELECT *
      FROM tab1
      WHERE ? = (SELECT x FROM tab2)
      SELECT *
      FROM tab1
      WHERE ? = ANY (SELECT x FROM tab2)
         -- In both cases, the type of the dynamic parameter is
         -- assumed to be the same as the type of tab2.x.
  {: .Example}

  </div>

* A dynamic parameter is allowed as the value in an `UPDATE` statement.
  The type of the dynamic parameter is assumed to be the type of the
  column in the target table.
  <div class="preWrapper" markdown="1">
      UPDATE t2 SET c2 =?
         -- type is assumed to be type of c2
  {: .Example}

  </div>

* Dynamic parameters are allowed as the operand of the unary operators
  `-` or `+`. For example:
  <div class="preWrapper" markdown="1">
      CREATE TABLE t1 (c11 INT, c12 SMALLINT, c13 DOUBLE, c14 CHAR(3))
      SELECT * FROM t1 WHERE c11 BETWEEN -? AND +?
         -- The type of both of the unary operators is INT
         -- based on the context in which they are used (that is,
         -- because c11 is INT, the unary parameters also get the
         -- type INT.
  {: .Example}

  </div>

* `LENGTH` allow a dynamic parameter. The type is assumed to be a
  maximum length `VARCHAR` type.
  <div class="preWrapper" markdown="1">
      SELECT LENGTH(?)
  {: .Example}

  </div>

* Qualified comparisons.
  <div class="preWrapper" markdown="1">
      ? = SOME (SELECT 1 FROM t)
         -- is valid. Dynamic parameter assumed to be INTEGER type

      1 = SOME (SELECT ? FROM t)
         -- is valid. Dynamic parameter assumed to be INTEGER type.
  {: .Example xml:space="preserve"}

  </div>

* A dynamic parameter is allowed as the left operand of an `IS`
  expression and is assumed to be a `Boolean`.

</div>
</section>
