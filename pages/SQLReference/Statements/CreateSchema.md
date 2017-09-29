---
title: CREATE SCHEMA statement
summary: Creates a schema in your database
keywords:
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_statements_createschema.html
folder: SQLReference/Statements
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# CREATE SCHEMA

The `CREATE SCHEMA` statement allows you to create a database schema,
which is a way to logically group objects in a single collection and
provide a unique name-space for those objects.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    
    CREATE SCHEMA {
         [ schemaName ]
         }
{: .FcnSyntax xml:space="preserve"}

</div>
The `CREATE SCHEMA` statement is used to create a schema. A schema name
cannot exceed `128` characters. Schema names must be unique within the
database.

A schema name cannot start with the prefix `SYS` (after case
normalization). Use of the prefix `SYS` raises a *SQLException*.

## CREATE SCHEMA examples

To create a schema for airline-related tables, use the following syntax:

<div class="preWrapper" markdown="1">
    splice> CREATE SCHEMA FLIGHTS;
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
To create a schema employee-related tables, use the following syntax:

<div class="preWrapper" markdown="1">
    splice> CREATE SCHEMA EMP;
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
To create a table called `availability` in the `EMP` and `FLIGHTS`
schemas, use the following syntax:

<div class="preWrapperWide" markdown="1">
    splice> CREATE TABLE Flights.Availability(
       Flight_ID CHAR(6) NOT NULL,
       Segment_Number INT NOT NULL,
       Flight_Date DATE NOT NULL,
       Economy_Seats_Taken INT,
       Business_Seats_Taken INT,
       FirstClass_Seats_Taken INT,
       CONSTRAINT Flt_Avail_PK
       PRIMARY KEY (Flight_ID, Segment_Number, Flight_Date)
       );
    0 rows inserted/updated/deleted
    
    splice> CREATE TABLE EMP.AVAILABILITY(
       Hotel_ID INT NOT NULL,
       Booking_Date DATE NOT NULL,
       Rooms_Taken INT,
       CONSTRAINT HotelAvail_PK PRIMARY KEY (Hotel_ID, Booking_Date)
       );
    0 rows inserted/updated/deleted
{: .Example xml:space="preserve"}

</div>
## See Also

* [`DROP SCHEMA`](sqlref_statements_dropschema.html) statement
* [Schema Name](sqlref_identifiers_types.html#SchemaName)
* [`SET SCHEMA`](sqlref_statements_setschema.html) statement

</div>
</section>

