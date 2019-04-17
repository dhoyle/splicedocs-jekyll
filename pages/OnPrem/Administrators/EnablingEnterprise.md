---
summary: Describes how to upgrade from the Community Edition to the Enterprise Edition of Splice Machine
title: Enabling Enterprise Features in Splice Machine
keywords: Enterprise version, upgrading, license
toc: false
product: onprem
sidebar:  getstarted_sidebar
permalink: onprem_admin_enablingenterprise.html
folder: OnPrem/Administrators
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Enabling Enterprise Features in Splice Machine

There are two mechanisms for enabling enterprise features in Splice
Machine:

* To access enterprise features such as Backup and Restore, you can
  simply call the
 &nbsp;[`SYSCS_UTIL.SYSCS_ENABLE_ENTERPRISE`](sqlref_sysprocs_enableenterprise.html) built-in
  system procedure with the license key you obtain from Splice Machine,
  as described in the next section.
* To unlock Splice Machine Enterprise features that require
  configuration changes in your HBase settings, such as Kerberos and
  LDAP, you need to add one or more properties to your configuration
  file, as described in [Using Configuration Properties to Upgrade to
  the Enterprise](#Using2), below.
  
{% include splice_snippets/onpremonlytopic.md %}

## Using `SYSCS_UTIL.SYSCS_ENABLE_ENTERPRISE` to Upgrade   {#Using}

If you want to use Enterprise features, such as Backup and Restore, that
do not need system properties updated, you can call the
`SYSCS_UTIL.SYSCS_ENABLE_ENTERPRISE` system procedure to unlock those
features. You only need to do this once:

<div class="opsStepsList" markdown="1">
1.  Obtain your Splice Machine Enterprise Edition license key.
2.  Enter this command on the <span
    class="AppCommand">splice&gt;</span> command line:

    <div class="preWrapperWide" markdown="1">
        splice> CALL SYSCS_UTIL.SYSCS_ENABLE_ENTERPRISE('<yourLicenseKey>');Statement executed.
    {: .AppCommandCell}

    </div>

    If you enter an invalid license key, you'll see an error message:

    <div class="preWrapperWide" markdown="1">
        splice> CALL SYSCS_UTIL.SYSCS_ENABLE_ENTERPRISE ('<bogus-license>');
        Error
        -------------------------------
        ERROR XSRSE: Unable to enable the enterprise Manager. Enterprise services are disabled. Contact your Splice Machine representative to enable.
    {: .AppCommandCell}

    </div>

</div>
## Using Configuration Properties to Upgrade to the Enterprise   {#Using2}

If your site uses Kerberos or LDAP, you need to update to the Enterprise
version of Splice Machine by modifying your cluster's HBase
configuration, and then restart Splice Machine. Follow these steps:

<div class="opsStepsList" markdown="1">
1.  Obtain your Splice Machine Enterprise Edition license key.
2.  Edit the `hbase-site.xml` configuration file, adding this property:

    <div class="preWrapperWide" markdown="1">
        <property>   <name>splicemachine.enterprise.key</name>   <value><your-Splice-Machine-license-key></value></property>
    {: .Example}

    </div>

3.  If you're using or switching from another authentication mechanism
    to LDAP, also add the LDAP properties to your `hbase-site.xml` file,
    as described in the [Splice Machine Authentication and
    Authorization](tutorials_security_ssltls.html) topic.

4. If you're using Kerberos, add this to your HBase Master Java Configuration Options:

    <div class="preWrapperWide" markdown="1">
       -Dsplice.spark.hadoop.fs.hdfs.impl.disable.cache=true
    {: .Example}

    </div>

5.  Restart Splice Machine, by first [Starting Your
    Database](onprem_admin_startingdb.html).

</div>
</div>
</section>
