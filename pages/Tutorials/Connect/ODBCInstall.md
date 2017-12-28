---
title: Using the Splice Machine ODBC Driver
summary: How to install and configure the Splice Machine ODBC driver.
keywords: ODBC driver, install driver, odbc logging, odbc windows, odbc mac, odbc linux, odbc unix
toc: false
product: all
sidebar: tutorials_sidebar
permalink: tutorials_connect_odbcinstall.html
folder: Tutorials/Connect
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

{% if site.isbuild_doc == true %}
9.  Configure your new data source:
    {: .topLevel}

    When you click the <span class="AppCommand">Finish</span> button in
    the *Create New Data Source* screen, the ODBC Administrator tool
    displays the data source configuration screen.

    Set the fields in the *Data Source* and *Splice Machine Login* sections similarly to the settings shown here:
    {: .indentLevel1}

    ![Configuring the Splice Machine ODBC data source on
    Windows](images/ODBCConfigureOld.png){: .nestedTightSpacing}

    The default <span class="AppCommand">user</span> name is `splice`,
    and the default <span class="AppCommand">password</span> is `admin`.

    For <span class="AppCommand">Server</span>: on a cluster, specify
    the IP address of an HBase RegionServer. If you're running the
    standalone version of Splice Machine, specify `localhost`.
    {: .noteNote}

    If you have Splice Machine running, you can click the *Test...* button at the bottom of the Configuration dialog to verify that all is well.
    {: .indentLevel1}

{% else %}

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

    The default <span class="AppCommand">user</span> name is `splice`,
    and the default <span class="AppCommand">password</span> is `admin`.

    For <span class="AppCommand">Server</span>: on a cluster, specify
    the IP address of an HBase RegionServer. If you're running the
    standalone version of Splice Machine, specify `localhost`.
    {: .noteNote}

    #### Configuring SSL
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
              </td>
           </tr>
       </tbody>
    </table>

    Here's an example of configuring Peer Authentication and trusting the certificate:

    ![Configuring the SSL for the Splice Machine ODBC data source on
    Windows](images/ODBCConfigureTLS.png){: .nestedTightSpacing}

    If you have Splice Machine running, you can click the *Test...* button at the bottom of the Configuration dialog to verify that all is well.
    {: .indentLevel1}

{% endif %}

10. Configure logging (optional):
    {: .topLevel}

    You can optionally configure the ODBC driver to log activity. This
    can be handy for debugging connection issues; however, it adds
    overhead and will have a significant impact on performance. Click
    the <span class="AppCommand">Logging Options</span> button in the
    ODBC Administrator *Configuration* screen to enable or disable
    logging:
    {: .indentLevel1}

    ![Configuring Splice Machine ODBC driver logging on
    Windows](images/ODBCLogging.png){: .nestedTightSpacing}
{: .boldFont}

</div>
## Installing the Driver on Linux   {#Installi2}

Follow these steps to install the Splice Machine ODBC driver on a Linux
computer:

<div class="opsStepsList" markdown="1">
1.  Make sure you have unixODBC installed.
    {: .topLevel}

    You must have version `2.2.12` or later of the `unixODBC` driver
    manager installed to run the Splice Machine ODBC driver.
    {: .indentLevel1}

    Some Linux distributions include `unixODBC`, while others do not.
    Our driver will not work without it. For more information about
    unixODBC, see: [http://www.unixodbc.org][3]{: target="_blank"}.
    {: .indentLevel1}

2.  Download the installer:
    {: .topLevel}

    You can download the driver installer from our ODBC download
    site: [{{splvar_location_ODBCDriverLink}}][1]{: target="_blank"}
    {: .indentLevel1}

    Download the installer to the Linux computer on which you want to
    install the driver. The file will have a name similar to this:
    {: .indentLevel1}

    <div class="preWrapper" markdown="1">
        splice_odbc_64-1.0.28.0.x86_64.tar.gz
    {: .Plain}

    </div>

3.  Unzip the installation package
    {: .topLevel}

    Use the following command to unpack the tarball you installed,
    substituting in the actual version number from the download:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        tar xzf splice_odbc_64-<version>.x86_64.tar.gz
    {: .ShellCommand}

    </div>

    This creates a directory named `splice_odbc_64-<version>`.
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

    The script prompts you for a location; in most cases, you can simply
    accept the default directory.
    {: .indentLevel1}

    The install directory will contain two subdirectories:
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

    The install directory will also contain 3 configuration files that
    you can edit:
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

    1.  Edit the `odbc.ini` file in the install directory to match your
        configuration by changing the `Driver` `URL` value to match your
        Splice Machine installation.
        {: .topLevel}

        > The <span class="AppCommand">URL</span> field in the
        > `odbc.ini` file is actually the IP address of the Splice
        > Machine server.
        > {: .noteNote}

        Then copy the modified `odbc.ini` file into your home directory,
        making sure you make the file hidden by preceding its name with
        a dot:

        <div class="preWrapperWide" markdown="1">
            cp odbc.ini ~/.odbc.ini
        {: .ShellCommand}

        </div>

        If you want your settings to apply system-wide, copy the file to
        `/etc`:

        <div class="preWrapperWide" markdown="1">
            cp odbc.ini /etc/
        {: .ShellCommand}

        </div>

        The default version of the `odbc.ini` file looks like this:

        <div class="preWrapperWide" markdown="1">
            [ODBC Data Sources]
            SpliceODBC64        = SpliceODBCDriver

            [SpliceODBC64]
            Description     = Splice Machine ODBC 64-bit
            Driver          = /usr/local/splice/lib64/libsplice_odbc.so
            UID             = splice
            PWD             = admin
            URL             = 0.0.0.0
            PORT            = 1527
            SSL             = peerAuthentication
            SSL_CERT        = /home/splice/client.pem
            SSL_PKEY        = /home/splice/client.key
            SSL_TRUST       = TRUE
        {: .Plain}
        </div>

        If you are connecting to a Kerberos-enabled cluster using ODBC, you **must add this parameter**:
        <div class="preWrapperWide" markdown="1">
            USE_KERBEROS    = 1
        {: .Plain}
        </div>

        For more information about connecting to a Kerberos-enabled cluster, see [Connecting to Splice Machine Through HAProxy](tutorials_connect_haproxy.html).

    2.  Copy the `odbcinst.ini` configuration file:
        {: .topLevel}

        The `odbcinst.ini` file does not typically require any
        modification. You should copy it to your home directory, and if
        desired, make it system-wide by copying to `/etc`:

        <div class="preWrapperWide" markdown="1">
            cp odbcinst.ini ~/.odbcinst.inicp odbcinst.ini /etc/
        {: .ShellCommand}

        </div>

        The default version of the `odbcinst.ini` file looks like this:

        <div class="preWrapperWide" markdown="1">
            [ODBC Drivers]
            SpliceODBCDriver = Installed
            [SpliceODBCDriver]
            Description = Splice Machine 64-bit ODBC Driver
            Driver = /usr/local/splice/lib64/libsplice_odbc.so
            SQLLevel = 1
            APILevel = 1
            ConnectFunctions = YYY
            DriverIDBCVer = 03.80
        {: .Plain}

        </div>

    3.  Edit (if desired) and copy the `splice.odbcdriver.ini` file:
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

        Copy the `splice.odbcdriver.ini` file to your `$HOME` directory,
        renaming it to `.splice.odbcdriver.ini`:
        {: .indentLevel1}

        <div class="preWrapperWide" markdown="1">
            cp splice.odbcdriver.ini $HOME/.splice.odbcdriver.ini
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
                        <ul class="plainFont">
                            <li>the <code>splice_driver.log</code> file contains driver interactions with the application and the driver manager</li>
                            <li>the <code>splice_derby.log</code> file contains information about the drivers interaction with the Splice Machine cluster</li>
                        </ul>
                    </td>
                </tr>
            </tbody>
        </table>
    {: .LowerAlpha}

6.  Verify your installation
    {: .topLevel}

    You can test your installation by using the following command to run
    `isql`:
    {: .indentLevel1}

    <div class="preWrapper" markdown="1">
        isql SpliceODBC64 splice admin
    {: .ShellCommand}

    </div>
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
[3]: http://www.unixodbc.org/
