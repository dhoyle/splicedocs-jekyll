---
title: Using the Splice Machine ODBC Driver
summary: How to install and configure the Splice Machine ODBC driver.
keywords: ODBC driver, install driver, odbc logging, odbc windows, odbc mac, odbc linux, odbc unix
toc: false
product: all
sidebar: home_sidebar
permalink: tutorials_connect_odbcinstall.html
folder: Connecting/ODBCConnect
---
{% include splicevars.html %} <section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Using the Splice Machine ODBC Driver

This topic describes how to configure and use the Splice Machine
ODBC driver, which you can use to connect with other databases and
business tools that need to access your database.

You **must** use the *Splice Machine* ODBC driver; other drivers will not work correctly.
{: .noteIcon}

This topic describes how to install and configure the Splice Machine
ODBC driver for these operating systems:

* [Installing the Splice Machine ODBC Driver on Windows](#Installi)
* [Installing the Splice Machine ODBC Driver on Linux](#Installi2)
* [Installing the Splice Machine ODBC Driver on MacOS](#Installi3)

This topic also includes an [example that illustrates using our
ODBC driver](#Using) with the C language.

## Installing and Configuring the Driver on Windows   {#Installi}

You can install the Windows version of the Splice Machine ODBC driver
using the provided Windows installer (`.msi` file); we provide both
64-bit and 32-bit versions of the driver. Follow these steps to install
the driver:

<div class="opsStepsList" markdown="1">
1.  Download the installer:
    {: .topLevel}

    You can download the driver installer from [our ODBC download][1]{:
    target="_blank"} site: 
    {: .indentLevel1}

    The file you download will have a name similar to these:
    {: .indentLevel1}

    * <span class="PlainFont">`splice_odbc_setup_64bit_1.0.28.0.msi`
    * <span class="PlainFont">`splice_odbc_setup_32bit_1.0.28.0.msi`

2.  Start the installer
    {: .topLevel}

    Double-click the installers `.msi` file to start installation.
    You'll see the Welcome screen:
    {: .indentLevel1}

    ![Image of the welcome screen for the Splice Machine ODBC driver
    installer](images/ODBCInstall.Welcome.png){: .nestedTightSpacing}

    Click the <span class="AppCommand">Next</span> button to proceed.
    {: .indentLevel1}

3.  Accept the license agreement.
    {: .topLevel}

4.  Select the destination folder for the driver
    {: .topLevel}

    The default destination is generally fine, but you can select a
    different location if you like:
    {: .indentLevel1}

    ![Splice Machine ODBC Driver destination
    folder](images/ODBCInstall.Dest.png){: .nestedTightSpacing}

    Click the <span class="AppCommand">Next</span> button to continue to
    the Ready to Install screen.
    {: .indentLevel1}

5.  Click install
    {: .topLevel}

    Click the <span class="AppCommand">Install</span> button on the
    Ready to install screen. Installation can take a minute or two to
    complete.
    {: .indentLevel1}

    The installer may notify you that you either need to stop certain
    software before continuing, or that you can continue and then reboot
    your computer after the installation completes.
    {: .noteNote}

6.  Finish the installation
    {: .topLevel}

    Click the Finish button, and you're ready to use the Splice Machine
    ODBC driver.
    {: .indentLevel1}

7.  Start the Windows ODBC Data Source Administrator tool
    {: .topLevel}

    You need to add our ODBC driver to the set of Windows ODBC data
    sources, using the Windows ODBC Data Source Administrator tool; You
    can read about this tool here:
    [https://msdn.microsoft.com/en-us/library/ms712362(v=vs.85).aspx][2]{:
    target="_blank"}.
    {: .indentLevel1}

    You can find and start the Windows ODBC Administrator tool using a
    Windows search for ODBC on your computer; here's what it looks like
    on Windows 7:
    {: .indentLevel1}

    ![Image of using Windows search to find the ODBC Administrator
    tool](images/ODBCAdmin.png){: .nestedTightSpacing}

8.  Add the Splice Machine driver as a data source
    {: .topLevel}

    Click the <span class="AppCommand">Add button</span> the User
    DSN tab of the ODBC Data Source Administrator screen, and then
    select the Splice Machine driver you just installed:
    {: .indentLevel1}

    ![Adding the Splice Machine driver as an ODBC data source on
    Windows](images/ODBCAddSource.png){: .nestedTightSpacing}

9.  Configure your new data source:
    {: .topLevel}

    When you click the <span class="AppCommand">Finish</span> button in
    the *Create New Data Source* screen, the ODBC Administrator tool
    displays the data source configuration screen.

    #### Configuring the Data Source and Login

    Set the fields in the *Data Source* and *Splice Machine Login* sections similarly to the settings shown here:
    {: .indentLevel1}

    ![Configuring the Splice Machine ODBC data source on
    Windows](images/ODBCConfigure.png){: .nestedTightSpacing}

    You can use either *Microsoft Active Directory Kerberos* or *MIT Kerberos* for your ODBC connections; see our [Accessing Splice Machine on a Kerberized Cluster](tutorials_security_kerberoswin.html) topic for instructions.

    For <span class="AppCommand">Server</span>: on a cluster, specify
    the IP address of an HBase RegionServer. If you're running the
    standalone version of Splice Machine, specify `localhost`.
    {: .noteNote}

    #### Configuring Advanced Options
    Click the <span class="AppCommand">Advanced options</span> button to set advanced properties:

    * Use the *Driver Properties* tab to configure logging options that apply to all connections using this driver:
      ![Advanced Driver Properties](images/ODBCAdvConfig2.png){: .nestedTightSpacing}

      Logging driver activity can be handy for debugging connection issues; however, it adds
      overhead and will have a significant impact on performance.

    * Use the *Connection Properties* tab to configure SSL and network options.
      ![Advanced Connection Properties](images/ODBCAdvConfig1.png){: .nestedTightSpacing}

    ##### Including the Catalog Name

    The _Include catalog name in table metadata_ option is available to address an issue with certain applications that expect a catalog entry in the table metadata. When this option is selected, our driver returns the catalog name in the table metadata but sets the `catalog usage` attribute to `0` to tell applications that they shouldn’t use the catalog name in a Splice Machine database query. The Splice Machine database considers it an error when a query uses a fully qualified table name containing the catalog (e.g. `splicedb.SPLICE.TABLENAME`), so you can use this driver feature to also strip any `splicedb` catalog names out of the query.

    If you see an application that warns of illegal or missing catalog names, or shows an empty catalog, try selecting this option.


    ##### Configuring SSL
    To configure SSL for your ODBC connections, click the drop-down arrow in the *Use SSL:* setting and change the setting from `none` to one of the following settings:
    {: .indentLevel1}

    <table>
       <col />
       <col />
       <thead>
            <tr>
                <th>SSL Setting</th>
                <th>Description</th>
            </tr>
       </thead>
       <tbody>
           <tr>
              <td class="CodeFont">basic</td>
              <td class="PlainFont">The communications channel is encrypted, but no attempt is made to verify client or host certificates.</td>
           </tr>
           <tr>
              <td class="CodeFont">peerAuthentication</td>
              <td class="PlainFont">
                  <p>You must specify the location of both the client certificate file and the client private key in their respective fields.</p>
                  <p>The <em>Certificate file</em> field defaults to the <code>.pem</code> extension and must contain the path to a PEM-formatted file. That file must contain either a) the client certificate alone, or b) both the client certificate and the private key.</p>
                  <p>The <em>Private key file</em> field defaults to the <code>.key</code> extension and must contain the path to a PEM-formatted file. That file must contain either a) the private key alone, or b) both the client certificate and the private key.</p>
                      <p class="notePlain">You can find more information about PEM files by <a href="https://www.google.com/search?q=pem+formatted+file&rlz=1C1HIJB_enUS701US702&oq=pem+formatted+file&aqs=chrome..69i57j0l5.3839j0j4&sourceid=chrome&ie=UTF-8" target="_blank">searching the web for <em>pem formatted file</em></a>.</p>
                  <p>Select the <em>Always trust server certificate</em> checkbox to specify that the driver can skip verification of the host certificate by the client; if you do not select this option, then the client attempts to verify the host certificate chain.</p>
                      <p class="noteNote">You should select the <em>Always trust server certificate</em> option if you are using a self-signed certificate.</p>
                  <p>Here's an example of configuring Peer Authentication and trusting the certificate:</p>
                  <img class="nestedTightSpacing" src="images/ODBCConfigureTLS.png" alt="Configurating SSL for the Splice Machine data source on Windows" />
              </td>
           </tr>
       </tbody>
    </table>

  If you have Splice Machine running, you can click the *Test...* button at the bottom of the Configuration dialog to verify that all is well.
  {: .indentLevel1}
{: .boldFont}

