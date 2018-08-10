---
title: Using Ranger with Splice Machine
summary: Ranger User Guide
toc: false
product: all
sidebar: tutorials_sidebar
permalink: tutorials_security_usingranger.html
folder: DeveloperTutorials/Security
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

# Using Apache Ranger with Splice Machine

Apache Ranger is a centralized security framework that allows you to manage fine-grained access control over Hadoop and related components. The Splice Machine Ranger plug-in extends Ranger security management to your Splice Machine database.

You can use Apache Ranger to:

* Manage policies for accessing resources by specific users and/or groups
* Audit tracking
* Analyze policies to gain deeper control of your system
* Delegate administration of certain data to other group owners

Ranger is currently only available for customers running the Enterprise version of Splice Machine on Hortonworks.
{: .noteIcon}

The remainder of this topic describes using Ranger with Splice Machine in these sections:
* [Installing Ranger for Splice Machine](#install)
* [Ranger Components](#components)
* [Establishing Splice Machine Security Policies with Ranger](#policies)
* [Reviewing Audit Logs](#audits)

## Installing Ranger for Splice Machine {#install}

You can install Apache Ranger with the Splice Machine Ambari Service on Hortonworks clusters that are running supported software versions, as listed below. The instructions for installing Ranger are included in the Splice Machine installation instructions in the `docs` subdirectory of the GitHub directory for each product/platform version:

<table>
    <col />
    <col />
    <thead>
        <tr>
            <th>Splice Machine Version</th>
            <th>Platform Version</th>
            <th>Install Instructions URL</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td rowspan="2"><strong>2.7</strong></td>
            <td>HDP 2.6.4</td>
            <td><a href="https://github.com/splicemachine/spliceengine/blob/branch-2.7/platforms/hdp2.6.4/docs/HDP-installation.md">https://github.com/splicemachine/spliceengine/blob/branch-2.7/platforms/hdp2.6.4/docs/HDP-installation.md</a></td>
        </tr>
        <tr>
            <td>HDP 2.6.3</td>
            <td><a href="https://github.com/splicemachine/spliceengine/blob/branch-2.7/platforms/hdp2.6.3/docs/HDP-installation.md">https://github.com/splicemachine/spliceengine/blob/branch-2.7/platforms/hdp2.6.3/docs/HDP-installation.md</a></td>
        </tr>
        <tr>
            <td rowspan="2"><strong>2.5</strong></td>
            <td>HDP 2.6.4</td>
            <td><a href="https://github.com/splicemachine/spliceengine/blob/branch-2.5/platforms/hdp2.6.4/docs/HDP-installation.md">https://github.com/splicemachine/spliceengine/blob/branch-2.5/platforms/hdp2.6.4/docs/HDP-installation.md</a></td>
        </tr>
        <tr>
            <td>HDP 2.6.3</td>
            <td><a href="https://github.com/splicemachine/spliceengine/blob/branch-2.5/platforms/hdp2.6.3/docs/HDP-installation.md">https://github.com/splicemachine/spliceengine/blob/branch-2.5/platforms/hdp2.6.3/docs/HDP-installation.md</a></td>
        </tr>
    </tbody>
</table>

After you configure Splice Machine to use Ranger, you no longer use `GRANT` and `REVOKE` statements for managing access privileges; you'll see an error message if you attempt to do so.
{: .noteIcon}


## Ranger Components {#components}
Ranger is structured into three main components:

<table>
    <col />
    <col />
    <thead>
        <tr>
            <th>Component</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Ranger Service</td>
            <td>Embeds a Ranger Plug-in that provides policy administration, audit, and report functions.</td>
        </tr>
        <tr>
            <td>Ranger Plug-in</td>
            <td>A lightweight Java plug-in that extracts the policy from a Ranger Portal server at regular intervals, and enforces those policies.</td>
        </tr>
        <tr>
            <td>User Group Sync</td>
            <td>Synchronizes user information from Unix, LDAP, or active Directory.</td>
        </tr>
    </tbody>
</table>


## Establishing Splice Machine Security Policies with Ranger {#policies}

The instructions in this section assume that you already have:
* Used our instructions to install the Splice Machine Ranger plug-in
* Configured basic audit and security settings.
* Added the `splicemachine` service in Ranger on one of your Region Servers

You can now establish security policies for your database in two steps:
1. Create users and groups in your Splice Machine database
2. Use the Ranger Administrative user interface (via Ambari) to create policies that apply to those users and groups. To access this user interface:
   1. Select `Ranger` in Ambari.
   2. In the main Ranger screen, select `Ranger Admin UI` under the `Quick Links` pull-down.

As indicated in our installation instructions, you __must__ create a policy that allows your database users to *execute* routines in the `SYSIBM` schema: Splice Machine depends on execution of these routines for database operations. If you've not yet done so, follow the instructions in the next section.

### Setting Up the `SYSIBM` Policy

If you've not already configured a Ranger policy that allows your Splice Machine database users to execute routines in the `SYSIBM` schema, follow these steps:

1. Access the Ranger Admin UI.
2. In the `Service Manager`, click the small, green `splicemachine` service link:
   <img src="images/RangerServiceMgr1.png">

   This displays the list of policies defined for your `splicemachine` service. The initial list of policies were created by default for the `splice` administrative user.

3. Click the `Add New Policy` button:
   <img src="images/RangerAddPolicy.png">

4. Create a `Schema` policy named `SYSIBM` that allows users to execute all (`*`) of the routines in that schema. In this screenshot, you'll notice that, for demonstration purposes, we have only applied this policy to a user named `BOB` who is already defined in our database:
   <img src="images/RangerIBMPolicy.png">

As you can see, each policy that you create in Ranger applies to specific object types (`tables, UDTs, routines, sequences`, etc.) in a specific schema. You can also create policies that apply to certain columns of a table. Each policy specifies which group or user the policy applies to, and which permissions (`All, Select, Update, Insert, Trigger, Execute`, etc.) the user(s) have for the specified entity.

### Creating Additional Policies

To add new policies for your database users, you need to:

1. Add the user in your database, if you've not already done so. You can use the Splice Machine `SYSCS_UTIL.SYSCS_CREATE_USER` system procedure to add a new user; for example:
    ````
        splice> CALL SYSCS_UTIL.SYSCS_CREATE_USER('myUserId', 'MyPswd');
        Statement executed.
    ````

2. Create a policy in the Ranger Admin UI, as shown in the [Setting Up the `SYSIBM` Policy](#sysibmpolicy) section, above. Specify the new user's name and the permission you want to grant them in the new policy. This screenshot shows an example of granting user `BOB` permission to `select` from `TABLE_1` in the `CDL` schema in a Splice machine database:
   <img src="images/RangerSelectPolicy.png">

   Note that because this user has only been granted `select` permission on the table, he will not be allowed to perform other operations on this table, such as inserting or deleting.

3. Log into Splice Machine as the user:
   ````
       sqlshell.sh -u myUserId -s MyPswd
       Running Splice Machine SQL shell
       splice>
   ````

## Reviewing Audit Logs {#audits}

You can examine the logs in Ranger:
1. In Ranger, select the `Audit` tab.
2. Enter a start date and specify `splicemachine` as the service name.
3. View the log.

You can also examine the logs in HDFS. These log files are found in a subdirectory of `/ranger/audit/splicemachine`; for example, `/ranger/audit/splicemachine/20180514`.

</div>
</section>
