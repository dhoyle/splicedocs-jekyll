---
summary: How to use the standalone version sample data.
title: Importing and Querying Standalone Demo Data
keywords: sample data, demo data, importing
toc: false
product: onprem
sidebar:  getstarted_sidebar
permalink: onprem_install_demodata.html
folder: OnPrem/InstallingSpliceMachine
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Importing and Querying Standalone Demo Data

The standalone version of Splice Machine includes sample data that you can
use to quickly try importing and querying meaningful data. This topic walks you through using the sample data.

You must install the standalone version of Splice Machine on your computer before
following the steps in this tutorial. You'll find the link to the standalone installer and instructions in our [Installing Splice Machine](onprem_install_intro.html) page.
{: .noteIcon}

The Splice Machine installer package includes demo data that you can
import into your database, so you can get used to working with your new
database. We recommend that you follow the steps in this topic to import
this demo data, and then run a few test queries against it to verify
your installation.

## About the Demo Data

The demo data included in your installer package requires about 30 MB in
compressed format. Importing the demo data creates three tables, each of
which contains one million records:

<table summary="Sample data tables">
                <col width="112px" />
                <col width="70%" />
                <tbody>
                    <tr>
                        <th>Table</th>
                        <th>Description</th>
                    </tr>
                    <tr>
                        <td><code>T_HEADER</code>
                        </td>
                        <td>Standard <em>headers</em> from a transaction system</td>
                    </tr>
                    <tr>
                        <td><code>T_DETAIL</code>
                        </td>
                        <td>Standard <em>detail</em> records from a transaction system</td>
                    </tr>
                    <tr>
                        <td><code>CUSTOMERS</code>
                        </td>
                        <td>A list of target <em>customers</em></td>
                    </tr>
                </tbody>
            </table>
## Follow the Written Instructions

### Import the Data

Follow these steps to import the demo data into your Splice Machine
database:

<div class="opsStepsList" markdown="1">
1.  Start the command line interpreter
    {: .topLevel}

    You can use the Splice Machine command line interpreter (CLI), or
    <span class="AppCommand">splice&gt;</span> prompt, to work directly
    with your database. If you're using the cluster version of Splice
    Machine, you can access the <span
    class="AppCommand">splice&gt;</span> prompt by entering this shell
    command on any node on which it is available:
    {: .indentLevel1}

    <div class="preWrapper" markdown="1">
        ./sqlshell.sh
    {: .ShellCommand xml:space="preserve"}

    </div>

    If you're using the standalone version of Splice Machine, use these
    steps to access the <span
    class="AppCommand">splice&gt;</span> prompt:
    {: .indentLevel1}

    <div class="preWrapper" markdown="1">
        cd <your.splicemachine-directory>
        ./bin/sqlshell.sh
    {: .ShellCommand xml:space="preserve"}

    </div>

