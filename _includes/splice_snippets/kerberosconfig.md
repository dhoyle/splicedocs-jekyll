<div class="opsStepsList" markdown="1">
1. Use KDC to create a new principal and generate a keytab file. For example:
   {: .topLevel}
   <div class="preWrapperWide" markdown="1">
       # kadmin.local
       addprinc -randkey jdoe@yourdomain.com
   {: .ShellCommand}
   </div>

2. Set the password for the new principal:
   {: .topLevel}
   <div class="preWrapperWide" markdown="1">
       # kadmin.local: cpw jdoe

       Enter password for principal "jdoe@yourdomain.com"
   {: .ShellCommand}
   </div>

3. Create keytab file `jdoe.keytab`:
   {: .topLevel}
   <div class="preWrapperWide" markdown="1">
       # kadmin.local: xst -k /tmp/jdoe.keytab jdoe@yourdomain.com
   {: .ShellCommand}
   </div>

4. Copy the keytab file to your region servers.
   {: .topLevel}

5. Verify that you can successfully `kinit` with the new keytab file and access the hadoop file system on the region server node:
   {: .topLevel}
   <div class="preWrapperWide" markdown="1">
       $ kinit jdoe@yourdomain.com -kt /tmp/jdoe.keytab
   {: .ShellCommand}
   </div>

6. Configure kerberos authentication against the database by setting your authentication properties as follows:
   {: .topLevel}
   <div class="preWrapperWide" markdown="1">
       <property>
           <name>splice.authentication</name>
           <value>KERBEROS</value>
       </property>
   {: .Plain}
   </div>

   On Cloudera Manager, you can go to `HBase Configuration` and search for `splice.authentication`. Change the value to `KERBEROS` for both `Client Configuration` and `Service Configuration` and restart HBase.

7. On the region server, start Splice Machine (`sqlshell.sh`), and create a matching user name in your database:
   {: .topLevel}
   <div class="preWrapperWide" markdown="1">
       splice> call SYSCS_UTIL.SYSCS_CREATE_USER( 'jdoe', 'jdoe' );
   {: .Example}
   </div>

8. Grant privileges to the new user. For example, here we grant all privileges to user `jdoe` on a table named `myTable`:
   {: .topLevel}
   <div class="preWrapperWide" markdown="1">
       splice> GRANT ALL PRIVILEGES ON Splice.myTable to jdoe;
   {: .Example}
   </div>


You can enable Kerberos mode on a Cloudera cluster using the
configuration wizard described here:  <a href="https://www.cloudera.com/documentation/enterprise/5-8-x/topics/cm_sg_intro_kerb.html" target="_blank">https://www.cloudera.com/documentation/enterprise/5-8-x/topics/cm_sg_intro_kerb.html</a>
{: .noteNote}

</div>
