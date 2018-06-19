---
title: Splice Machine Best Practices - Configuring Security
summary: Best practices for database security
keywords: importing
toc: false
product: all
sidebar: bestpractices_sidebar
permalink: bestpractices_onprem_security.html
folder: BestPractices
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
{% assign site.pdf_runninghead = "Best Practices" %}
# Splice Machine Best Practices for Database Security

This section contains best practice and troubleshooting information related to configurating security in our *On-Premise Database* product, in these topics:

* [Kerberos Configuration Option](#KerberosConfig)
* [Assigning Full Administrative Privileges to Users](#SuperUsers)


## Kerberos Configuration Option  {#KerberosConfig}
If you're using Kerberos, you need to add this option to your HBase Master Java Configuration Options:

<div class="preWrapper" markdown="1">
    -Dsplice.spark.hadoop.fs.hdfs.impl.disable.cache=true
{:.ShellCommand}
</div>


## Assigning Full Administrative Privileges to Users {#SuperUsers}

The default administrative user ID in Splice Machine is `splice`. If you want to configure other users to have the same privileges as the `splice` user, follow these steps:

1. Add an LDAP `admin_group` mapping for the `splice` user to both:

   * the `HBase Service Advanced Configuration Snippet (Safety Valve) for hbase-site.xml`
   * the `HBase Client Advanced Configuration Snippet (Safety Valve) for hbase-site.xml`

   This maps members of the `admin_group` to the same privileges as the `splice` user:
   <div class="preWrapperWide"><pre class="Example">
&lt;property&gt;
    &lt;name&gt;splice.authentication.ldap.mapGroupAttr&lt;/name&gt;
    &lt;value&gt;admin_group=splice&lt;/value&gt;
&lt;/property&gt;</pre>
   </div>

2. Assign the `admin_group` to a user by specifying `cn=admin_group` in the user definition. For example, we'll add a `myUser` with these attributes:

   <div class="preWrapperWide"><pre class="Example">
dn: cn=admin_group,ou=Users,dc=splicemachine,dc=colo
sn: MyUser
objectClass: inetOrgPerson
userPassword: myPassword
uid: myUser</pre>
   </div>

   You need to make sure that the name you specify for `cn` is exactly the same as the name (the value to the left of the equality symbol) in the `splice.authentication.ldap.mapGroupAttr` property value. Matching is case sensitive!
   {: .noteIcon}

   Now `myUser` belongs to the `admin_group` group, and thus gains all privileges associated with that group.

### Verifying the Configuration
We can now run a few tests to verify the the super user *myUser* has administrative privileges. Suppose:

   * `userA` and `userB` are regular LDAP users
   * `userA` owns the schema `userA` in your Splice Machine database
   * `userB` owns the schema `userB` in your Splice Machine database
   * the `userA` schema has a table named `t1`, the contents of which are shown below
   * the `userB` schema has a table named `t2`, the contents of which are shown here:

````
splice> select * from userA.t1
T1
-------------
1
2
3

3 rows selected
splice> select * from userB.t2
T2
--------------
1
2
3

3 rows selected
````
{: .Example}

Now we'll run two tests using the `splice>` command line interpreter:

#### Test 1: Verify that *myUser* can access schemas and tables belonging to both

1. Connect to Splice Machine as *myUser*:

   ````
connect 'jdbc:splice://localhost:1527/splicedb;user=myUser;password=myUserPassWord' as myuser_con;
   ````
   {: .Example}

2. Verify that you can select from both schemas:

   ````
splice select * from userA.t1
T1
-------------
1
2
3
3 rows selected
splice> select * from userB.t2
T2
--------------
1
2
3
3 rows selected
   ````
   {: .Example}

3. Make sure that while connected to `myuser_con`, you can also perform table operations such as `insert`, `delete`, `update`, and `drop table`. Also make sure you can create and drop schemas.

#### Test 2: Verify that *myUser* can grant privileges to other users.
We'll test this by granting privileges on schema `userB` to `userA` and confirming that `userA` can access the schema.

````
splice> connect 'jdbc:splice://localhost:1527/splicedb;user=userA;password=userAPassword' as userA_con;
splice> select * from userB.t2;
ERROR 42502: User 'USERA' does not have SELECT permission on column 'A2' of table 'USERB'.'T2'.
splice> set connection myuser_con;
splice> grant all privileges on schema userB to userA;
0 rows inserted/updated/deleted
splice> set connection userA_con;
splice> select * from userB.t2;
A2
-----------
1
2
3

3 rows selected
````
{: .Example}

### Assigning to Multiple Groups
You can assign the privileges to multiple groups by specifying a comma separated list in the `ldap.mapGroupAttr` property. For example, changing its definition to this:
   <div class="preWrapperWide"><pre class="Example">
&lt;property&gt;
    &lt;name&gt;splice.authentication.ldap.mapGroupAttr&lt;/name&gt;
    &lt;value&gt;admin_group=splice,cdl_group=splice&lt;/value&gt;
&lt;/property&gt;</pre>
   </div>

Means that members of both the `admin_group` and `cdl_group` groups will have the same privileges as the `splice` user.

</div>
</section>
