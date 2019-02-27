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
# Splice Machine Best Practices for Database Security

This section contains best practice and troubleshooting information related to configurating security in our *On-Premise Database* product, in these topics:

* [Assigning Full Administrative Privileges with LDAP](#LDAPUsers)
* [Kerberos Configuration Option](#KerberosConfig)
* [Assigning Full Administrative Priveleges with Native and Kerberos Authentication](#KerberosUsers)
{% include splice_snippets/onpremonlytopic.md %}


## Assigning Full Administrative Privileges with LDAP {#LDAPUsers}

The default administrative user ID in Splice Machine is `splice`. If you're using LDAP and want to configure other users to have the same privileges as the `splice` user, follow these steps:

1. Add an LDAP `admin_group` mapping for the `splice` user to both:

   * the `HBase Service Advanced Configuration Snippet (Safety Valve) for hbase-site.xml`
   * the `HBase Client Advanced Configuration Snippet (Safety Valve) for hbase-site.xml`

   This maps members of the `admin_group` to the same privileges as the `splice` user:

   ```
   <property>
      <name>splice.authentication.ldap.mapGroupAttr</name>
      <value>admin_group=splice</value>
   </property>
   ```
   {: .Example}

2. Assign the `admin_group` to a user by specifying `cn=admin_group` in the user definition. For example, we'll add a `myUser` with these attributes:

    ```

   <div class="preWrapperWide"><pre class="Example">
   dn: cn=admin_group,ou=Users,dc=splicemachine,dc=colo
   sn: MyUser
   objectClass: inetOrgPerson
   userPassword: myPassword
   uid: myUser
   ```
   {: .Example}

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

   ```
   <property>
      <name>splice.authentication.ldap.mapGroupAttr</name>
      <value>admin_group=splice,cdl_group=splice</value>
   </property>
   ```
   {: .Example}

Means that members of both the `admin_group` and `cdl_group` groups will have the same privileges as the `splice` user.


## Kerberos Configuration Option  {#KerberosConfig}
If you're using Kerberos, you need to add this option to your HBase Master Java Configuration Options:

```
-Dsplice.spark.hadoop.fs.hdfs.impl.disable.cache=true
```
{:.ShellCommand}

## Assigning Full Administrative Privileges with Native and Kerberos Authentication {#KerberosUsers}

The default administrative user ID in Splice Machine is `splice`. If you're using Native Authentication and Kerberos Authentication, and  you want to configure other users to have the same privileges as the `splice` user, you need to set the mapping between `splice` and the other user(s) in the `splice.authentication.ldap.mapGroupAttr` configuration parameter. Here's an example:

1. Follow the steps in the [Enabling Kerberos Authentication](tutorials_security_usingkerberos.html) topic to add a new principal; for this example, we'll assume the new principal is named `jdoe`.

2. Assign `admin` privileges to `jdoe` by setting the `splice.authentication.ldap.mapGroupAttr` property as follows:

   ```
   <property>
       <name>splice.authentication.ldap.mapGroupAttr</name>
       <value>jdoe=splice</value>
   </property>
   ```
   {: .Example}

3. Log into your database as `jdoe`:

   ```
   connect 'jdbc:splice://regionsevername:1527/splicedb;principal=jdoe@SPLICEMACHINE.COLO;keytab=jdoe_filepath.keytab' as jdoe_con;
   ```
   {: .Example}

4. check that jdoe has group user "SPLICE" and he can create and drop schemas

   ```
   splice> values user;
   1
   ---------------------------------------
   JDOE
   1 row selected
   splice> values group_user;
   1
   ---------------------------------------
   "SPLICE"

   1 row selected
   ```
   {: .Example}


</div>
</section>