</div>
## Installing the Driver on Linux   {#Installi2}

Follow these steps to install the Splice Machine ODBC driver on a Linux
computer:

<div class="opsStepsList" markdown="1">
1.  Make sure you have the software our driver requires installed:
    {: .topLevel}

<ul class="nested">
    <li>
        <p>You must have version <strong>4.82</strong> or later of the GNU Compiler Collection (<em>GCC</em>) installed. You can use the following command to verify your version:</p>
        <div class="preWrapper"><pre class="ShellCommand">
gcc --version</pre>
        </div>
    </li>
    <li>
        <p>You must have version <strong>2.2.12</strong> or later of the <em>unixODBC</em> driver manager installed. You can use the following command to verify your version:</p>
        <div class="preWrapper"><pre class="ShellCommand">
odbcinst -j</pre>
        </div>
    </li>
</ul>

<p class="indentLevel2">Some Linux distributions include <em>unixODBC</em>, while others do not. Our driver will not work without it. For more information about unixODBC, see: <a href="http://www.unixodbc.org" target="_blank">http://www.unixodbc.org</a>.</p>

2.  Download the installer:
    {: .topLevel}

    You can download the driver installer from our ODBC download
    site: [{{splvar_odbc_dllink}}][1]{: target="_blank"}
    {: .indentLevel1}

    Download the installer to the Linux computer on which you want to
    install the driver. The file will have a name similar to this:
    {: .indentLevel1}

    <div class="preWrapper" markdown="1">
        splice_odbc_linux64-<version>.tar.gz
    {: .Plain}

    </div>

