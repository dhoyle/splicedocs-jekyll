---
title: ODBC Access to Splice Machine with Kerberos
summary: ODBC Access to Splice Machine with Kerberos
keywords: kerberos
toc: false
product: all
sidebar: developers_sidebar
permalink: developers_connectodbc_kerberos.html
folder: DeveloperTopics/ODBCConnect
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

# ODBC Access to Splice Machine with Kerberos

This section shows you how to connect your applications to Splice Machine on a Kerberized cluster, using our ODBC driver. As a prerequisite to connecting, you must ensure that:

* Database users are added in the Kerberos realm as principals.
* Keytab entries have been generated and deployed to the remote clients on
  which the applications are going to connect.

See [Enabling Kerberos Authentication](tutorials_security_usingkerberos.html) for information about using Splice Machine on a Kerberized cluster.

## Connecting Splice Machine with Kerberos and ODBC {#ODBCAccess}

Follow these steps to connect to a Kerberized cluster with ODBC:

<div class="opsStepsList" markdown="1">
1. [Follow our instructions for installing and configuring our ODBC driver](tutorials_connect_odbcinstall.html). Verify that the `odbc.ini` configuration file for the DSN you're connecting to includes this setting:
   {: .topLevel}

    <div class="preWrapperWide" markdown="0"><pre class="Example">
    USE_KERBEROS=1</pre>
    </div>

2. Establish a default security principal user with a ticket-granting ticket (*TGT*) in the ticket
  cache prior to invoking the driver. You can use the following command to establish
  the principal user:
   {: .topLevel}

    <div class="preWrapperWide" markdown="0"><pre class="ShellCommand">
    kinit <em>principal</em></pre>
    </div>
    Where *principal* is the name of the user who will be accessing Splice Machine.
    Enter the password for this user when prompted.

3. Launch the application that connects using ODBC; our ODBC driver will use
  that default Kerberos *principal* when authenticating with Splice Machine.
   {: .topLevel}
</div>

</div>
</section>
