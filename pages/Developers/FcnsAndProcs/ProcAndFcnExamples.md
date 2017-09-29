---
title: Examples of Splice Machine Functions and Procedures
summary: Examples of creating and using database functions and stored procedures.
keywords: stored procedures, examples
toc: false
product: all
sidebar: developers_sidebar
permalink: developers_fcnsandprocs_examples.html
folder: Developers/FcnsAndProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Examples of Splice Machine Functions and Stored Procedures

This topic walks you through creating, storing, and using a sample
database function and a sample database stored procedure, in these
sections:

* [Creating and Using a Sample Function in Splice
  Machine](#CreatingSampleFunction)
* [Creating and Using a Sample Stored Procedure in Splice
  Machine](#CreatingSampleProc)

## Creating and Using a Sample Function in Splice Machine   {#CreatingSampleFunction}

This section walks you through creating a sample function named
`word_limiter` that limits the number of words in a string; for example,
given this sentence:

> <span class="AppCommand">Today is a wonderful day and I am looking
> forward to going to the beach.</span>

If you tell `word_limiter` to return the first five words in the
sentence, the returned string would be:

> <span class="AppCommand">Today is a wonderful day</span>

Follow these steps to define and use the `word_limiter` function:

<div class="opsStepsList" markdown="1">
1.  Define inputs and outputs
    {: .topLevel}

    We have two inputs:
    {: .indentLevel1}

    * <span class="PlainFont">the sentence that we want to limit</span>
    * <span class="PlainFont">the number of words to which we want to limit the output</span>
    
    The output is a string that contains the limited words.
    {: .indentLevel1}

2.  Create the shell of our Java class.
    {: .topLevel}

    We create a class named `ExampleStringFunctions` in the package
    `com.splicemachine.examples`.
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">

        package com.splicemachine.example;

        public class ExampleStringFunctions {...
        }
    {: .Example xml:space="preserve"}

    </div>

3.  Create the `wordLimiter` static method
    {: .topLevel}

    This method contains the logic for returning the first n number of
    words:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        package com.splicemachine.example;

        public class ExampleStringFunctions {
        	/**
        	 * Truncates a string to the number of words specified.  An input of
        	 * "Today is a wonderful day and I am looking forward to going to the beach.", 5
        	 * will return "Today is a wonderful day".
        	 *
        	 * @param inboundSentence
        	 * @param numberOfWords
        	 * @return
        	 */
        	public static String wordLimiter(String inboundSentence, int numberOfWords) {
        		String truncatedString = "";
        		if(inboundSentence != null) {
        			String[] splitBySpace = inboundSentence.split("\\s+");
        			if(splitBySpace.length = numberOfWords) {
        				truncatedString = inboundSentence;
        			} else {
        				StringBuilder sb = new StringBuilder();
        				for(int i=0; inumberOfWords; i++) {
        					if(i > 0) sb.append(" ");
        					sb.append(splitBySpace[i]);
        				}
        				truncatedString = sb.toString();
        			}
        		}
        		return truncatedString;
        	}
        }
    {: .Example}

    </div>

4.  Compile the class and store the jar file
    {: .topLevel}

    After you compile your class, make sure that the jar file is in a
    directory in your `classpath`, so that it can be found. You can find
    more information about this in the [Storing and Updating Functions
    and Stored Procedures](developers_fcnsandprocs_storing.html) topic
    in this section.
    {: .indentLevel1}

    If you're using the standalone version of Splice Machine, you can
    use the following command line interface command:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        splice> CALL SQLJ.INSTALL_JAR('/Users/me/dev/workspace/examples/bin/example.jar', 'SPLICE.MY_EXAMPLE_APP', 0);
    {: .AppCommand xml:space="preserve"}

    </div>

    You must also update the database class path:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        splice> CALL SYSCS_UTIL.SYSCS_SET_DATABASE_PROPERTY('derby.database.classpath', 'SPLICE.MY_EXAMPLE_APP');
    {: .AppCommand xml:space="preserve"}

    </div>

5.  Define the function in Splice Machine
    {: .topLevel}

    You can find the complete syntax for
   &nbsp;[`CREATE FUNCTION`](sqlref_statements_createfunction.html) in the
    *Splice Machine SQL Reference* manual. For our example function, we
    enter the following command at the `splice>` prompt:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">

        splice> CREATE FUNCTION WORD_LIMITER(MY_SENTENCE VARCHAR(9999), NUM_WORDS INT) RETURNS VARCHAR(9999)
        LANGUAGE JAVA
        PARAMETER STYLE JAVA
        NO SQL
        EXTERNAL NAME 'com.splicemachine.example.ExampleStringFunctions.wordLimiter';
    {: .AppCommand xml:space="preserve"}

    </div>

6.  Run the function
    {: .topLevel}

    You can run the function with this syntax:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        splice> SELECT WORD_LIMITER('Today is a wonderful day and I am looking forward to going to the beach.', 5)
           FROM SYSIBM.SYSDUMMY1;
    {: .AppCommand xml:space="preserve"}

    </div>
{: .boldFont}

</div>
## Creating and Using a Sample Stored Procedure in Splice Machine   {#CreatingSampleProc}

In this section , we create a stored procedure named
`GET_INVENTORY_FOR_SKU` that retrieves all of the inventory records for
a specific product by using the product's sku code. The input to this
procedure is the sku code, and the output is a resultset of records from
the inventory table.

Follow these steps to define and use the `GET_INVENTORY_FOR_SKU`
function:

<div class="opsStepsList" markdown="1">
1.  Create and populate the inventory table
    {: .topLevel}

    Connect to Splice Machine and create the following table from the
    command prompt or from an SQL client, using the following
    statements:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">

        CREATE TABLE INVENTORY (
           SKU_CODE VARCHAR(30),
           WAREHOUSE BIGINT,
           QUANTITY BIGINT
        );

        INSERT INTO INVENTORY VALUES ('ABC123',1,50),('ABC123',2,100),('ABC123',3,60),('XYZ987',1,20),('XYZ321',2,0);
    {: .AppCommand xml:space="preserve"}

    </div>

2.  Create the shell of our Java class.
    {: .topLevel}

    We create a class named `ExampleStringFunctions` in the package
    `com.splicemachine.examples`.
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">

        package com.splicemachine.example;

        public class ExampleStoredProcedure{...
        }
    {: .Example xml:space="preserve"}

    </div>

3.  Create the `getSkuInventory` static method
    {: .topLevel}

    This method contains the logic for retrieving inventory records for
    the specified sku.
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        package com.splicemachine.example;

        import java.sql.Connection;
        import java.sql.DriverManager;
        import java.sql.PreparedStatement;
        import java.sql.ResultSet;
        import java.sql.SQLException;
        public class ExampleStoredProcedure {
           public static void getSkuInventory(String skuCode, ResultSet[] resultSet) throws SQLException {
              try {
                   Connection con = DriverManager.getConnection("jdbc:default:connection");
                   String sql = "select * from INVENTORY " + "where SKU_CODE = ?";
                   PreparedStatement ps = con.prepareStatement(sql);
                   ps.setString(1, skuCode);
                   resultSet[0] = ps.executeQuery();;
              } catch (SQLException e) {
                   throw e;
              }
           }
        }
    {: .Example}

    </div>

4.  Compile the class and store the jar file
    {: .topLevel}

    After you compile your class, make sure that the jar file is in a
    directory in your `classpath`, so that it can be found. You can find
    more information about this in the [Storing and Updating Functions
    and Stored Procedures](developers_fcnsandprocs_storing.html) topic
    in this section.
    {: .indentLevel1}

    If you're using the standalone version of Splice Machine, you can
    use the following command line interface command:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        splice> CALL SQLJ.INSTALL_JAR('/Users/me/dev/workspace/examples/bin/example.jar', 'SPLICE.GET_SKU_INVENTORY', 0);
    {: .AppCommand xml:space="preserve"}

    </div>

    You must also update the database class path:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        splice> CALL SYSCS_UTIL.SYSCS_SET_DATABASE_PROPERTY('derby.database.classpath', 'SPLICE.GET_SKU_INVENTORY');
    {: .AppCommand xml:space="preserve"}

    </div>

5.  Define the procedure in Splice Machine
    {: .topLevel}

    For our procedure, we enter the following command at the
    `splice>` prompt:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">

        splice> CREATE PROCEDURE GET_INVENTORY_FOR_SKU(SKU_CODE VARCHAR(30))
        LANGUAGE JAVA
        PARAMETER STYLE JAVA
        READS SQL DATA
        EXTERNAL NAME 'com.splicemachine.example.ExampleStoredProcedure.getSkuInventory';
    {: .AppCommand xml:space="preserve"}

    </div>

6.  Run the stored procedure
    {: .topLevel}

    You can run the procedure with this syntax:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        splice> call GET_INVENTORY_FOR_SKU('ABC123');
    {: .AppCommand xml:space="preserve"}

    </div>
{: .boldFont}

</div>
</div>
</section>