3.  Unzip the installation package
    {: .topLevel}

    Use the following command to unpack the tarball you installed,
    substituting in the actual version number from the download:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        tar xzf splice_odbc_linux64-<version>.tar.gz
    {: .ShellCommand}

    </div>

    This creates a directory named `splice_odbc_64`.
    {: .indentLevel1}

4.  Install the driver:
    {: .topLevel}

    Navigate to the directory that was created when you unzipped the
    tarball, and run the install script:
    {: .indentLevel1}

    If you run the script as root, the default installation directory is
    `/usr/local/splice:`
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        sudo ./install.sh
    {: .ShellCommand}

    </div>

    If you run the script as a different user, the driver is installed
    to `~/splice`.
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        ./install.sh
    {: .ShellCommand}

    </div>

    The script creates a `splice` directory in the install location; you'll be prompted for that location, which defaults to `/usr/local`.
    {: .indentLevel1}

    You'll also be prompted to enter the IP address of the Splice Machine server, which defaults to `127.0.0.1`.

    The install directory, e.g. `/usr/local/splice`, will contain two subdirectories:
    {: .indentLevel1}

    <table summary="ODBC Driver SubDirectories">
        <col />
        <col />
        <thead>
            <tr>
                <th>Directory</th>
                <th>Contents</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td><code>lib64</code></td>
                <td>The driver binary.</td>
            </tr>
            <tr>
                <td><code>errormessages</code></td>
                <td>The XML error message source for any error messages issued by the driver.</td>
            </tr>
        </tbody>
    </table>

