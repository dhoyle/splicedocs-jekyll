---
title: Accessing Splice Machine from Windows on a Kerberized Cluster
summary: Accessing Splice Machine from Windows on a Kerberized Cluster
keywords: kerberos
toc: false
product: all
sidebar: home_sidebar
permalink: tutorials_security_kerberoswin.html
folder: DeveloperTutorials/Security
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

# Accessing Splice Machine from Windows on a Kerberized Cluster {#UseOnWindows}
This section shows you how to use either of these Kerberos implementations to access Splice Machine from a computer running *Microsoft Windows:*

* [Configuring Microsoft Active Directory Kerberos](#ActiveDirectory)
* [Configuring MIT Kerberos](#MIT)

## Configuring Microsoft Active Directory Kerberos {#ActiveDirectory}
To use Microsoft Active Directory Kerberos with Splice Machine, you need to do the following:

<div class="opsStepsList" markdown="1">
1. Configure our ODBC driver to use Microsoft Active Directory Kerberos; you typically do this during [driver installation](tutorials_connect_odbcinstall.html).
   {: .topLevel}

2. Verify that MIT Kerberos __is not installed__ on the client Windows computer.
   {: .topLevel}

3. Make sure that the MIT Kerberos Hadoop realm has been configured to trust the Active Directory realm so that users in the Active Directory realm can access services in the MIT Kerberos Hadoop realm.
   {: .topLevel}
</div>


## Configuring MIT Kerberos {#MIT}

To use MIT Kerberos with the Splice Machine on Windows, you must download and install *MIT Kerberos for Windows 4.0.1*. Follow these steps:

1. [Download and Run the MIT Kerberos Installer](#install)
2. [Set up the Kerberos Configuration File](#setup)
3. [Set up the Kerberos Credential Cache File](#cache)
4. [Obtain a ticket for a Kerberos Principal](#ticket)

### Step 1: Download and Run the MIT Kerberos Installer for Windows {#install}

You can find the installer here:
&nbsp;&nbsp;&nbsp;<a href="http://web.mit.edu/kerberos/dist/kfw/4.0/kfw-4.0.1-amd64.msi" target="_blank">http://web.mit.edu/kerberos/dist/kfw/4.0/kfw-4.0.1-amd64.msi</a>.

MIT's documentation page for Kerberos is here: [http://web.mit.edu/kerberos/](http://web.mit.edu/kerberos/).

### Step 2: Set up the Kerberos Configuration file {#setup}

There are two ways to do this, both of which are described in this section.
* [Set up in the default windows directory.](#DefaultDir)
* [Set up in a custom location.](#CustomLoc)

#### Set Up the Configuration in the Default Windows Directory {#DefaultDir}

Follow these steps to set up your configuration file in the default directory:
<div class="opsStepsList" markdown="1">
1. Obtain the <span class="varName">krb5.conf</span> configuration file from your Kerberos administrator.
   {: .topLevel}

2. Rename that file to <span class="varName">krb5.ini</span>.
   {: .topLevel}

3. Copy the <span class="varName">krb5.ini</span> file to the <span class="varName">C:\ProgramData\MIT\Kerberos5</span> directory.
   {: .topLevel}

</div>

#### Set Up the Configuration in a Custom Location {#CustomLoc}

Follow these steps to set up the configuration in a custom location:
<div class="opsStepsList" markdown="1">
1. Obtain the <span class="varName">/etc/krb5.conf</span> configuration file from your Kerberos administrator.
   {: .topLevel}

2. Place the <span class="varName">krb5.conf</span> file in an accessible directory and make note of the full path name.
   {: .topLevel}

3. Click <span class="varName">Start</span>, then right-click <span class="varName">Computer</span>, and then click <span class="varName">Properties</span>.
   {: .topLevel}

4. Click <span class="varName">Advanced system settings</span>.
   {: .topLevel}

5. In the System Properties dialog, click the <span class="varName">Advanced</span> tab, and then click <span class="varName">Environment Variables</span>.
   {: .topLevel}

6. In the Environment Variables dialog, under the <span class="varName">System variables</span> list, click <span class="varName">New</span>.
   {: .topLevel}

7. In the New System Variable dialog, in the <span class="varName">Variable Name</span> field, type <span class="varName">KRB5_CONFIG</span>.
   {: .topLevel}

8. In the <span class="varName">Variable Value</span> field, type the absolute path to the <span class="varName">krb5.conf</span> file from step 1.
   {: .topLevel}

9. Click <span class="varName">OK</span> to save the new variable.
   {: .topLevel}

10. Ensure the variable is listed in the System variables list.
    {: .topLevel}

11. Click <span class="varName">OK</span> to close the Environment Variables dialog, and then click <span class="varName">OK</span> to close the System Properties dialog.
    {: .topLevel}

</div>

### Step 3: Set Up the Kerberos Credential Cache File {#cache}

Kerberos uses a credential cache to store and manage credentials. Follow these steps to set up the credentials cache file:

<div class="opsStepsList" markdown="1">
1. Create the directory where you want to save the Kerberos credential cache file; for example, you can use <span class="Example">C:\temp</span>.
   {: .topLevel}

2. Click <span class="varName">Start</span>, then right-click <span class="varName">Computer</span>, and then click <span class="varName">Properties</span>
   {: .topLevel}

3. Click <span class="varName">Advanced system settings</span>.
   {: .topLevel}

4. In the System Properties dialog, click the <span class="varName">Advanced</span> tab, and then click <span class="varName">Environment Variables</span>
   {: .topLevel}

5. In the Environment Variables dialog, under the System variables list, click <span class="varName">New</span>
   {: .topLevel}

6. In the New System Variable dialog, in the <span class="varName">Variable Name</span> field, type <span class="varName">KRB5CCNAME</span>
7. In the <span class="varName">Variable Value</span> field, type the path to the folder you created in step 1, and then append the file name <span class="varName">krb5cache</span>. For example, <span class="Example">C:\temp\krb5cache</span>.
   {: .topLevel}

   <span class="varName">krb5cache</span> is a file (not a directory) that is managed by the Kerberos software which __should not be created by users__; if you receive a permission error when you first use Kerberos, ensure that <span class="varName">krb5cache</span> does not already exist as a file or directory.
   {: .noteNote}

8. Click <span class="varName">OK</span> to save the new variable.
   {: .topLevel}

9. Ensure the variable appears in the System variables list.
   {: .topLevel}

10. Click <span class="varName">OK</span> to close the Environment Variables dialog, and then click <span class="varName">OK</span> to close the System Properties dialog.
    {: .topLevel}

11. To ensure that Kerberos uses the new settings, __restart your computer__.
    {: .topLevel}

</div>

### Step 4: Obtain a Ticket for a Kerberos Principal {#ticket}

A principal is a user or service that can authenticate to Kerberos. To authenticate to Kerberos, a principal must obtain a ticket in one of these ways:

* [Obtain a ticket using a password.](#ticketpassword)
* [Obtain a ticket using the default keytab file.](#ticketdefault)
* [Obtain a ticket using a custom keytab file.](#ticketcustom)

Each of these options is described in this section.

#### Obtain a Ticket Using a Password

<div class="opsStepsList" markdown="1">
1. Click the <span class="varName">Start</span> button, then click <span class="varName">All Programs</span>, and then click the <span class="varName">Kerberos for Windows (64-bit)</span> or the <span class="varName">Kerberos for Windows (32-bit)</span> program group.
   {: .topLevel}

2. Click <span class="varName">MIT Kerberos Ticket Manager</span>.
   {: .topLevel}

3. In the MIT Kerberos Ticket Manager, click <span class="varName">Get Ticket</span>.
   {: .topLevel}

4. In the Get Ticket dialog, type your principal name and password, and then click <span class="varName">OK</span>.
   {: .topLevel}

   If the authentication succeeds, then your ticket information appears in the MIT Kerberos Ticket Manager.
   {: .topLevel}
</div>

#### Obtain a Ticket Using the Default Keytab File

<div class="opsStepsList" markdown="1">
1. Click the <span class="varName">Start</span> button > <span class="varName">All Programs</span> > <span class="varName">Accessories</span> > <span class="varName">Command Prompt</span>
   {: .topLevel}

2. In the Command Prompt prompt, type a command using the following syntax:
   {: .topLevel}

   <div class="PreWrapper" markdown="1">
       kinit -k principal
   </div>

   * <span class="varName">principal</span> is the Kerberos principal to use for authentication. For example:
       <div class="PreWrapper" markdown="1">
         my/myserver.example.com@EXAMPLE.COM
       {: .Example}
       </div>

   * If the cache location <span class="varName">KRB5CCNAME</span> is not set or not used, then use the <span class="varName">-c</span> option of the <span class="varName">kinit</span> command to specify the credential cache. The <span class="varName">-c</span> argment must appear last on the command line. For example:
       <div class="PreWrapper" markdown="1">
          kinit -k mydir/fully.qualified.domain.name@your-realm.com -c C:\ProgramData\MIT\krbcache
       {: .Example}
       </div>
</div>

#### Obtain a Ticket Using a Custom Keytab File

<div class="opsStepsList" markdown="1">
1. Click the <span class="varName">Start button > All Programs > Accessories > Command Prompt</span>.
2. In the Command Prompt, type a command using the following syntax:
   {: .topLevel}

    <div class="PreWrapper" markdown="1">
        kinit -k -t *keytab_file* principal
    </div>

    * <span class="varName">keytab_file</span> is the full path to the keytab file. For example:
       <div class="PreWrapper" markdown="1">
          C:\mykeytabs\myserver.keytab
       {: .Example}
       </div>

    * <span class="varName">principal</span> is the Kerberos principal to use for authentication. For example:
       <div class="PreWrapper" markdown="1">
          mydir/myserver.example.com@EXAMPLE.COM
       {: .Example}
       </div>

    * If the cache location <span class="varName">KRB5CCNAME</span> is not set or not used, then use the <span class="varName">-c</span> option of the <span class="varName">kinit</span> command to specify the credential cache. The <span class="varName">-c</span> argment must appear last on the command line. For example:

       <div class="PreWrapper" markdown="1">
          kinit -k -t C:\mykeytabs\myserver.keytab mydir/fully.qualified.domain.name@your-realm.com -c C:\ProgramData\MIT\krbcache
       {: .Example}
       </div>

</div>

For more information about configuring Kerberos, consult the MIT Kerberos documentation: [http://web.mit.edu/kerberos/](http://web.mit.edu/kerberos/).
{: .noteNote}

</div>
</section>
