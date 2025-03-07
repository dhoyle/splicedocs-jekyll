---
title: Scripting the Splice Machine Command Line Interface
summary: Walks you through scripting a set of commands to submit to the splice&gt; command line interpreter.
keywords: scripting cli
toc: false
product: all
sidebar: home_sidebar
permalink: cmdlineref_using_cliscripting.html
folder: CmdLineReference/Using
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Scripting the Splice Machine Command Line Interface

You can use two methods to script the Splice Machine CLI:

* [Run CLI Commands from a Text File](#Running)
* [Run CLI Commands from a Shell Script](#Running2)

## Run CLI Commands from a Text File   {#Running}

You can create a simple text file of command lines and use the
`run` command to run the commands in that file. Follow these
steps:

<div class="opsStepsList" markdown="1">
1.  Create a file of SQL commands:
    {: .topLevel}

    First, create a file that contains any SQL commands you want to run
    against your Splice Machine database.
    {: .indentLevel1}

    For this example, we'll create a file named `mySQLScript.sql` that
    connects to a database, creates a table, inserts records into that
    table, and then displays the records in the table.
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        connect 'jdbc:splice://localhost:1527/splicedb;user=YourUserId;password=YourPassword';

        create table players (
         ID SMALLINT NOT NULL PRIMARY KEY,
         Team VARCHAR(64) NOT NULL,
         Name VARCHAR(64) NOT NULL,
         Position CHAR(2),
         DisplayName VARCHAR(24),
         BirthDate DATE );

        INSERT INTO Players
           VALUES (99, 'Giants', 'Joe Bojangles', 'C', 'Little Joey', '07/11/1991'),
                  (73, 'Giants', 'Lester Johns', 'P', 'Big John', '06/09/1984'),
                  (27, 'Cards', 'Earl Hastings', 'OF', 'Speedy Earl', '04/22/1982');

        SELECT * FROM Players;
    {: .Example xml:space="preserve"}

    </div>

2.  Start the CLI.
    {: .topLevel}

    If you have not already done so, start Splice Machine and the CLI. See [Introduction to the Command Line Interface](cmdlineref_using_getstarted.html) for more information.
    {: .indentLevel1}

3.  Run the SQL Script
    {: .topLevel}

    Run your script in the CLI using the &nbsp;[`run`](cmdlineref_run.html) command:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        run 'mySQLScript.sql';
    {: .AppCommand}

    </div>

    You will notice that the CLI displays exactly the same
    results as you would see if you typed each command line into the
    interface:
    {: .spaceAbove}

    <div class="preWrapperWide" markdown="1">
        splice> connect 'jdbc:splice://localhost:1527/splicedb;user=YourUserId;password=YourPassword';
        splice> create table players (
         ID SMALLINT NOT NULL PRIMARY KEY,
         Team VARCHAR(64) NOT NULL,
         Name VARCHAR(64) NOT NULL,
         Position CHAR(2),
         DisplayName VARCHAR(24),
         BirthDate DATE );
        0 rows inserted/updated/deleted
        splice> INSERT INTO Players
           VALUES (99, 'Giants', 'Joe Bojangles', 'C', 'Little Joey', '07/11/1991'),
                  (73, 'Giants', 'Lester Johns', 'P', 'Big John', '06/09/1984'),
                  (27, 'Cards', 'Earl Hastings', 'OF', 'Speedy Earl', '04/22/1982');
        3 rows inserted/updated/deleted
        splice> SELECT * FROM Players;
        ID    |TEAM      |NAME                   |POS&|DISPLAYNAME             |BIRTHDATE
        ----------------------------------------------------------------------------------
        27    |Cards     |Earl Hastings          |OF  |Speedy Earl             |1982-04-22
        73    |Giants    |Lester Johns           |P   |Big John                |1984-06-09
        99    |Giants    |Joe Bojangles          |C   |Little Joey             |1991-07-11

        3 rows selected
        splice>
    {: .AppCommand}

    </div>
{: .boldFont}

</div>
## Run CLI Commands from a Shell Script   {#Running2}

You can also use a shell script to start the Splice Manchine CLI and run commands using Unix heredoc (`<<`) input
redirection. For example, we can easily rework the SQL script we used in
the previous section into a shell script that starts the CLI, runs several commands/statements, and then exits the CLI.

<div class="opsStepsList" markdown="1">
1.  Create a shell script
    {: .topLevel}

    For this example, we'll create a file named `myShellScript.sql` that
    uses the same commands as we did in the previous example:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        #!/bin/bash
        echo "Running splice> commands from a shell script"
        ./bin/sqlshell.sh << EOFconnect 'jdbc:splice://localhost:1527/splicedb;user=YourUserId;password=YourPassword';

        create table players (
         ID SMALLINT NOT NULL PRIMARY KEY,
         Team VARCHAR(64) NOT NULL,
         Name VARCHAR(64) NOT NULL,
         Position CHAR(2),
         DisplayName VARCHAR(24),
         BirthDate DATE );

        INSERT INTO Players
           VALUES (99, 'Giants', 'Joe Bojangles', 'C', 'Little Joey', '07/11/1991'),
                  (73, 'Giants', 'Lester Johns', 'P', 'Big John', '06/09/1984'),
                  (27, 'Cards', 'Earl Hastings', 'OF', 'Speedy Earl', '04/22/1982');

        SELECT * FROM Players;exit;EOF
    {: .ShellCommand}
    </div>

    If you are not familiar with this kind of input redirection: the
    &lt;&lt; specifies that an interactive program (`./bin/sqlshell.sh`)
    will receive its input from the lines in the file until it
    encounters EOF. The program responds exactly as it would had a user
    directly typed in those commands.
    {: .indentLevel1}

2.  Make your script executable.
    {: .topLevel}

    Be sure to update permissions on your script file to allow it to
    run:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        chmod +x myShellScript.sh
    {: .ShellCommand}

    </div>

3.  Run the script
    {: .topLevel}

    In a terminal window, invoke the script:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        ./myShellScript.sh
    {: .ShellCommand}

    </div>

    You will notice that the Splice Machine CLI starts
    and runs exactly as it did in the SQL script example above, and then
    exits.
    {: .spaceAbove}

    <div class="preWrapperWide" markdown="1">
        Running Splice Machine Commands from a Shell Script...

         ========= rlwrap detected and enabled.  Use up and down arrow keys to scroll through command line history. ========

        Running Splice Machine SQL shell
        For help: "splice> help;"splice> connect 'jdbc:splice://srv55:1527/splicedb;user=YourUserId;password=YourPassword';
        splice> create table players (
         ID SMALLINT NOT NULL PRIMARY KEY,
         Team VARCHAR(64) NOT NULL,
         Name VARCHAR(64) NOT NULL,
         Position CHAR(2),
         DisplayName VARCHAR(24),
         BirthDate DATE );
        0 rows inserted/updated/deleted
        splice> INSERT INTO Players
           VALUES (99, 'Giants', 'Joe Bojangles', 'C', 'Little Joey', '07/11/1991'),
                  (73, 'Giants', 'Lester Johns', 'P', 'Big John', '06/09/1984'),
                  (27, 'Cards', 'Earl Hastings', 'OF', 'Speedy Earl', '04/22/1982');
        3 rows inserted/updated/deleted
        splice> SELECT * FROM Players;
        ID    |TEAM      |NAME                   |POS&|DISPLAYNAME             |BIRTHDATE
        ----------------------------------------------------------------------------------
        27    |Cards     |Earl Hastings          |OF  |Speedy Earl             |1982-04-22
        73    |Giants    |Lester Johns           |P   |Big John                |1984-06-09
        99    |Giants    |Joe Bojangles          |C   |Little Joey             |1991-07-11

        3 rows selected
    {: .ShellCommand}

    </div>
{: .boldFont}

</div>
### Using nohup for Long-Running Scripts   {#Nohup}

If you want to run an unattended shell script that may take a long time,
you can: use the Unix `nohup` utility, which allows you to start a
script in the background and redirect its output. This means that you
can start the script, log out, and view the output at a later time. For
example:

<div class="preWrapperWide" markdown="1">

    nohup ./myShellScript.sh > ./myShellScript.out 2>&1 &
{: .ShellCommand xml:space="preserve"}

</div>
Once you have issued this command, you can log out, and subsequently view
the output of your script in the `myShellScript.out` file.
{: .topLevel}

</div>
</section>