5.  Configure the driver:
    {: .topLevel}

    If you ran the installation script as root, the `odbc.ini`, `odbcinst.ini`, and `splice.odbcdriver.ini` configuration files were copied into the `/etc` folder, and any previous copies were renamed, e.g. `odbc.ini.1`.
    {: .indentLevel1}

    If you did not run the installation script as root, then hidden versions of the same files are located in your `$HOME` directory: `.odbc.ini`, `.odbcinst.ini`, and `.splice.odbcdriver.ini`.
    {: .indentLevel1}

    <table>
        <col />
        <col />
        <thead>
            <tr>
                <th>File</th>
                <th>Description</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td><code>odbc.ini</code></td>
                <td>
                    <p>Specifies the ODBC data sources (DSNs).</p>
                </td>
            </tr>
            <tr>
                <td><code>odbcinst.ini</code></td>
                <td>Specifies the ODBC drivers.</td>
            </tr>
            <tr>
                <td><code>splice.odbcdriver.ini</code></td>
                <td>Configuration information specific to the Splice Machine ODBC driver.</td>
            </tr>
        </tbody>
    </table>

    The default version of the `odbc.ini` file looks like this:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        [ODBC Data Sources]
        SpliceODBC64        = SpliceODBCDriver

        [SpliceODBC64]
        Description     = Splice Machine ODBC 64-bit
        Driver          = /usr/local/splice/lib64/libsplice_odbc.so
        UID             = yourUserID
        PWD             = yourPassword
        URL             = 127.0.0.1
        PORT            = 1527
        SSL             = peerAuthentication
        SSL_CERT        = /home/splice/client.pem
        SSL_PKEY        = /home/splice/client.key
        SSL_TRUST       = TRUE
    {: .Plain}
    </div>

    If you specified a different installation directory, you need to update the `Driver` location setting in your `odbc.ini` file. This is not typically required; however, if you do make this change, you should copy your modified file to the `/etc` directory.
    {: indentLevel1}

    <div class="preWrapperWide" markdown="1">
        cp odbc.ini /etc/
    {: .ShellCommand}
    </div>

    If you are connecting to a Kerberos-enabled cluster using ODBC, you **must add this parameter**:
    <div class="preWrapperWide" markdown="1">
        USE_KERBEROS    = 1
    {: .Plain}
    </div>

    For more information about connecting to a Kerberos-enabled cluster, see [Connecting to Splice Machine Through HAProxy](developers_fundamentals_haproxy.html).


6.  Configure Driver Logging, if desired
    {: .topLevel}

    You can edit the `splice.odbcdriver.ini` file to configure driver logging, which is disabled by default:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        [Driver]
        DriverManagerEncoding=UTF-16
        DriverLocale=en-US
        ErrorMessagesPath=/usr/local/splice/errormessages/
        LogLevel=0
        LogNamespace=
        LogPath=
        ODBCInstLib=/usr/lib64/libodbcinst.so
    {: .Plain}
    </div>

    To configure logging, modify the `LogLevel` and `LogPath` values:
    {: .indentLevel1}

    <table>
        <col />
        <col />
        <tbody>
            <tr>
                <td><code>LogLevel</code></td>
                <td>
                    <p>You can specify one of the following values:</p>
                    <div class="preWrapperWide"><pre class="Plain">0 = OFF<br />1 = LOG_FATAL<br />2 = LOG_ERROR<br />3 = LOG_WARNING<br />4 = LOG_INFO<br />5 = LOG_DEBUG<br />6 = LOG_TRACE</pre>
                    </div>
                    <p>The larger the LogLevel value, the more verbose the logging.</p>
                    <p class="noteIcon">Logging does impact driver performance.</p>
                </td>
            </tr>
            <tr>
                <td><code>LogPath</code></td>
                <td>
                    <p>The path to the directory in which you want the logging files stored. Two log files are written in this directory:</p>
                    <table class="noBorder">
                       <col />
                       <col />
                       <tbody>
                          <tr>
                             <td><code>splice_driver.log</code></td>
                             <td>Contains driver interactions with the application and the driver manager.</td>
                          </tr>
                          <tr>
                             <td><code>splice_derby.log</code></td>
                             <td>Contains information about the drivers interaction with the Splice Machine cluster.</td>
                          </tr>
                       </tbody>
                    </table>
                </td>
            </tr>
        </tbody>
    </table>

    After configuring logging, copy the file to `/etc`:
    {: .indentLevel1}


7.  Verify your installation
    {: .topLevel}

    You can test your installation by using the following command to run
    `isql`:
    {: .indentLevel1}

    <div class="preWrapper" markdown="1">
        isql SpliceODBC64 yourUserId yourPassword
    {: .ShellCommand}

    </div>
{: .boldFont}

</div>


## Installing the Driver on MacOS   {#Installi3}

Follow these steps to install the Splice Machine ODBC driver on a MacOS
computer:

<div class="opsStepsList" markdown="1">
1.  Make sure you have iODBC installed.
    {: .topLevel}

    You must have an ODBC administration driver to manage ODBC data sources on your Mac. We recommend installing the iODBC driver for the Mac, which you'll find on the iODBC site: <a href="http://www.iodbc.org/" target='_blank'>www.iodbc.org/</a>
    {: .indentLevel1}

