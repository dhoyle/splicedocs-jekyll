---
title: Configuring SSL/TLS Encrypted Connections
summary: How to configure SSL/TLS authentication for connecting to Splice Machine
keywords: SSL, TLS, Secure Socket Layer, Transport Layer Security, authentication, peer authentication
toc: false
compatible_version: 2.7
product: all
sidebar: home_sidebar
permalink: tutorials_security_ssltls.html
folder: DeveloperTutorials/Security
---
{% include splicevars.html %}
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Configuring SSL/TLS Secure Connections

This topic describes how to configure SSL/TLS on your cluster to support
secure JDBC connections to your Splice Machine database.

{% include splice_snippets/onpremonlytopic.md %}

## About Encrypted Connections
By default, JDBC connections to your database are not encrypted. You can
configure SSL/TLS authentication for two different encryption modes:

* *Basic SSL/TLS Encryption* encrypts the data sent back and forth
  between a client and the server.

* *SSL/TLS Encryption with Peer Authentication* encrypts the data sent
  between client and server, and adds a layer of authentication known as
  peer authentication, which uses trusted certificates to authenticate
  the sender and/or receiver.

  The term *peer* is used in this context to refer to the other side of
  a server-client communication: the client is the server's peer, and
  the server is the client's peer.You can set up peer authentication on
  a server, a client, or both.
{: .bullet}

The remainder of this topic shows you how to configure this
authentication, in these sections:

* [Generating Certificates](#gencerts) walks you through generating the
  certificates.
* [Importing Certificates](#imports) describes how to import
  certificates to clients and servers.
* [Updating Configuration Options](#updates) shows you how to update
  your server's configuration options and then restart your server.
* [Restarting your Server](#reboots) describes how to restart the server
  so that your updated security options take effect.
* [Connecting Securely From a Client](#connects) walks you through
  connecting securely from various clients.

We use <span class="HighlightedCode">highlighted text</span> in this
section to display sample names that you should replace with your own
names.
{: .noteNote}

## Generating Certificates   {#gencerts}

This section shows you how to generate the required, trusted
certificates on your server and client(s).

To configure your database for SSL/TLS authentication, you'll need to
use the *keytool* application that is included with the JDK; this tool
is documented here:
[http://docs.oracle.com/javase/8/docs/technotes/tools/unix/keytool.html][1].
{: .noteIcon}

### Generate a Server Certificate

Use the *keytool* to generate a key-pair in the keystore. Here's an
example of interacting with the keytool:

<div class="preWrap" markdown="1">
    % keytool -genkey -alias MyServerName -keystore ~/vault/ServerKeyStore
    Enter keystore password: myPassword
    Re-enter new password: myPassword
    What is your first and last name?
       [Unknown]: John Doe
    What is the name of your organizational unit?
       [Unknown]: TechPubs
    What is the name of your organization?
       [Unknown]: MyCompany
    What is the name of your City or Locality?
       [Unknown]: San Francisco
    What is the name of your State or Province?
       [Unknown]: CA
    What is the two-letter country code for this unit?
       [Unknown]: US
    IS CN=John Doe, OU=TechPubs, O=MyCompany, L=San Francisco, ST=CA, C=US correct?
       [no]: yes

    Enter key password for <MyServerName>
    	    (RETURN if same as keystore password): myPassword
{: .ShellCommand}

</div>
Now issue this *keytool* command to generate the certificate from the
key you just created:

<div class="preWrap" markdown="1">
    % keytool -export -alias MyServerName \
    > -keystore ~/value/ServerKeyStore -rfc -file ServerCertificate \
    > -storepass myPassword
    Certificate stored in file <ServerCertificate>
    % ls -ltr
    total 8
    -rw-rw-r-- 1 myName myGroup 1295 Aug 3 23:15 ServerKeyStore
    -rw-rw-r-- 1 myName myGroup 1181 Aug 3 23:23 ServerCertificate
    %
{: .ShellCommand}

</div>
### Generate Client Certificates

Now use the *keytool* to generate a client key-pair in the keystore; for
example:

<div class="preWrap" markdown="1">
    % keytool -genkey -alias MyClientName -keystore ~/vault/ClientKeyStore
{: .ShellCommand}

</div>
Respond to the questions in the same way as you did when generting the
server key-pair.

And then generate the client certificate:

<div class="preWrap" markdown="1">
    % keytool -export -alias MyClientName \
    > -keystore ~/value/ClientKeyStore -rfc -file ClientCertificate \
    > -storepass myPassword
    Certificate stored in file <ClientCertificate>
    % ls -ltr
    total 8
    -rw-rw-r-- 1 myName myGroup 1295 Aug 3 23:15 ClientKeyStore
    -rw-rw-r-- 1 myName myGroup 1181 Aug 3 23:23 ClientCertificate
    %
{: .ShellCommand}

</div>
## Importing Certificates   {#imports}

After you've generated your certificates, it's time to:

* [Import the server certificate to the client keystore.](#importserver)
* [Import the client certificate to the server keystore.](#importclient)
* [Secure and deploy the keystore and trust store.](#deploy)

### Import Server Certificate to Client Keystore   {#importserver}

You need to copy (`scp`) the server certificate to the client, and then
use a *keytool* command like this to import the certificate:

<div class="preWrap" markdown="1">
    % keytool -import -alias favoriteServerCertificate \
     -file ServerCertificate -keystore ~/vault/ClientTrustStore \
     -storepass secretClientTrustStorePassword
    Owner: CN=John Doe, OU=TechPubs, O=MyCompany, L=San Francisco, ST=CA, C=US
    Issuer: CN=John Doe, OU=TechPubs, O=MyCompany, L=San Francisco, ST=CA, C=US
    Serial number: 24a2c7f7
    Valid from: Thu Aug 03 23:15:52 UTC 2017 until: Wed Nov 01 23:15:52 UTC 2017
    Certificate fingerprints:
    	 MD5:  5B:86:E9:C9:DF:E1:34:41:C8:B0:55:DE:C6:34:8A:21
    	 SHA1: 17:C8:43:FE:9C:FF:0C:4A:B2:51:36:0C:79:16:EB:73:24:C3:5A:83
    	 SHA256: 8D:55:1A:10:37:39:21:14:8E:21:3A:10:78:A1:C7:25:5F:9C:A7:8D:4E:3F:87:40:A0:ED:70:BE:EC:0F:7A:D9
    	 Signature algorithm name: SHA1withDSA
    	 Version: 3

    Extensions:

    #1: ObjectId: 2.5.29.14 Criticality=false
    SubjectKeyIdentifier [
    KeyIdentifier [
    0000: 8B 71 1E 04 E7 E4 84 E6   35 B3 6B EB B5 92 1A 35  .q......5.k....5
    0010: 5E FD B1 40                                        ^..@
    ]
    ]
{: .ShellCommand}

</div>
### Import Client Certificates to Server Keystore   {#importclient}

Next, copy (`scp`) the client certificate to the region server and use
*keytool* to import the certificate:

<div class="preWrap" markdown="1">
{% comment %}
    % keytool -import -alias favoriteServerCertificate \
     -file ServerCertificate -keyStore ./ServerTrustStore \
     -storepass secretServerTrustStorePassword
{% endcomment %}

    % keytool -import -alias Client_1_Certificate \
     -file ClientCertificate -keystore ~/vault/ServerTrustStore \
     -storepass secretServerTrustStorePassword
    Owner: CN=John Doe, OU=TechPubs, O=MyCompany, L=San Francisco, ST=CA, C=US
    Issuer: CN=John Doe, OU=TechPubs, O=MyCompany, L=San Francisco, ST=CA, C=US
    Serial number: 7507d351
    Valid from: Thu Aug 03 23:25:19 UTC 2017 until: Wed Nov 01 23:25:19 UTC 2017
    Certificate fingerprints:
    	 MD5:  19:46:4C:D5:6C:A5:40:AC:6C:F6:2C:DC:7B:86:C5:45
    	 SHA1: BB:D7:9C:5E:5A:EB:E3:D1:F0:22:49:47:D4:C5:31:24:1E:06:0F:AE
    	 SHA256: 88:8E:6E:97:ED:78:B1:AE:5E:65:09:30:C2:E8:AF:B3:DD:40:5A:7B:19:97:ED:04:E0:A3:82:66:E9:A4:3E:2A
    	 Signature algorithm name: SHA1withDSA
    	 Version: 3

    Extensions:

    #1: ObjectId: 2.5.29.14 Criticality=false
    SubjectKeyIdentifier [
    KeyIdentifier [
    0000: 59 37 E4 92 34 0A A2 45   93 E6 45 3A AF 57 77 E8  Y7..4..E..E:.Ww.
    0010: E6 B9 24 08                                        ..$.
    ]
    ]

    Trust this certificate? [no]:  yes
    Certificate was added to keystore
    %
{: .ShellCommand}

</div>
### Secure and Deploy the Keystore and Trust Store   {#deploy}

Once you've imported your certificates, you should copy the `vault`
directory to a location that is directly accessible from HBase. We
recommend copying it to a directory such as `/etc/vault` or
`/hbase/vault`.

You **MUST** deploy the vault directory to the same location on each
region server, so that all region servers can access it during server
startup.
{: .noteIcon}

## Updating Configuration Options   {#updates}

Now that you've got your certificates all set up, you need to modify a
few configuration options and restart the server to take your new
security options live. On a CDH cluster, you need to update the region
server Java options, which you'll find in the Admin console:

<div class="preWrap" markdown="1">
    CDH->HBase->Configuration->Java Configuration Options for HBase Region Server
{: .Plain}

</div>
* If you're using basic SSL/TLS (without peer authentication), add this
  property:

  <div class="preWrap" markdown="1">
      -Dderby.drda.sslMode=basic
      -Djavax.net.ssl.keyStore=/tmp/vault/ServerKeyStore
      -Djavax.net.ssl.keyStorePassword=myPassword
      -Djavax.net.ssl.trustStore=/tmp/vault/ServerTrustStore
      -Djavax.net.ssl.trustStorePassword=secretServerTrustStorePassword
  {: .Plain}

  </div>

* If you're using full SSL/TLS (with peer authentication), add these
  properties:

  <div class="preWrap" markdown="1">
      -Dderby.drda.sslMode=peerAuthentication
      -Djavax.net.ssl.keyStore=/tmp/vault/ServerKeyStore
      -Djavax.net.ssl.keyStorePassword=myPassword
      -Djavax.net.ssl.trustStore=/tmp/vault/ServerTrustStore
      -Djavax.net.ssl.trustStorePassword=secretServerTrustStorePassword
  {: .Plain}

  </div>

## Rebooting Your Cluster   {#reboots}

Once you've updated your configuration, restart HBase to make the
changes effective in your cluster. After HBase restart, you can verify
that the server started in secure mode by examining the logs: If you
look at /var/log/hbase/splice.log, you should see a message similar to
this:

<div class="preWrap" markdown="1">
    Mon AUG 28 04:52:03 UTC 2017 : Splice Machine Network Server - 10.9.2.2 - (1) started and ready to accept SSL connections on port 1527
{: .Example}

</div>
## Connecting Securely From a Client

You can now connect securely to your database. This section provides
several examples:

* [Running the splice&gt; Command Line Securely](#cmdline)
* [Running a JDBC Client App Securely](#jdbcapp)
* [Adding New Client Nodes](#newnode)
* [Connecting Securely From a Third Party Client](#zep)

### Running the <span class="AppFont">splice&gt;</span> Command Line Securely   {#cmdline}

To run the splice&gt; command line securely, you need to export several
`env` variables before starting `sqlshell`. You can then issue a
`connect` command that specifies the type of security, as shown below.

First export the environmental variables that specify your key stores:

<div class="preWrap" markdown="1">
    export CLIENT_SSL_KEYSTORE=/home/splice/vault/ClientKeyStore
    export CLIENT_SSL_KEYSTOREPASSWD=myPassword
    export CLIENT_SSL_TRUSTSTORE=/home/splice/vault/ClientTrustStore
    export CLIENT_SSL_TRUSTSTOREPASSWD=secretClientTrustStorePassword
{: .ShellCommand}

</div>
Then, start the <span class="AppCommand">splice&gt;</span> command line:

<div class="preWrap" markdown="1">
    % ./sqlshell.sh
{: .ShellCommand}

</div>
The `sqlshell` command issues a default (no security) connection
command. To connect securely, add an `ssl=` option to the connect
command. You use different `connect` commands for each of the three
security modes:

<table>
    <col />
    <col />
    <thead>
        <tr><th>Security Mode</th>
        <th>Connect Command</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>None</td>
            <td>
            <div class="preWrap"><pre class="ShellCommandCell">connect 'jdbc:splice://<span class="HighlightedCode">x.x.x.xxx</span>:1527/splicedb;user=YourUserId;password=YourPassword';</pre></div>
            </td>
        </tr>
        <tr>
            <td>Basic SSL</td>
            <td>
            <div class="preWrap"><pre class="ShellCommandCell">connect 'jdbc:splice://<span class="HighlightedCode">x.x.x.xxx</span>:1527/splicedb;user=YourUserId;password=YourPassword;ssl=basic';</pre></div>
            </td>
        </tr>
        <tr>
            <td>SSL w/Peer Authentication</td>
            <td>
            <div class="preWrap"><pre class="ShellCommandCell">connect 'jdbc:splice://<span class="HighlightedCode">x.x.x.xxx</span>:1527/splicedb;user=YourUserId;password=YourPassword;ssl=peerAuthentication';</pre></div>
            </td>
        </tr>
    </tbody>
</table>
### Running a JDBC Client App Securely   {#jdbcapp}

To use a secured connection with a JDBC client app, you need to specify
a connection string that includes the `ssl` option. If you don't specify
this option, the default JDBC connection is unsecured, as shown in the
*Connect Command* table in the previous section.

Here's a sample declaration for a peer authenticated connection to a
Splice Machine database:

<div class="preWrap" markdown="1">
    String dbUrl = "jdbc:splice://1.2.3.456:1527/splicedb;user=YourUserId;password=YourPassword;ssl=peerAuthentication";
{: .Example}

</div>

We can create a Java program that includes that declaration and then
compile it into `SampleJDBC.java` with a command like this:

<div class="preWrap" markdown="1">
    + javac -classpath ".:./db-client-2.6.0.1729-SNAPSHOT.jar" ./SampleJDBC.java
{: .Example}

</div>

We can then use a command like this to execute and JDBC app with the
correct SSL keystore and truststore properties:

<div class="preWrap" markdown="1">
    % java -classpath .:./db-client-2.6.0.1729-SNAPSHOT.jar
    -Djavax.net.ssl.keyStore=/home/splice/vault/ClientKeyStore
    -Djavax.net.ssl.keyStorePassword=myPassword
    -Djavax.net.ssl.trustStore=/home/splice/vault/ClientTrustStore
    -Djavax.netDjavax.net.ssl.trustStore.ssl.trustStorePassword=secretClientTrustStorePassword SampleJDBC
{: .Example}

</div>
### Adding New Client Nodes   {#newnode}

Whenever you connect a new client node to a server, you need to perform
a few steps to enable SSL/TLS on the new node:

* [Generate a new client certificate.](#gencerts)

* [Import the new client certificate into the server's
  keystore.](#imports)

* [Import the server certificate into the new client's
  keystore.](#updates)

* Restart the server.

Finally, you need to set these env variables:

<div class="preWrap" markdown="1">
    export CLIENT_SSL_KEYSTORE=/home/splice/vault/ClientKeyStore
    export CLIENT_SSL_KEYSTOREPASSWD=myPassword
    export CLIENT_SSL_TRUSTSTORE=/home/splice/vault/ClientTrustStore
    export CLIENT_SSL_TRUSTSTOREPASSWD=secretClientTrustStorePassword
{: .ShellCommand}

</div>
### Connecting Securely From a Third Party Client   {#zep}

This section describes what you need to do to connect securely to your
Splice Machine from a third party client. We use Zeppelin as an example;
other clients will have similar requirements. For Zeppelin, follow these
steps

1.  Navigate to and edit the `bin/interpreter.sh` file in the `Zeppelin`
    installation directory.

2.  Find the <span class="CodeBoldFont">JAVA_INTP_OPTS</span> property
    definition.

3.  Append the following SSL properties onto that definition:

    <div class="preWrap" markdown="1">
        JAVA_INTP_OPTS+="
        -Dzeppelin.log.file=${ZEPPELIN_LOGFILE} \
        -Djavax.net.ssl.keyStore=${CLIENT_SSL_KEYSTORE} \
        -Djavax.net.ssl.keyStorePassword=${CLIENT_SSL_KEYSTOREPASSWD} \
        -Djavax.net.ssl.trustStore=${CLIENT_SSL_TRUSTSTORE} \
        -Djavax.netDjavax.net.ssl.trustStore.ssl.trustStorePassword=${CLIENT_SSL_TRUSTSTOREPASSWD} "
    {: .Plain}

    </div>

4.  Make sure that you have exported the SSL keystore and truststore env
    variables:

    <div class="preWrap" markdown="1">
        export CLIENT_SSL_KEYSTORE=/home/splice/vault/ClientKeyStore
        export CLIENT_SSL_KEYSTOREPASSWD=myPassword
        export CLIENT_SSL_TRUSTSTORE=/home/splice/vault/ClientTrustStore
        export CLIENT_SSL_TRUSTSTOREPASSWD=secretClientTrustStorePassword
    {: .ShellCommand}

    </div>

5.  Restart Zeppelin:

    <div class="preWrap" markdown="1">
        % zeppelin-daemon.sh start
    {: .ShellCommand}

    </div>

6.  Create a new JDBC Interpreter

    Navigate to the [Zeppelin interface URL:][2], then click <span
    class="ConsoleLink">Interpreter->+Create</span> to create a new
    interpreter. The image below shows sample settings for the new
    interpreter:

    ![](images/NewZepInterpreter.png)

    Be sure to provide the correct JDBC driver loaction in the artifact
    dependencies section.
    {: .noteIcon}

7.  Save the new interpreter.
8.  Create a new Note with the new interpreter.

</div>
</section>



[1]: http://docs.oracle.com/javase/8/docs/technotes/tools/unix/keytool.html
[2]: http://localhost:8080/#/
