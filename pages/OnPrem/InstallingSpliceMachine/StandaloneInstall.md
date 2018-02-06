---
summary: How to download, install, and start using the standalone version of Splice Machine.
title: Installing the Standalone Version of Splice Machine.
keywords: standalone version, hadoop, hbase, hdfs sqlshell.sh, sqlshell, download splice
toc: false
product: onprem
sidebar:  onprem_sidebar
permalink: onprem_install_standalone.html
folder: OnPrem/InstallingSpliceMachine
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Installing the Standalone Version of Splice Machine

{% include splice_snippets/onpremonlytopic.md %}
This topic walks you through downloading, installing, and getting
started with using the standalone version of Splice Machine.

## About the Standalone Version

The standalone version of Splice Machine runs on a single computer,
rather than on a cluster; it is intended to allow you to get your feet
wet with Splice Machine. The standalone version installs quickly on your
MacOS, Linux, or CentOS computer, and enables rapid access to Splice
Machine's capabilities. It's an excellent way to experiment with Splice
Machine with a reasonably small amount of data.

Note that many of our customers also use the standalone version of
Splice Machine for ongoing development work. For example, if your
engineers want to create stored procedures to optimize aspects of your
database, they can develop and debug those procedures on the standalone
version before deploying them to your cluster.

This topic walks you through getting the standalone version of Splice
Machine installed on your computer. Because Splice Machine is a Java
application, youll have to meet some prerequisites for the way your
computer supports Java. You may already have created these settings for
other Java applications, but just to be sure, we list them in this
tutorial for each of the supported operating systems.