2.  Download the installer:
    {: .topLevel}

    You can download the driver installer from our ODBC download
    site: [{{splvar_odbc_dllink}}][1]{: target="_blank"}
    {: .indentLevel1}

    Download the installer to the MacOS computer on which you want to
    install the driver. The file will have a name similar to this:
    {: .indentLevel1}

    <div class="preWrapper" markdown="1">
        splice_odbc_64_macosx64-2.5-51.0.tar.gz
    {: .Plain}

    </div>

3.  Unzip the installation package
    {: .topLevel}

    Use the following command to unpack the tarball you installed,
    substituting in the actual version number from the download:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        tar -xzf splice_odbc_macosx64-<version>.tar.gz
    {: .ShellCommand}

    </div>

    This creates a directory named `splice_odbc_macosx64`.
    {: .indentLevel1}

4.  Install the driver:
    {: .topLevel}

    Navigate to the directory that was created when you unzipped the
    tarball, and run the install script:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        ./install.sh
    {: .ShellCommand}

    </div>

    Follow the installer prompts. In most cases, you can simply accept the default values.
    {: .indentLevel1}

    The installer will create several files in the install directory, including these three files, which contain the configuration info that can be modified as required:
    {: .indentLevel1}

    <table>
        <col />
        <col />
        <thead>
            <tr>
                <th>File</th>
                <th>Description</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td><code>odbc.ini</code></td>
                <td>
                    <p>Specifies the ODBC data sources (DSNs).</p>
                </td>
            </tr>
            <tr>
                <td><code>odbcinst.ini</code></td>
                <td>Specifies the ODBC drivers.</td>
            </tr>
            <tr>
                <td><code>splice.odbcdriver.ini</code></td>
                <td>Configuration information specific to the Splice Machine ODBC driver.</td>
            </tr>
        </tbody>
    </table>

    If you have not previously installed our ODBC driver, the installer will also copy the files into $HOME/Library/ODBC for use with iODBC.
    {: .indentLevel1}

5.  Configure the driver:
    {: .topLevel}

    The installed driver is configured with settings that you specified when responding to the installer prompts. You can change values as follows:
    {: .indentLevel1}

    1.  Edit the `odbc.ini` file to match your
        configuration.
        {: .topLevel}

        You'll find the `odbc.ini` file in your
        $HOME/Library/ODBC directory; we also create a link to this file in
        $HOME/.odbc.ini. You can edit `odbc.ini` (or `.odbc.ini`) from either location.

        > The <span class="AppCommand">URL</span> field in the
        > `odbc.ini` file is actually the IP address of the Splice
        > Machine server.
        > {: .noteNote}

        The default version of the `odbc.ini` file looks like this:

        <div class="preWrapperWide" markdown="1">
            [ODBC Data Sources]
            SpliceODBC64        = SpliceODBCDriver

            [SpliceODBC64]
            Description     = Splice Machine ODBC 64-bit
            Driver          = /usr/local/splice/lib64/libsplice_odbc.so
            UID             = yourUserId
            PWD             = yourPassword
            URL             = 0.0.0.0
            PORT            = 1527
        {: .Plain}

        </div>

        If you are connecting to a Kerberos-enabled cluster using ODBC, you **must add this parameter**:
        <div class="preWrapperWide" markdown="1">
            USE_KERBEROS    = 1
        {: .Plain}
        </div>

        For more information about connecting to a Kerberos-enabled cluster, see [Connecting to Splice Machine Through HAProxy](developers_fundamentals_haproxy.html).

    2.  Edit (if desired) and copy the `splice.odbcdriver.ini` file:
        {: .topLevel}

        The `splice.odbcdriver.ini` file contains information specific
        to the driver. You can edit this file to configure driver
        logging, which is disabled by default:

        <div class="preWrapperWide" markdown="1">
            [Driver]
            DriverManagerEncoding=UTF-16
            DriverLocale=en-US
            ErrorMessagesPath=/usr/local/splice/errormessages/
            LogLevel=0
            LogNamespace=
            LogPath=
            ODBCInstLib=/usr/lib64/libodbcinst.so
        {: .Plain}

        </div>

        A copy of the Splice Machine ODBC configuration file, `splice.odbcdriver.ini,`
        which contains the default values, was copy to `/Library/ODBC/SpliceMachine` during
        installation. You will need root access to modify this file:
        {: .indentLevel1}

        <div class="preWrapperWide" markdown="1">
            sudo vi /Library/ODBC/SpliceMachine/splice.odbcdriver.ini
        {: .ShellCommand}

        </div>

        To configure logging, modify the `LogLevel` and `LogPath`
        values:

        <table>
            <col />
            <col />
            <tbody>
                <tr>
                    <td><code>LogLevel</code></td>
                    <td>
                        <p>You can specify one of the following values:</p>
                        <div class="preWrapperWide"><pre class="Plain">0 = OFF<br />1 = LOG_FATAL<br />2 = LOG_ERROR<br />3 = LOG_WARNING<br />4 = LOG_INFO<br />5 = LOG_DEBUG<br />6 = LOG_TRACE</pre>
                        </div>
                        <p>The larger the LogLevel value, the more verbose the logging.</p>
                        <p class="noteIcon">Logging does impact driver performance.</p>
                    </td>
                </tr>
                <tr>
                    <td><code>LogPath</code></td>
                    <td>
                        <p>The path to the directory in which you want the logging files stored. Two log files are written in this directory:</p>
                        <table class="noBorder">
                           <col />
                           <col />
                           <tbody>
                              <tr>
                                  <td class="CodeFont">splice_driver.log</td>
                                  <td>contains driver interactions with the application and the driver manager</td>
                              </tr>
                              <tr>
                                  <td class="CodeFont">splice_derby.log</td>
                                  <td>contains information about the drivers interaction with the Splice Machine cluster</td>
                              </tr>
                           </tbody>
                        </table>
                    </td>
                </tr>
            </tbody>
        </table>
    {: .LowerAlpha}

