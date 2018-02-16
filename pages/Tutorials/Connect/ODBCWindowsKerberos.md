---
title: Configuring Kerberos for Windows ODBC
summary: How to configure Kerberos on Windows to use with the Splice Machine ODBC driver.
keywords: ODBC driver, install driver, odbc logging, odbc windows, odbc mac, odbc linux, odbc unix
toc: false
product: all
sidebar: tutorials_sidebar
permalink: tutorials_connect_odbcwin.html
folder: Tutorials/Connect
---
{% include splicevars.html %} <section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

# Configurating Kerberos for Windows and the Splice Machine ODBC Driver

To use Kerberos with the Splice Machine ODBC driver on Windows, you must download and install MIT Kerberos for Windows 4.0.1. Follow these steps:

1. Download and Run the MIT Kerberos Installer
2. Set up the Kerberos Configuration File
3. Set up the Kerberos Credential Cache File
4. Obtain a ticket for a Kerberos Principal

## Download and Run the MIT Kerberos Installer for Windows

You can find the installer here:
<div class="preWrapperWide" markdown="1">
    http://web.mit.edu/kerberos/dist/kfw/4.0/kfw-4.0.1-amd64.msi
{: .Plain}
</div>

## Set up the Kerberos Configuration file

There are two ways to do this, both of which are described in this section.
* Set up in the default windows directory.
* Set up in a custom location.

### Set Up the Configuration in the Default Windows Directory

Follow these steps:
1. Obtain the `krb5.conf` configuration file from your Kerberos administrator.
2. Rename that file to `krb5.ini`.
3. Copy the `krb5.ini` file to the `C:\ProgramData\MIT\Kerberos5` directory.

### Set Up the Configuration in a Custom Location

To set up the configuration in a custom location, first obtain the `/etc/krb5.conf` configuration file on the machine that is hosting the Impala server and then complete the following steps:

1. Place the `krb5.conf` file in an accessible directory and make note of the full path name.
2. Click `Start`, then right-click `Computer`, and then click `Properties`.
3. Click `Advanced system settings`.
4. In the System Properties dialog, click the `Advanced` tab, and then click `Environment Variables`.
5. In the Environment Variables dialog, under the `System variables` list, click `New`.
6. In the New System Variable dialog, in the `Variable Name` field, type `KRB5_CONFIG`.
7. In the `Variable Value` field, type the absolute path to the `krb5.conf` file from step 1.
8. Click `OK` to save the new variable.
9. Ensure the variable is listed in the System variables list.
10. Click `OK` to close the Environment Variables dialog, and then click `OK` to close the System Properties dialog.

## Set Up the Kerberos Credential Cache File

Kerberos uses a credential cache to store and manage credentials. Follow these steps to set up the credentials cache file:

1. Create the directory where you want to save the Kerberos credential cache file; for example, you can use <span class="Example">C:\temp</span>.
2. Click `Start`, then right-click `Computer`, and then click `Properties`
3. Click `Advanced system settings`.
4. In the System Properties dialog, click the `Advanced` tab, and then click `Environment Variables`
5. In the Environment Variables dialog, under the System variables list, click `New`
6. In the New System Variable dialog, in the `Variable Name` field, type `KRB5CCNAME`
7. In the `Variable Value` field, type the path to the folder you created in step 1, and then append the file name `krb5cache`. For example, <span class="Example">C:\temp\krb5cache</span>.

    `krb5cache` is a file (not a directory) that is managed by the Kerberos software which __should not be created by users__; if you receive a permission error when you first use Kerberos, ensure that `krb5cache` does not already exist as a file or a directory.
    {: .noteNote}
8. Click `OK` to save the new variable.
9. Ensure the variable appears in the System variables list.
10. Click `OK` to close the Environment Variables dialog, and then click `OK` to close the System Properties dialog.
11. To ensure that Kerberos uses the new settings, __restart your computer__.

## Obtain a Ticket for a Kerberos Principal

A principal is a user or service that can authenticate to Kerberos. To authenticate to Kerberos, a principal must obtain a ticket in one of these ways:

* Obtain a ticket using a password.
* Specify a keytab file to use.
* Use the default keytab file of your Kerberos configuration.

Each of these options is described in this section.

### Obtain a Ticket Using a Password

1. Click the `Start` button, then click `All Programs`, and then click the `Kerberos for Windows (64-bit)` or the `Kerberos for Windows (32-bit)` program group.
2. Click `MIT Kerberos Ticket Manager`.
3. In the MIT Kerberos Ticket Manager, click `Get Ticket`.
4. In the Get Ticket dialog, type your principal name and password, and then click `OK`.

If the authentication succeeds, then your ticket information appears in the MIT Kerberos Ticket Manager.

### Obtain a Ticket Using a keytab File

1. Click the `Start button > All Programs > Accessories > Command Prompt`.
2. In the Command Prompt, type a command using the following syntax:

    <div class="PreWrapper" markdown="1">
        kinit -k -t *keytab_file* principal
    </div>

    * `keytab_file` is the full path to the keytab file. For example:

        <div class="PreWrapper" markdown="1">
          C:\mykeytabs\impalaserver.keytab
        {: .Example}
        </div>

    * `principal` is the Kerberos principal to use for authentication. For example:
        <div class="PreWrapper" markdown="1">
          impala/impalaserver.example.com@EXAMPLE.COM
        {: .Example}
        </div>

    * If the cache location `KRB5CCNAME` is not set or not used, then use the `-c` option of the `kinit` command to specify the credential cache. The `-c` argment must appear last on the command line. For example:

        <div class="PreWrapperWide" markdown="1">
          kinit -k -t C:\mykeytabs\impalaserver.keytab impala/fully.qualified.domain.name@your-realm.com -c C:\ProgramData\MIT\krbcache
        {: .Example}
        </div>

### Obtain a Ticket Using the Default keytab File

1. Click the Start button > All Programs > Accessories > Command Prompt
2. In the Command Prompt, type a command using the following syntax:

    <div class="PreWrapper" markdown="1">
        kinit -k principal
    </div>

    * `principal` is the Kerberos principal to use for authentication. For example:
        <div class="PreWrapper" markdown="1">
          impala/impalaserver.example.com@EXAMPLE.COM
        {: .Example}
        </div>

    * If the cache location `KRB5CCNAME` is not set or not used, then use the `-c` option of the `kinit` command to specify the credential cache. The `-c` argment must appear last on the command line. For example:
        <div class="PreWrapperWide" markdown="1">
          kinit -k impala/fully.qualified.domain.name@your-realm.com -c C:\ProgramData\MIT\krbcache
        {: .Example}
        </div>

For more information about configuring Kerberos, including a default keytab file, consult the MIT Kerberos documentation
{: .noteNote}
