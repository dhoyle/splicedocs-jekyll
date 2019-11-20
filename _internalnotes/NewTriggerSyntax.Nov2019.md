	The CREATE TRIGGER syntax isn’t really changing, just getting a few optional additions, including the WHEN clause which will have the same syntax as in DB2.  The "MODE DB2SQL” clause is added, but optional, and doesn’t have any effect (just allows DB2 triggers to be accepted without modification).  “INSTEAD OF” triggers are not supported, just BEFORE and AFTER triggers.  “NO CASCADE BEFORE” will be accepted, but have the same behavior as "BEFORE".  The SECURED and NOT SECURED phrases are not accepted.  We’ll also support BEGIN ATOMIC statement; END.  Another Jira is opened to support multiple trigger action statements (separated by semicolons) in the BEGIN ATOMIC block.
Currently Splice does not support statement triggers (“FOR EACH STATEMENT”) when OLD_TABLE or NEW_TABLE is specified, but there is a Jira open to add support for this.

DB2 trigger syntax:


```
CREATE TRIGGER <a href="sqlref_identifiers_types.html#TriggerName">TriggerName</a>
   { AFTER | [NO CASCADE] BEFORE }
   { INSERT | DELETE | UPDATE [ OF column-Name [, <a href="sqlref_identifiers_types.html#ColumnName">column-Name</a>]* ] }
   ON { <a href="sqlref_identifiers_types.html#TableName">table-Name</a> | <a href="sqlref_identifiers_types.html#ViewName">view-Name</a>
      [ <a href="sqlref_statements_createtrigger.html#ReferencingClause">ReferencingClause</a> ]
      [ FOR EACH { ROW | STATEMENT } ]
   Triggered-Action
```
{: .FcnSyntax}

### Referencing Clause

```
REFERENCING {  OLD AS correlation-name
             | NEW AS correlation-name
             | OLD_TABLE AS table-Name
             | NEW_TABLE AS table-Name }
```
{: .FcnSyntax}

Triggered-Action:
```
[WHEN search-condition] { triggered-sql-statement | BEGIN ATOMIC triggered-sql-statement+ END}
```
{: .FcnSyntax}

FOR EACH STATEMENT not supported when there's an OLD_TABLE or NEW_TABLE referencing clause
MODE DB2SQL syntax is accepted but has no impact
Triggered-SQL-statement will become Triggered-SQL-statement+
BEGIN ATOMIC currently only supports 1 statement
