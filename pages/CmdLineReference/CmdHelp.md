---
title: Help command
summary: Displays a list of the available commands.
keywords:
toc: false
product: all
sidebar: home_sidebar
permalink: cmdlineref_help.html
folder: CmdLineReference
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Help Command

The <span class="AppCommand">help</span> command displays a list of the
available <span class="AppCommand">splice&gt;</span> commands.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    HELP
{: .FcnSyntax xml:space="preserve"}

</div>
## Example

<div class="preWrapperWide" markdown="1">
    splice> help;
    
     Supported commands include:
    
      CONNECT 'url for database' [ PROTOCOL namedProtocol ] [ AS connectionName ];
                                   -- connects to database URL
                                   -- and may assign identifier
      AUTOCOMMIT [ ON | OFF ];     -- sets autocommit mode for the connection
      SHOW SCHEMAS;                -- lists all schemas in the current database
      SHOW [ TABLES | VIEWS | PROCEDURES | FUNCTIONS | SYNONYMS] { IN schema };
                                   -- lists tables, views, procedures, functions or synonyms
      SHOW INDEXES { IN schema | FROM table };
                                   -- lists indexes in a schema, or for a table
      SHOW ROLES;                  -- lists all defined roles in the database,
                                   -- sorted
      SHOW SETTABLE_ROLES;         -- lists the roles which can be set for the
                                   -- current connection, sorted
      DESCRIBE name;               -- lists columns in the named table
    
      COMMIT;                      -- commits the current transaction
      ROLLBACK;                    -- rolls back the current transaction
    
      PREPARE name AS 'SQL text'; -- prepares the SQL text
      EXECUTE { name | 'SQL text' } [ USING { name | 'SQL text' } ] ;
                                   -- executes the statement with parameter
                                   -- values from the USING result set row
      REMOVE name;                 -- removes the named previously prepared statement
    
      RUN 'filename';              -- run commands from the named file
    
      ELAPSEDTIME [ ON | OFF ];    -- sets elapsed time mode for splice
      MAXIMUMDISPLAYWIDTH integerValue;
                                   -- sets the maximum display width for
                                   -- each column to integerValue
    
      EXIT;                        -- exits splice
      HELP;                        -- shows this message
    
     Any unrecognized commands are treated as potential SQL commands and executed directly.
    
    splice>
{: .AppCommand xml:space="preserve"}

</div>
</div>
</section>

