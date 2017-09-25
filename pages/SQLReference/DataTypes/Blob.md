---
title: BLOB data type
summary: The BLOB (binary large object) data type is used for varying-length binary strings that can be up to 2,147,483,647 characters long.
keywords: binary, binary large object, varying-length
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_datatypes_blob.html
folder: SQLReference/DataTypes
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# BLOB   {#DataTypes.Blob}

A `BLOB` (binary large object) value is a varying-length binary string
that can be up to 2GB (`2,147,483,647`) characters long.

If you're using a BLOB with the 32-bit version of our ODBC driver, the
size of the BLOB is limited to 512 MB, due to address space limitations.
{: .noteRestriction}

Like other binary types, `BLOB`strings are not associated with a code
page. In addition, `BLOB`strings do not hold character data.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    {BLOB | BINARY LARGE OBJECT} [ ( length [{K |M |G}] ) ]
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
length
{: .paramName}

An unsigned integer constant that specifies the number of characters in
the `BLOB` unless you specify one of the suffixes you see below, which
change the meaning of the *length* value. If you do not specify a length
value, it defaults to two gigabytes (2,147,483,647).
{: .paramDefnFirst}

K
{: .paramName}

If specified, indicates that the length value is in multiples of 1024
(kilobytes).
{: .paramDefnFirst}

M
{: .paramName}

If specified, indicates that the length value is in multiples of
1024*1024 (megabytes).
{: .paramDefnFirst}

G
{: .paramName}

If specified, indicates that the length value is in multiples of
1024*1024*1024 (gigabytes).
{: .paramDefnFirst}

</div>
## Corresponding Compile-time Java Type

<div class="fcnWrapperWide" markdown="1">
    java.sql.Blob
{: .FcnSyntax}

</div>
## JDBC Metadata Type (java.sql.Types)

<div class="fcnWrapperWide" markdown="1">
    BLOB
{: .FcnSyntax}

</div>
## Usage Notes

Use the *getBlob* method on the *java.sql.ResultSet* to retrieve a
`BLOB` handle to the underlying data.

There are a number of restrictions on using `BLOB` and `CLOB` / `TEXT`
objects, which we refer to as LOB-types:

* LOB-types cannot be compared for equality (`=`) and non-equality
  (`!=`, `<>`).
* LOB-typed values cannot be ordered, so `<, <=, >, >=` tests are not
  supported.
* LOB-types cannot be used in indexes or as primary key columns.
* `DISTINCT`, `GROUP BY`, and `ORDER BY` clauses are also prohibited on
  LOB-types.
* LOB-types cannot be involved in implicit casting as other base-types.

## Example

Using an [`INSERT`](sqlref_statements_insert.html) statement to put
`BLOB` data into a table has some limitations if you need to cast a long
string constant to a `BLOB`. You may be better off using a binary
stream, as in the following code fragment.

<div class="preWrapperWide" markdown="1">
    package com.splicemachine.tutorials.blob;
    
    import java.io.FileInputStream;
    import java.io.FileNotFoundException;
    import java.io.InputStream;
    import java.sql.Connection;
    import java.sql.DriverManager;
    import java.sql.PreparedStatement;
    import java.sql.ResultSet;
    import java.sql.SQLException;
    import java.sql.Statement;
    
    public class ExampleInsertBlob {
    
        /**
         * Example of inserting a blob using JDBC
         *
         * @param args[0] - Image file to insert
         * @param args[1] - JDBC URL - optional - defaults to localhost
         */
        public static void main(String[] args) {
            Connection conn = null;
            Statement statement = null;
            ResultSet rs = null;
    
            if(args.length == 0) {
                System.out.println("You must pass in an file (like an image) to be loaded");
            }
    
            try {
    
                String imageFileToLoad = args[0];
    
                //Default JDBC Connection String - connects to local database
                String dbUrl = "jdbc:splice://localhost:1527/splicedb;user=splice;password=true";
    
                //Checks to see if a JDBC URL is passed in
                if(args.length > 1) {
                    dbUrl = args[1];
                }
    
                //For the JDBC Driver - Use the Splice Machine Client Driver
                Class.forName("com.splicemachine.db.jdbc.ClientDriver");
    
                //Connect to the databae
                conn = DriverManager.getConnection(dbUrl);
    
                //Create a statement
                statement = conn.createStatement();
    
                //Create a table
                statement.execute("CREATE TABLE IMAGES(a INT, test BLOB)");
    
    
                //Create an input stream
                InputStream fin = new FileInputStream(imageFileToLoad);
                PreparedStatement ps = conn.prepareStatement("INSERT INTO IMAGES VALUES (?, ?)");
                ps.setInt(1, 1477);
    
                // - set value of input parameter to the input stream
                ps.setBinaryStream(2, fin);
                ps.execute();
    
                ps.close();
    
                //Lets get the count of records
                rs = statement.executeQuery("select count(1) from IMAGES");
                if(rs.next()) {
                    System.out.println("count=[" + rs.getInt(1) + "]");
                }
    
            } catch (ClassNotFoundException cne) {
                cne.printStackTrace();
            } catch (SQLException se) {
                se.printStackTrace();
            } catch (FileNotFoundException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            } finally {
                if(rs != null) {
                    try { rs.close(); } catch (Exception ignore) { }
                }
                if(statement != null) {
                    try { statement.close(); } catch (Exception ignore) { }
                }
                if(conn != null) {
                    try { conn.close(); } catch (Exception ignore) { }
                }
    
            }
        }
    
    }
{: .Example}

</div>
</div>
</section>

