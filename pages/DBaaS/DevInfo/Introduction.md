---
title: Introduction
summary: Quick start for Developers Using our Database-as-Service product.
keywords: dbaas, Service, paas
sidebar:  getstarted_sidebar
toc: false
product: all
permalink: dbaas_devinfo_intro.html
folder: DBaaS/DevInfo
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Splice Machine Database Service Developer Info

This topic includes information to help you quickly find your way to development work with the Splice Machine Database-as-Service product on your computer.

You can connect to Splice Machine from your computer using:

* [Our JDBC driver](#jdbc)
* [Our ODBC driver](#odbc)
* [Our Command Line Interface (`splice>`) client](#cli).

## Downloading our Clients

The links to these clients are all found in either of these locations:

* The `new cluster created` email message that you received when your cluster became available
* At the bottom of the [Cluster Management](dbaas_cm_managecluster.html) page in your Cloud Manager Dashboard:
  ![](images/dbaaslinks.jpg){: .bordered}

Java must be installed on the computer you're using. Our connection clients currently require JDK 1.8.
{: .noteIcon}

## Using our JDBC driver {#jdbc}

To use our JDBC driver, follow these steps:

1. Download the JDBC driver JAR file by clicking the <span class="ConsoleLink">Download JDBC Driver</span> link in your cluster management screen (or from your `new cluster` email).

2. Connect to your database from your program using the `JDBC URL` shown in the email or cluster management screen.

## Using our ODBC driver {#odbc}

To use our ODBC driver, follow these steps:

1. Download the ODBC driver by clicking the <span class="ConsoleLink">Download ODBC Driver</span> link in your cluster management screen (or from your `new cluster` email).

2. Install the ODBC driver: follow the instructions in our [ODBC installation tutorial](tutorials_connect_odbcinstall.html).

3. Connect to your database from your program using the `JDBC URL` shown in the email or cluster management screen.

## Using our Command Line Client {#cli}

To use the `splice>` command line interface with your cloud-managed database, follow these steps:

1. Download the `sqlshell.sh` client tarball (`.gz` file) to your computer by clicking the <span class="ConsoleLink">Download Sqlshell Client</span> link, either in the `new cluster` email you received or at the bottom of your Cluster Management page.

2. Copy the tarball to wherever you want it installed; we recommend a directory named `splicemachine`.

3. Untar the downloaded file using the `-xzf` flags; for example:

    <div class="preWrapperWide" markdown="1">
       tar -xzf sqlshell-2.6.1.1735.tar.gz
    {: .ShellCommand}
    </div>

4. Navigate to the subdirectory created for the client:

    <div class="preWrapperWide" markdown="1">
       cd sqlshell
    {: .ShellCommand}
    </div>

5. Run the client:

    <div class="preWrapperWide" markdown="1">
       ./sqlshell.sh -h <hostname>
    {: .ShellCommand}
    </div>

   The <span class="HighlightedCode">&lt;hostname&gt;</span> is part of the `JDBC URL` that you'll find in either the `new cluster` email or at the bottom of the Cluster Management screen for your cluster. Specifically, it's the part of the URL that follows `jdbc:splice://` and precedes `:1527`. For example, if your JDBC URL is this:
   ````
       jdbc:splice://myaccount-mycluster.splicemachine.io:1527
   ````

   Then your hostname is:
   ````
       myaccount-mycluster.splicemachine.io
   ````

We recommend installing `rlwrap` to use with `sqlshell`. The [rlwrap utility](cmdlineref_using_rlwrap.html) allows you to access and edit command lines that you've previously entered, and can save a lot of time.
{: .noteNote}

</div>
</section>