You can [watch the video version](#Watch) of getting Splice Machine
installed on your computer, or [follow the written
instructions](#Follow).

Many other Big Data applications and services like [HBase][1]{:
target="_blank"}, [Kafka][2]{: target="_blank"}, [Hadoop][3]{:
target="_blank"}, [Prometheus][4]{: target="_blank"}, and [even parts of
the ELK stack][5]{: target="_blank"} are also written (at least
partially) in Java, and so they require these extra Java setup steps as
well.
{: .noteNote}

{% if site.incl_notpdf %}
<div class="videoEnvelope" markdown="1">
## Watch the Video Version   {#Watch}

This video walks you through setting up `$JAVA_HOME` on MacOS, then
configuring installation prerequisites for each of the operating systems
below. We'll also do a quick install and sanity check on Splice Machine.

<iframe class="youtube-player_0"
src="https://www.youtube.com/embed/Pb25HRnPAbs?" frameborder="0"
allowfullscreen="1" width="560px" height="315px"></iframe>

</div>
{% endif %}
## Follow the Written Instructions   {#Follow}

This section includes written instructions for configuring your computer
for Splice Machine and then installing our standalone version, in these
steps:

* [Prepare for Installation on Your Computer](#Prepare)
* [Install Splice Machine](#Install)
* [Start Using Splice Machine](#Start)

Note that we have also created a [short tutorial that shows you how to
import the demo data](onprem_install_demodata.html) included in our
installation. We recommend that you follow the steps in this tutorial to
import and then run a few test queries against the demo data to start
experiencing the full power of Splice Machine.

### Prepare for Installation on Your Computer   {#Prepare}

This section walks you through preparing your computer for installation
of Splice Machine; follow the instructions for your operating system:

* [Mac OSX](#Configur)
* [Ubuntu Linux](#Configur2)
* [CentOS/Red Hat Enterprise Linux (RHEL)](#Configur3)

#### Configure Mac OSX for Splice Machine   {#Configur}

Follow these steps to prepare your MacOS computer to work with Splice
Machine:

<div class="opsStepsList" markdown="1">
1.  If you have [Homebrew][6]{: target="_blank"} installed
    {: .topLevel}

    Fire up the `Terminal` app and enter the following commands:
    {: .indentLevel1}

    <div class="preWrapper" markdown="1">
        $ brew update
        $ brew cask install java
        $ brew install rlwrap
    {: .ShellCommand}

    </div>

2.  If you do not have [Homebrew][6]{: target="_blank"} installed:
    {: .topLevel}

    1.  Download the Java SE Development Kit (JDK 8) from this URL:

        <div class="preWrapper" markdown="1">
            http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html
        {: .Plain xml:space="preserve"}

        </div>

    2.  Open the downloaded installer and compete the installation
        wizard to install the JDK.

    3.  Download and install `rlWrap`. You can find rlWrap online, along
        with instructions for installing it using `brew` or another
        installation method. Some experts advise using Homebrew instead
        of any other method.
    {: .LowerAlphaPlainFont}

3.  Check that your $JAVA_HOME environment variable is set:
    {: .topLevel}

    1.  Edit your `~/.bash_profile` file with your favorite text editor;
        for example:

        <div class="preWrapper" markdown="1">
            $ sudo vi ~/.bash_profile
        {: .ShellCommand xml:space="preserve"}

        </div>

    2.  Add the following `export` command at the bottom of the
        `.bash_profile` file.

        <div class="preWrapper" markdown="1">
            export JAVA_HOME=`/usr/libexec/java_home`
        {: .Plain xml:space="preserve"}

        </div>

    3.  Save the file and close your editor.

    4.  Run the following command to load the updated profile into your
        current session:

        <div class="preWrapper" markdown="1">
            $ source ~/.bash_profile
        {: .ShellCommand xml:space="preserve"}

        </div>

    5.  To verify that this setting is correct, make sure that the
        following commands display the same value:

        <div class="preWrapper" markdown="1">
            $ echo $JAVA_HOME/usr/libexec/java_home
        {: .ShellCommand}

        </div>
    {: .LowerAlphaPlainFont}
{: .boldFont}

</div>
#### Configure Ubuntu Linux for Splice Machine   {#Configur2}

Follow these steps to prepare your Ubuntu computer to work with Splice
Machine:

Installing on Linux can be a bit tricky, so please use the `pwd` command
to ensure that you are in the directory in which you need to be.
{: .noteNote}

<div class="opsStepsList" markdown="1">
1.  Install the Java SE Development Kit
    {: .topLevel}

    Fire up the `Terminal` app and enter the following commands:
    {: .indentLevel1}

    <div class="preWrapper" markdown="1">
        $ sudo add-apt-repository ppa:webupd8team/java$ sudo apt-get update$ sudo apt-get install oracle-java8-installer
        $ sudo apt install oracle-java8-set-default
    {: .ShellCommand}

    </div>

2.  Set the $JAVA_HOME environment variable is set:
    {: .topLevel}

    1.  Find the location of Java on your computer by executing this
        command:

        <div class="preWrapper" markdown="1">
            $ sudo update-alternatives --config java
        {: .ShellCommand xml:space="preserve"}

        </div>

        Copy the resulting path to the clipboard.

    2.  Use your favorite text editor to open `/etc/environment`:

        <div class="preWrapper" markdown="1">
            sudo vi /etc/environment
        {: .ShellCommand xml:space="preserve"}

        </div>

    3.  Add the following `export` command at the bottom of the
        `/etc/environment` file.

        <div class="preWrapper" markdown="1">
            JAVA_HOME="/usr/lib/jvm/java-8-oracle"
        {: .Plain xml:space="preserve"}

        </div>

    4.  Run the following command to load the updated profile into your
        current session:

        <div class="preWrapper" markdown="1">
            source ~/etc/environment
        {: .ShellCommand xml:space="preserve"}

        </div>

    5.  Run this command to make sure the setting is correct:

        <div class="preWrapper" markdown="1">
            $ echo $JAVA_HOME
        {: .ShellCommand}

        </div>
    {: .LowerAlphaPlainFont}

3.  Install Additional Libraries:
    {: .topLevel}

    You need to have the following packages installed for Splice Machine
    to run:
    {: .indentLevel1}

    * <span class="PlainFont">curl</span>
    * <span class="PlainFont">nscd</span>
    * <span class="PlainFont">ntp</span>
    * <span class="PlainFont">openssh</span>
    * <span class="PlainFont">openssh-clients</span>
    * <span class="PlainFont">openssh-server</span>
    * <span class="PlainFont">patch</span>
    * <span class="PlainFont">rlwrap</span>
    * <span class="PlainFont">wget</span>

    You can use the `apt-get` package manager to install each of these
    packages, using a command line like this:

    <div class="preWrapper" markdown="1">
        $ sudo apt-get install <packagename>
    {: .ShellCommand}

    </div>

4.  Configure Additional Parameters:
    {: .topLevel}

    You need to complete these steps:
    {: .indentLevel1}

    <table>
                                <col />
                                <col />
                                <tbody>
                                    <tr>
                                        <td>Create symbolic link for YARN</td>
                                        <td><code>sudo ln -s /usr/bin/java /bin/java</code></td>
                                    </tr>
                                    <tr>
                                        <td>Configure swappiness</td>
                                        <td><code>$ echo 'vm.swappiness = 0' &gt;&gt; /etc/sysctl.conf</code></td>
                                    </tr>
                                    <tr>
                                        <td>Create an alias</td>
                                        <td><code>$ rm /bin/sh ; ln -sf /bin/bash /bin/sh</code></td>
                                    </tr>
                                </tbody>
                            </table>

5.  Ensure all necessary services are started:
    {: .topLevel}

    You can start all necessary services as follows:

    <div class="preWrapperWide" markdown="1">
        $ sudo service nscd start  && service ntp start  && service ssh start
    {: .ShellCommand}

    </div>

    Finally, you can check that the services are running with the
    following command:

    <div class="preWrapperWide" markdown="1">
        $ service <service_name> status
    {: .ShellCommand}

    </div>
{: .boldFont}

</div>
#### Configure CentOS/Red Hat Enterprise Linux (RHEL) for Splice Machine   {#Configur3}

Follow these steps to prepare your RHEL computer to work with Splice
Machine:

Installing on Linux can be a bit tricky, so please use the `pwd` command
to ensure that you are in the directory in which you need to be.
{: .noteNote}

<div class="opsStepsList" markdown="1">
1.  Install the Java SE Development Kit
    {: .topLevel}

    Fire up the `Terminal` app and enter the following commands:
    {: .indentLevel1}

    To install JDK 8, run one of the following sets of commands:

    <div class="preWrapperWide" markdown="1">
        $ cd /opt/$ wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u121-b13/e9e7ea248e2c4826b92b3f075a80e441/jdk-8u121-linux-x64.tar.gz"$ tar xzf jdk-8u121-linux-i586.tar.gz
    {: .ShellCommand}

    </div>

    or:

    <div class="preWrapperWide" markdown="1">
        $ wget http://download.oracle.com/otn-pub/java/jdk/8u121-b13/e9e7ea248e2c4826b92b3f075a80e441/jdk-8u121-linux-x64.rpm$ sudo yum localinstall jdk-8u121-linux-x64.rpm
    {: .ShellCommand}

    </div>

    or:

    <div class="preWrapperWide" markdown="1">
        $ sudo rpm -ivh jdk-8u121-linux-x64.rpm
    {: .ShellCommand}

    </div>

2.  Set up sudo rights
    {: .topLevel}

    Your User ID must be in the `sudoers` file. To do so, please see the
    following web page:

    <div class="preWrapperWide" markdown="1">
        https://www.digitalocean.com/community/tutorials/how-to-edit-the-sudoers-file-on-ubuntu-and-centos
    {: .Plain}

    </div>

3.  Set the $JAVA_HOME environment variable is set:
    {: .topLevel}

    1.  Find the path to the java installation on your computer:

        <div class="preWrapper" markdown="1">
            $ find / -name java
        {: .ShellCommand xml:space="preserve"}

        </div>

    2.  Configure your `$JAVA_HOME` environment variable to the path you
        found in the previous step, as follows:

        <div class="preWrapper" markdown="1">
            $ echo export JAVA_HOME=/opt/jdk1.8.0_121 >/etc/profile.d/javaenv.sh
        {: .ShellCommand xml:space="preserve"}

        </div>

    3.  Make sure your `$JRE_HOME` variable is set up:

        <div class="preWrapper" markdown="1">
            $ echo export JRE_HOME=/opt/jdk1.8.0_121/jre >/etc/profile.d/javaenv.sh
        {: .ShellCommand xml:space="preserve"}

        </div>

    4.  Set up your `$PATH` variable for your JVM:

        <div class="preWrapperWide" markdown="1">
            $ echo export PATH=$PATH:/opt/jdk1.8.0_121/bin:/opt/jdk1.8.0_121/jre/bin >/etc/profile.d/javaenv.sh
        {: .ShellCommand xml:space="preserve"}

        </div>

    5.  Confirm the variables are set with the echo command (you may
        need to reload your terminal first):

        <div class="preWrapper" markdown="1">
            $ echo $JAVA_HOME
        {: .ShellCommand}

        </div>
    {: .LowerAlphaPlainFont}

4.  Install Additional Libraries:
    {: .topLevel}

    You need to have the following packages installed for Splice Machine
    to run:
    {: .indentLevel1}

    curl, nscd, ntp, openssh, openssh-clients, openssh-server, patch,
    rlwrap, wget, ftp, nc, EPEL repository

    * <span class="PlainFont">curl</span>
    * <span class="PlainFont">EPEL repository</span>
    * <span class="PlainFont">ftp</span>
    * <span class="PlainFont">nc</span>
    * <span class="PlainFont">nscd</span>
    * <span class="PlainFont">ntp</span>
    * <span class="PlainFont">openssh</span>
    * <span class="PlainFont">openssh-clients</span>
    * <span class="PlainFont">openssh-server</span>
    * <span class="PlainFont">patch</span>
    * <span class="PlainFont">rlwrap</span>
    * <span class="PlainFont">wget</span>

    You can install these libraries as follows:

    1.  To update CentOS:

        <div class="preWrapper" markdown="1">
            $ yum update
        {: .ShellCommand xml:space="preserve"}

        </div>

    2.  To install a binary:

        <div class="preWrapper" markdown="1">
            $ yum install <packagename>
        {: .ShellCommand xml:space="preserve"}

        </div>

    3.  To install EPEL repository:

        <div class="preWrapper" markdown="1">
            $ yum -y install epel-release
        {: .ShellCommand xml:space="preserve"}

        </div>

    4.  To test if a package is installed:

        <div class="preWrapperWide" markdown="1">
            $ yum info <packagename>
        {: .ShellCommand xml:space="preserve"}

        </div>
    {: .LowerAlphaPlainFont}

5.  Configure Additional Parameters:
    {: .topLevel}

    Execute this command:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        $ sed -i '/requiretty/ s/^/#/' /etc/sudoers
    {: .ShellCommand}

    </div>

6.  Ensure all necessary services are started:
    {: .topLevel}

    You can start all necessary services as follows:

    <div class="preWrapperWide" markdown="1">
        $ /sbin/service nscd start  && /sbin/service ntpd start  && /sbin/service sshd start
    {: .ShellCommand}

    </div>

    Finally, you can check that the services are running with the
    following command:

    <div class="preWrapperWide" markdown="1">
        $ chkconfig --list
    {: .ShellCommand}

    </div>
{: .boldFont}

</div>
### Install Splice Machine   {#Install}
{% include splicevars.html %}

Now that you've got your system configured for Splice Machine, let's
download and install the standalone version of Splice Machine, and start
using it!

<div class="opsStepsList" markdown="1">
1.  Download the Splice Machine installer.
    {: .topLevel}

    Visit this page: <a href="{{splvar_location_StandaloneLink}}">{{splvar_location_StandaloneLink}}</a>
    {: .indentLevel1 }

2.  Copy the downloaded tarball (.gz file) to the directory on your
    computer in which you want to install Splice Machine
    {: .topLevel}

    You should only install in a directory whose name does not contain
    spaces, because some scripts will not operate correctly if the
    working directory has spaces in its name.
    {: .indentLevel1}

3.  Install Splice Machine:
    {: .topLevel}

    Unpack the tarball `gz` file that you downloaded:
    {: .indentLevel1}

    <table>
        <col />
        <col />
        <thead>
            <tr>
                <th>Splice Machine Release</th>
                <th>Installer Package Link</th>
            </tr>
        </thead>
        <tbody>
           <tr>
               <td class="SpliceRelease">2.7.0</td>
               <td><a href="{{splvar_install_v270_Standalone}}">{{splvar_install_v270_Standalone}}</a></td>
            </tr>
            <tr>
                <td colspan="2" class="Separator"> </td>
            </tr>
           <tr>
               <td class="SpliceRelease">2.5.0</td>
               <td><a href="{{splvar_install_v250_Standalone}}">{{splvar_install_v250_Standalone}}</a></td>
            </tr>
        </tbody>
    </table>

    This creates a `splicemachine` subdirectory and installs Splice
    Machine software in it.
    {: .indentLevel1}
{: .boldFont}

</div>
### Start Using Splice Machine   {#Start}

Start Splice Machine on your computer and run a few commands to verify
the installation:

<div class="opsStepsList" markdown="1">
1.  Make your install directory the current directory
    {: .topLevel}

    <div class="preWrapper" markdown="1">
        cd splicemachine
    {: .ShellCommand}

    </div>

2.  Run the Splice Machine start-up script
    {: .topLevel}

    <div class="preWrapper" markdown="1">
        {{splvar_location_StandaloneStartScript}}
    {: .ShellCommand xml:space="preserve"}

    </div>

    Initialization of the database may take a couple minutes. It is
    ready for use when you see this message:
    {: .indentLevel1}

    <div class="preWrapper" markdown="1">
        Splice Server is ready
    {: .ShellCommand xml:space="preserve"}

    </div>

3.  Start using the Splice Machine command line interpreter by launching
    the `sqlshell.sh` script:
    {: .topLevel}

    <div class="preWrapper" markdown="1">

        ./bin/sqlshell.sh
    {: .ShellCommand xml:space="preserve"}

    </div>

    Once you have launched the command line interpreter (the <span
    class="AppCommand">splice&gt;</span> prompt), we recommend verifying
    that all is well by running a few sample commands. First:

    <div class="preWrapper" markdown="1">
        splice> show tables;
    {: .AppCommand xml:space="preserve"}

    </div>

    You'll see the names of the tables that are already defined in the
    Splice Machine database; namely, the system tables. Once that works,
    you know Splice Machine is alive and well on your computer, and you
    can use help to list the available commands:

    <div class="preWrapper" markdown="1">
        splice> help;
    {: .AppCommand xml:space="preserve"}

    </div>

    When you're ready to exit Splice Machine:

    <div class="preWrapper" markdown="1">
        splice> exit;
    {: .AppCommand xml:space="preserve"}

    </div>

    <div class="indented" markdown="1">
    **Make sure you end each command with a semicolon** (`;`), followed
    by the *Enter* key or *Return* key.
    {: .noteNote}

    </div>
{: .boldFont}

</div>
## Finally

We do hope you found these instructions helpful, whatever your Java
service happens to be. Now that you are ready to start working with
Splice Machine, youll find great content here:

* Note that we have also created a [short tutorial that shows you how to
  import the demo data](onprem_install_demodata.html) included in our
  installation. We recommend that you follow the steps in this tutorial
  to import and then run a few test queries against the demo data to
  start experiencing the full power of Splice Machine.
* Documentation - Start Here: [Documentation Home Page](index.html)
* Tutorials: [Tutorials Home Page](tutorials_intro.html)

We welcome any of your questions or comments on our [forum][7]{:
target="_blank"} or [slack][8]{: target="_blank"} channel within the
Splice Machine [community][9]{: target="_blank"}. If you have more
questions or would like to see a demo of our system, reach out to us at
[info@splicemachine.com](mailto:info@splicemachine.com) or by filling
out this [form][10]{: target="_blank"}.

</div>
</section>



[1]: https://hbase.apache.org/
[2]: https://kafka.apache.org/
[3]: http://hadoop.apache.org/
[4]: https://prometheus.io
[5]: https://www.digitalocean.com/community/tutorials/how-to-install-elasticsearch-logstash-and-kibana-elk-stack-on-ubuntu-14-04
[6]: http://brew.sh/
[7]: http://community.splicemachine.com/community/forum/
[8]: http://community.splicemachine.com/slack-channel-signup/
[9]: http://community.splicemachine.com
[10]: https://www.splicemachine.com/company/contact-us/
