---
summary: How to start your database.
title: Starting Your Database
keywords: starting
toc: false
product: onprem
sidebar:  onprem_sidebar
permalink: onprem_admin_startingdb.html
folder: OnPrem/Administrators
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Starting Your Database

* [Starting Your Splice Machine Database on a Cloudera-Managed
  Cluster](#StartDBCloudera)
* [Starting Your Splice Machine Database on a Hortonworks HDP-Managed
  Cluster](#StartDBHDP)
* [Starting Your Splice Machine Database on a MapR-Managed
  Cluster](#StartDBMapR)
* [Starting Your Splice Machine Database on a Standalone
  installation](#StartDbStandalone)

{% include splice_snippets/onpremonlytopic.md %}

## Starting Your Splice Machine Database on a Cloudera-Managed Cluster   {#StartDBCloudera}

Use the Cloudera Manager to start HBase:

<div class="opsStepsList" markdown="1">
1.  Navigate to the *Services-&gt;All Services* screen in *Cloudera
    Manager*, and select this action to start *HBase*:
    {: .topLevel}

    <div class="preWrapper" markdown="1">
        Actions -> Start
    {: .AppCommand xml:space="preserve"}

    </div>
{: .boldFont}

</div>
{% include splicevars.html %}
## Starting Your Splice Machine Database on a Hortonworks HDP--Managed Cluster   {#StartDBHDP}

Use the Ambari dashboard to start Splice Machine:

<div class="opsStepsList" markdown="1">
1.  Log in to the Ambari Dashboard by pointing your browser to the
    publicly visible <span
    class="HighlightedCode">&lt;hostName&gt;</span> for your master node
    that is hosting Ambari Server:
    {: .topLevel}

    <div class="preWrapper" markdown="1">
        http://<hostName>:8080/
    {: .ShellCommand xml:space="preserve"}

    </div>

2.  Start cluster services:
    {: .topLevel}

    <div class="preWrapper" markdown="1">
        Action -> Start All
    {: .AppCommand xml:space="preserve"}

    </div>
{: .boldFont}

</div>
## Starting Your Splice Machine Database on a MapR-Managed Cluster   {#StartDBMapR}

To start Splice Machine, use the MapR Command System (MCS):

<div class="opsStepsList" markdown="1">
1.  Navigate to the node that is running the `mapr-webserver` service.
2.  Log into `https://<hostIPAddr>:8443`, substituting the correct <span
    class="HighlightedCode">&lt;hostIPAddr&gt;</span> value. The login
    credentials are the ones you used when you added the `mapr` user
    during installation.
3.  Start your HBase master
4.  Start all of your Region Servers
{: .boldFont}

</div>
## Starting Your Database in the Standalone Version   {#StartDbStandalone}

Follow these steps to start your database if you're using the Standalone
version of Splice Machine:

<div class="opsStepsList" markdown="1">
1.  Change directory to your install directory:
    {: .topLevel}

    <div class="preWrapper" markdown="1">
        cd splicemachine
    {: .ShellCommand xml:space="preserve"}

    </div>

2.  Run the Splice Machine start-up script:
    {: .topLevel}

    <div class="preWrapper" markdown="1">
        $ {{splvar_location_StandaloneStartScript}}
    {: .ShellCommand xml:space="preserve"}

    </div>
{: .boldFont}

</div>
### Restarting Splice Machine

If you're running the standalone version of Splice Machine on a personal
computer that goes into sleep mode, you need to stop and then restart
Splice Machine when you wake the computer back up. For example, if
you're running Splice Machine on a laptop, and close your laptop, then
you'll need to stop and restart Splice Machine when you reopen your
laptop.

To stop and restart Splice Machine, follow these steps:

<div class="opsStepsList" markdown="1">
1.  Make sure that you have quit the <span
    class="AppCommand">splice&gt;</span> command line interpreter:
    {: .topLevel}

    <div class="preWrapper" markdown="1">
        splice> quit;
    {: .AppCommand xml:space="preserve"}

    </div>

2.  Change directory to your install directory:
    {: .topLevel}

    <div class="preWrapper" markdown="1">
        cd splicemachine
    {: .ShellCommand}

    </div>

3.  Run the Splice Machine shut-down script:
    {: .topLevel}

    <div class="preWrapper" markdown="1">
        $ {{splvar_location_StandaloneStopScript}}
    {: .ShellCommand xml:space="preserve"}

    </div>

4.  Run the Splice Machine start-up
    {: .topLevel}

    <div class="preWrapper" markdown="1">
        $ {{splvar_location_StandaloneStartScript}}
    {: .ShellCommand xml:space="preserve"}

    </div>
{: .boldFont}

</div>
</div>
</section>
