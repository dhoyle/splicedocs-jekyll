---
title: SYSCS_UTIL.SYSCS_ENABLE_ENTERPRISE built-in system procedure
summary: Built-in system procedure for upgrading from the Community Edition of Splice Machine to the Enterprise Edition of Splice Machine.
keywords: enabling enterprise features, enable_enterprise, encryption, kerberos, LDAP
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_sysprocs_enableenterprise.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.SYSCS_ENABLE_ENTERPRISE   {#BuiltInSysProcs.EmptyStatementCache}

The `SYSCS_UTIL.SYSCS_ENABLE_ENTERPRISE` stored procedure unlocks access
to features that are only available in the Enterprise Edition of Splice
Machine.

Calling `SYSCS_UTIL.SYSCS_ENABLE_ENTERPRISE` with a valid license key
unlocks access to *Enterprise-only* features in Splice Machine such as
backing up and restoring your database. However, to unlock bootstrapped
authentication and encryption features such as LDAP and Kerberos, you
must also modify your `hbase-site.xml` file and restart Splice Machine.


Please see the [Upgrading to the Enterprise Edition of
Splice Machine](onprem_admin_enablingenterprise.html) topic for more information.
{: .noteNote}

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.SYSCS_ENABLE_ENTERPRISE( STRING license_key );
{: .FcnSyntax}

</div>
<div class="paramList" markdown="1">
license_key
{: .paramName}

The license key you received from Splice Machine.
{: .paramDefnFirst}

</div>
## SQL Example

<div class="preWrapper" markdown="1">
    splice> CALL SYSCS_UTIL.SYSCS_ENABLE_ENTERPRISE (<your-license-code>);
    Statement executed.
{: .Example xml:space="preserve"}

</div>
## Results

This procedure does not return a result; however, if you provide an
invalid license key, you'll see an error message displayed:

<div class="preWrapper" markdown="1">
    splice> CALL SYSCS_UTIL.SYSCS_ENABLE_ENTERPRISE (<bogus-code>);
    Error
    -------------------------------

    ERROR XSRSE: Unable to enable the enterprise Manager. Enterprise services are disabled. Contact your Splice Machine representative to enable.
{: .Example xml:space="preserve"}

</div>
## See Also

* [Upgrading to the Enterprise Edition of
  Splice Machine](onprem_admin_enablingenterprise.html) topic.

</div>
</section>
