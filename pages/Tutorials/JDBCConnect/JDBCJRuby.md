---
title: Connecting to Splice Machine with JRuby and JDBC
summary: Walks you through compiling and running a JRuby program that connects to your Splice Machine database via our JDBC driver.
keywords: JDBC, JRuby,
toc: false
product: all
sidebar: tutorials_sidebar
permalink: tutorials_connect_jruby.html
folder: Tutorials/Import
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Connecting to Splice Machine with JRuby and JDBC

This topic shows you how to compile and run a sample JRuby program that
connects to Splice Machine using our JDBC driver. The
`JRubyJDBC` program does the following:

* connects to a standalone (`localhost`) version of Splice Machine
* selects and displays the records in a table

## Compile and Run the Sample Program   {#Compile}

This section walks you through compiling and running the `JRubyJDBC`
example program, in the following steps:

<div class="opsStepsList" markdown="1">
1.  Install the JDBC Adapter gem
    {: .topLevel}

    Use the following command to install the
    `activerecord-jdbcderby-adapter` gem:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        gem install activerecord-jdbcderby-adapter
    {: .ShellCommand xml:space="preserve"}

    </div>

2.  Configure the connection
    {: .topLevel}

    You must assign the database connectivity parameters in the
    `config/database.yml` file for your JRuby application. Your
    connectivity parameters should look like the following, which use
    our default database, user, URL, and password values:

    <div class="preWrapperWide" markdown="1">
        # Configure Using Gemfile
        # gem 'activerecord-jdbcsqlite3-adapter'
        # gem 'activerecord-jdbcderby-adapter'
        #
        development:
            adapter: jdbcderby
            database: splicedb
            username: splice
            password: admin
            driver: com.splicemachine.db.jdbc.ClientDriver
            url: jdbc:splice://localhost:1527/splicedb
    {: .AppCommand xml:space="preserve"}

    </div>

    Use <span class="CodeBoldFont">localhost:1527</span> with the
    standalone (local computer) version of splicemachine. If you're
    running Splice Machine on a cluster, substitute the address of your
    server for `localhost`; for example:
       <span
    class="CodeBoldFont">jdbc:splice://mySrv123cba:1527/splicedb</span>.
    {: .noteIcon}

3.  Create the sample data table
    {: .topLevel}

    Create the `MYTESTTABLE` table in your database and add a little
    test data. Your table should look something like the following:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        splice> describe SPLICE.MYTESTTABLE;
        COLUMN_NAME         |TYPE_NAME|DEC |NUM |COLUMN|COLUMN_DEF|CHAR_OCTE |IS_NULL
        ------------------------------------------------------------------------------
        A                   |INTEGER  |0   |10  |10    |NULL      |NULL      |YES
        B                   |VARCHAR  |NULL|NULL|30    |NULL      |60        |YES

        2 rows selected

        splice> select * from MYTESTTABLE order by A;
        A     |B
        ---------------------------
        1     |a
        2     |b
        3     |c
        4     |c
        5     |c

        5 rows selected
    {: .AppCommand xml:space="preserve"}

    </div>

4.  Copy the code
    {: .topLevel}

    You can copy the example program code and paste it into your editor:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        require 'java'

        module JavaLang
        include_package "java.lang"
        end

        module JavaSql
        include_package 'java.sql'
        end

        import 'com.splicemachine.db.jdbc.ClientDriver'

        begin
            conn = JavaSql::DriverManager.getConnection("jdbc:splice://localhost:1527/splicedb;user=splice;password=admin");
            stmt = conn.createStatement
            rs = stmt.executeQuery("select a, b from MYTESTTABLE")
            counter = 0
            while (rs.next) do
                counter+=1
                puts "Record=[" + counter.to_s + "] a=[" + rs.getInt("a").to_s + "] b=[" + rs.getString("b") + "]"
            end
            rs.close
            stmt.close
            conn.close()
            rescue JavaLang::ClassNotFoundException => e
                stderr.print "Java told me: #{e}n"
            rescue JavaSql::SQLException => e
                stderr.print "Java told me: #{e}n"
        end
    {: .Example}

    </div>

5.  Run the program
    {: .topLevel}

    Run the `JRubyConnect` program as follows
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        jruby jrubyjdbc.rb
    {: .ShellCommand xml:space="preserve"}

    </div>

    The command should display a result like the following:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">

        Record=[1] a=[3] b=[c]
        Record=[2] a=[4] b=[c]
        Record=[3] a=[5] b=[c]
        Record=[4] a=[1] b=[a]
        Record=[5] a=[2] b=[b]
    {: .AppCommand xml:space="preserve"}

    </div>
{: .boldFont}

</div>
</div>
</section>