2.  Modify the script that loads the data to use your path:
    {: .topLevel}

    Before running the <span class="AppCommand">loadall.sql</span>
    script, you must change the file path used in the script.
    {: .indentLevel1}

    There are calls to `SYSCS_UTIL.IMPORT_DATA` near the bottom of the
    script. Change the file path parameter in each of these calls to use
    the absolute path to your Splice Machine `demodata` directory:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        call SYSCS_UTIL.IMPORT_DATA('SPLICE', 'T_HEADER',  null, '<yourPath>/demodata/data/theader.csv', ...;call SYSCS_UTIL.IMPORT_DATA('SPLICE', 'T_DETAIL',  null, '<yourPath>/demodata/data/tdetail.csv', ...;call SYSCS_UTIL.IMPORT_DATA('SPLICE', 'CUSTOMERS', null, '<yourPath>/demodata/data/customers.csv', ...;
    {: .ShellCommand xml:space="preserve"}

    </div>

    Make sure you use the absolute (versus relative) path. For example:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        call SYSCS_UTIL.IMPORT_DATA('SPLICE', 'T_HEADER',  null, '/Users/myName/mySplice/demodata/data/theader.csv', ...;call SYSCS_UTIL.IMPORT_DATA('SPLICE', 'T_DETAIL',  null, '/Users/myName/mySplice/demodata/data/tdetail.csv', ...;call SYSCS_UTIL.IMPORT_DATA('SPLICE', 'CUSTOMERS', null, '/Users/myName/mySplice/demodata/data/customers.csv',...;
    {: .ShellCommand xml:space="preserve"}

    </div>

3.  Run the modify script to loads the data:
    {: .topLevel}

    From the <span class="AppCommand">splice&gt;</span> prompt, *run*
    the file that will load the data, using single quotes around the
    path/filename (and remember to include the semicolon at the end):
    {: .indentLevel1}

    <div class="preWrapper" markdown="1">
        splice> run 'demodata/sql/loadall.sql';
    {: .ShellCommand xml:space="preserve"}

    </div>

4.  Wait for the script to finish
    {: .topLevel}

    If your database is not currently running, start it up and launch
    the command line interpreter (<span
    class="AppCommand">splice&gt;</span> prompt) by issuing this command
    in your terminal window:
    {: .indentLevel1}

    <div class="preWrapper" markdown="1">
        ./bin/sqlshell.sh
    {: .ShellCommand xml:space="preserve"}

    </div>

    The loading process can take several minutes: the `loadall.sql` file
    creates the schema, loads the data, and creates indexes for the
    tables.
    {: .indentLevel1}

    While the database is running, logging information is written to the
    `splice.log` file, which is found in the `splicemachine` directory.
    {: .noteNote}

    When you again see the <span class="AppCommand">splice&gt;</span>
    prompt, the demo data is ready to use. We recommend running the
    sample queries in the next section to get a feel for using Splice
    Machine and the demo data.
    {: .indentLevel1}
{: .boldFont}

</div>
### Run Sample Queries

After you have imported the demo data, you can use the <span
class="AppCommand">splice&gt;</span> command line interpreter to run the
sample queries on this page to get some experience with using Splice
Machine.

You can simply copy the select command from each of the samples below to
your clipboard. Then paste from the clipboard at the <span
class="AppCommand">splice&gt;</span> prompt and press the *Enter* key or
*Return* key to submit the query.

#### Example of Selecting a Subset

You can use the following query to select the customer IDs from a subset
of the transaction detail (`T_DETAIL`) table, based on transaction date
and category ID.

<div class="preWrapperWide" markdown="1">
    select customer_master_id
       from T_DETAIL d
       where TRANSACTION_DT >= DATE('2010-01-01')
          and TRANSACTION_DT <= DATE('2013-12-31')
          AND ORIGINAL_SKU_CATEGORY_ID >= 44427
          and original_sku_category_id <= 44431;
{: .Example xml:space="preserve"}

</div>
#### Example of Selecting With a Join

You can use the following to query a join of the `T_HEADER` and
`CUSTOMERS` tables.

<div class="preWrapperWide" markdown="1">

    select t.transaction_header_key, t.transaction_dt, t.store_nbr,
           t.geocapture_flg, t.exchange_rate_percent    from T_HEADER t, CUSTOMERS c   where c.customer_master_id=t.customer_master_id   and t.customer_master_id > 14000
       and t.customer_master_id < 15000;
{: .Example xml:space="preserve"}

</div>
### Troubleshooting Transaction Exceptions on MacOS

If you're running transactions in the standalone version of
Splice Machine on MacOS, you may run into an exception caused by the
clock having moved backwards. This happens only rarely, and is due to
the fact that OS X has its own time-maintenance daemon that can (rarely)
cause the clock to move backwards, which causes a transaction exception.

When this happens, you'll see an exception messages like the following:

<div class="preWrapperWide" markdown="1">
    SQLSTATE: XJ001Java exception: 'java.io.IOException: java.lang.IllegalStateException: Unable to obtain timestamp, clock moved backwards
{: .AppCommand}

</div>
To correct the problem, simply re-run the query or statement that
generated the exception.

</div>
</section>
