---
summary: How to install Splice Machine for Zeppelin.
title: Installing the Splice Machine Zeppelin Interpreter
keywords: sample data, demo data, importing
toc: false
product: onprem
sidebar:  onprem_sidebar
permalink: onprem_install_zeppelin.html
folder: OnPrem/InstallingSpliceMachine
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# How to Install Splice Machine for Zeppelin

This topic describes how to install the Splice Machine interpreter for Apache Zeppelin.

If you've not yet installed Zeppelin, please follow the official Apache instructions for the latest version. At the time of this writing, the latest version is 0.8.0, and the installation instructions are here:
```
    http://zeppelin.apache.org/docs/0.8.0/usage/interpreter/installation.html
```

## Add the Splice Machine Zeppelin Interpreter
To add the Splice Machine Zeppelin interpreter to the set of interpreters available in your Zeppelin environment, follow these steps:
{: .spaceAbove}

<div class="opsStepsList" markdown="1">
1.  Download the `splicemachine-zeppelin-0.8.0.jar` file. We recommend saving the download in the `/tmp` directory, though you can use another directory if you add it to the Zeppelin path.
    {: .topLevel}

2.  Navigate to your `zeppelin` home directory.
    {: .topLevel}

3.  Use the following command to install the Splice Machine interpreter for Zeppelin:
    ```
    .bin//install-interpreter.sh --name splicemachine --artifact /tmp/splicemachine-zeppelin-0.8.0.jar
    ```
    {: .ShellCommand}

    If you saved the jar file to a directory other than `/tmp`, remember to change its location in the install command.
    {: .spaceAbove}

4.  [Restart the Zeppelin server](#restartzep)
    {: .topLevel}

5.  Navigate to the <span class="ConsoleLink">Interpreter</span> page in Zeppelin, which is accessible from drop-down menu in the upper-right corner of the Zeppelin window.

6.  Click the <span class="ConsoleLink">Create</span> button in the Interpreter window. This opens a form; enter the following into the form fields:

    <table>
        <col />
        <col />
        <thead>
            <tr>
                <th>Field</th>
                <th>Value to Enter</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td class="CodeFont">Name</td>
                <td class="Example">splicemachine</td>
            </tr>
            <tr>
                <td class="CodeFont">Interpreter Group</td>
                <td>Select <span class="Example">splicemachine</span> from the drop-down menu.</td>
            </tr>
            <tr>
                <td class="CodeFont">default.user</td>
                <td>Set this value to your default user name; this value is initially set to <span class="Example">splice</span>.</td>
            </tr>
            <tr>
                <td class="CodeFont">default.password</td>
                <td>Set this value to your default password.</td>
            </tr>
            <tr>
                <td class="CodeFont">default.url</td>
                <td>Set this value to match your server's configuration; this value is initially set to <span class="Example">jdbc:splice://localhost:1527/splicedb</span>.</td>
            </tr>
            <tr>
                <td class="CodeFont">default.splitQueries</td>
                <td class="Example">true</td>
            </tr>
        </tbody>

7.  Save your changes.
</div>

## Restart Zeppelin {#restartzep}
After *installing* the Splice Machine interpreter, you need to restart Zeppelin again:

1. Stop Zeppelin:
   ```
   ./bin/zeppelin-daemon.sh stop
   ```
   {: .ShellCommand}

2. Start Zeppelin:
   ```
   ./bin/zeppelin-daemon.sh start
   ```
   {: .ShellCommand}


## Start Using Splice Machine in Your Zeppelin Notebooks

To use the new interpreter in a notebook, you must bind it into the notebook, following these steps:

<div class="opsStepsList" markdown="1">
1. Open or create a notebook in Zeppelin.
   {: .topLevel}

2. Click the gear icon in the upper right corner of the Zeppelin window to display the list of interpreters that are currently bound to this notebook:
   {: .topLevel}
   <img src="images/zepBindInterpreters.png" class="indentedTightSpacing" style="max-height:100px;" />

3. Scroll down through the list of interpreters, and click the `splicemachine` button: 
   {: .topLevel}
   <img src="images/zepBindSpliceInterpreter.png"  class="indentedTightSpacing" style="max-height:250px;" />

4. Click the <span class="ConsoleLink">Save</span> button to bind the interpreter to this notebook.
</div>

If you're able to connect to a Splice Machine instance, you can create paragraphs in your Zeppelin notebooks that work with your database, assuming: specify the `%splicemachine` interpreter at the top of the paragraph, and issue commands just as you would with the <span class="Example">splice</span> command line interpreter. For example:

<div class="preWrapperWide" markdown="1">
    %splicemachine
    drop table myTable;
    create table myTable ( id int, name varchar(64) );
    insert into myTable value (1, 'John Doe'), (2, 'Jane Doe');
    select * from myTable where id > 10;
{: .Example xml:space="preserve"}
</div>


</div>
</section>