6.  Verify your installation
    {: .topLevel}

    You can test your installation by launching the 64-bit version of the
    iODBC Data Source Administrator for both configuring and testing your DSNs. Note
    that you can also perform your `odbc.ini` modifications with this tool instead of manually editing the file.
{: .boldFont}

</div>
## Using the ODBC Driver with C   {#Using}

This section contains a simple example of using the Splice Machine
ODBC driver with the C programming language. This program simply
displays information about the installed driver. You can compile and run
it by following these steps:

<div class="opsStepsList" markdown="1">
1.  Copy the code
    {: .topLevel}

    You can copy and paste the code below:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        #include <stdio.h>
        #include <sql.h>
        #include <sqlext.h>

        main() {
           SQLHENV env;
           char driver[256];
           char attr[256];
           SQLSMALLINT driver_ret;
           SQLSMALLINT attr_ret;
           SQLUSMALLINT direction;
           SQLRETURN ret;

           SQLAllocHandle(SQL_HANDLE_ENV, SQL_NULL_HANDLE, &env);
           SQLSetEnvAttr(env, SQL_ATTR_ODBC_VERSION, (void *) SQL_OV_ODBC3, 0);

           direction = SQL_FETCH_FIRST;
           while(SQL_SUCCEEDED(ret = SQLDrivers(env, direction,
                 driver, sizeof(driver), &driver_ret,
                 attr, sizeof(attr), &attr_ret))) {
                 direction = SQL_FETCH_NEXT;
              printf("%s - %s\n", driver, attr);
              if (ret == SQL_SUCCESS_WITH_INFO) printf("\tdata truncation\n");
              }
        }
    {: .Example}

    </div>

2.  Compile it
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">

        #!/bin/bash
        # gcc -I /usr/local/splice/unixODBC/include listODBCdriver.c -o listODBCdriver -L/usr/local/splice/lib -lodbc -lodbcinst -lodbccr
    {: .ShellCommand}

    </div>

3.  Run the program
    {: .topLevel}

    Run the compiled `listODBCdriver`:
    {: .indentLevel1}

    <div class="preWrapper" markdown="1">
        prompt:~$ ./listODBCdriver
    {: .ShellCommand xml:space="preserve"}

    </div>

    The command should display a result like the following:
    {: .indentLevel1}

    <div class="preWrapper" markdown="1">
        Splice Machine - Description=Splice Machine ODBC Driver
    {: .ShellCommand}

    </div>
{: .boldFont}

</div>
</div>
</section>



[1]: https://www.splicemachine.com/get-started/odbc-driver-download/
[2]: https://msdn.microsoft.com/en-us/library/ms712362(v=vs.85).aspx
