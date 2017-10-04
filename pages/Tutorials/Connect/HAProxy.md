---
title: Connecting to Splice Machine Through HAProxy
summary: How to connect to Splice Machine through HAProxy
keywords: haproxy, load balancing, high availability, TCP requests, http requests, client requests, kerberos
toc: false
product: all
sidebar: tutorials_sidebar
permalink: tutorials_connect_haproxy.html
folder: Tutorials/Connect
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Configuring Load Balancing and High Availability with HAProxy

HAProxy is an open source utility that is available on most Linux
distributions and cloud platforms for load-balancing TCP and HTTP
requests. Users can leverage this tool to distribute incoming client
requests among the region server nodes on which Splice Machine instances
are running.

The advantages of using HAProxy with Splice Machine clusters are:

* Users need to point to only one JDBC host and port for one Splice
  Machine cluster, which may have 100s of nodes.
* The HAProxy service should ideally be running on a separate node that
  is directing the traffic to the region server nodes; this means that
  if one of the region server node goes down, users can still access the
  data from another region server node.
* The load balance mechanism in HAProxy helps distribute the workload
  evenly among the set of nodes; you can optionally select this
  algorithm in your configuration, which can help increase throughput
  rate.

The remainder of this topic walks you through:

* [Configuring HAProxy on a non-Splice Machine node that is running Red
  Hat Enterprise Linux](#Configur).
* [Using HAProxy on a Kerberos-enabled cluster](#Using)

## Configuring HAProxy with Splice Machine   {#Configur}

The following example shows you how to configure HAProxy load balancer
on a non-Splice Machine node on a Red Hat Enterprise Linux system.
Follow these steps:

<div class="opsStepsList" markdown="1">
1.  Install HAProxy as superuser :
    {: .topLevel}

    <div class="preWrapper" markdown="1">
        # yum install haproxy
    {: .ShellCommand}

    </div>

2.  Configure the `/etc/haproxy/haproxy.cfg` file, following the
    comments in the sample file below:
    {: .topLevel}

    In this example, we set the incoming requests to
    `haproxy_host:1527`, which uses a balancing algorithm of least
    connections to distribute among the nodes `srv127, srv128, srv129,
    `and `srv130`. This means that the incoming connection is routed to
    the region server that has the least number of connections; thus,
    the client JDBC URL should point to `<haproxy_host>:1527`.

    The HAProxy manual describes other balancing algorithms that you can
    use.
    {: .noteNote}

    Here is the `haproxy.cfg` file for this example:

    <div class="preWrapperWide" markdown="1">
        #---------------------------------------------------------------------
        # Global settings
        #---------------------------------------------------------------------
        global
            # to have these messages end up in /var/log/haproxy.log you will
            # need to:
            #
            # 1) configure syslog to accept network log events.  This is done
            #    by adding the '-r' option to the SYSLOGD_OPTIONS in
            #    /etc/sysconfig/syslog
            #
            # 2) configure local2 events to go to the /var/log/haproxy.log
            #   file. A line like the following can be added to
            #   /etc/sysconfig/syslog
            #
            #    local2.*                       /var/log/haproxy.log
            #
            maxconn 4000
            log 127.0.0.1 local2
            user haproxy
            group haproxy


        #---------------------------------------------------------------------
        # common defaults that all the 'listen' and 'backend' sections will
        # use if not designated in their block
        #---------------------------------------------------------------------
        defaults
            log global
            retries 2
            timeout connect 30000
            timeout server 50000
            timeout client 50000

        #----------------------------------------------------------------------
        # This enables jdbc/odbc applications to connect to HAProxy_host:1527 port
        # so that HAProxy can balance between the splice engine cluster nodes
        # where each node's splice engine instance is listening on port 1527
        #----------------------------------------------------------------------
        listen splice-cluster
            bind *:1527
            log global
            mode tcp
            option tcplog
            option tcp-check
            option log-health-checks
            timeout client 3600s
            timeout server 3600s
            balance leastconn
            server srv127 10.1.1.227:1527 check
            server srv128 10.1.1.228:1527 check
            server srv129 10.1.1.229:1527 check
            server srv130 10.1.1.230:1527 check

        #--------------------------------------------------------
        # (Optional) set up the stats admin page at port 1936
        #--------------------------------------------------------
        listen   stats :1936
            mode http
            stats enable
            stats hide-version
            stats show-node
            stats auth admin:password
            stats uri  /haproxy?stats
    {: .Example}

    </div>

    Note that some of the parameters may need tuning per the sizing and
    workload nature:

    * <span class="PlainFont">The `maxconnections` parameter indicates how many concurrent
      connections are served at any given time; you may need to
      configure this, based on size of the cluster and expected inbound
      requests.</span>
    * <span class="PlainFont">Similarly, the `timeout` values, which are by default in msecs,
      should be tuned so that the connection does not get terminated
      while a long-running query is executed.</span>

3.  Start the HAProxy service:
    {: .topLevel}

    As superuser, follow these steps to enable the HAProxy service:

    <table>
                            <col />
                            <col />
                            <thead>
                                <tr>
                                    <th>Distribution</th>
                                    <th>Instructions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="ConsoleLink">Redhat / CentOS EL6</td>
                                    <td>
                                        <div class="preWrapperWide"><pre class="ShellCommandCell"># chkconfig haproxy on
    # service haproxy start
    </pre>
                                        </div>
                                        <p>If you change the configuaration file, reload it with this command:</p>
                                        <div class="preWrapperWide"><pre class="ShellCommandCell"># service haproxy reload</pre>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="ConsoleLink">Redhat / CentOS EL7</td>
                                    <td>
                                        <div class="preWrapperWide"><pre class="ShellCommandCell"># systemctl enable haproxy<br />ln -s '/usr/lib/systemd/system/haproxy.service<br />'/etc/systemd/system/multi-user.target.wants/haproxy.service'<br /># systemctl start haproxy</pre>
                                        </div>
                                        <p>If you change the configuaration file, reload it with this command:</p>
                                        <div class="preWrapperWide"><pre class="ShellCommandCell"># systemctl haproxy reload</pre>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>

    You can find the HAProxy process id in: `/var/run/haproxy.pid`. If
    you encounter any issues starting the service, check if Selinux is
    enabled; you may want to disable it initially.
    {: .noteNote}

4.  Connect:
    {: .topLevel}

    You can now connect JDBC clients, including the Splice Machine
    command line interpreter, sqlshell.sh. Use the following JDBC URL:

    <div class="preWrapperWide" markdown="1">
        jdbc:splice://<haproxy_host>:1527/splicedb;user=splice;password=admin
    {: .Plain}

    </div>

    For ODBC clients to connect through HAProxy, ensure that the DSN
    entry in file `.odbc.ini` is pointing to the HAProxy host.

5.  Verify that inbound requests are being routed correctly:
    {: .topLevel}

    You can check the logs at `/var/log/haproxy.log` to make sure that
    inbound requests are being routed to Splice Machine region servers
    that are receiving inbound requests on port 1527.

6.  View traffic statistics:
    {: .topLevel}

    If you have enabled HAProxy stats, as in our example, you can view
    the overall traffic statistics in browser at:

    <div class="preWrapperWide" markdown="1">
        http://<haproxy_host>:1936/haproxy?stats
    {: .Plain}

    </div>

    You'll see a report that looks similar to this:

    ![HAProxy statistics](images/haproxystats.png "HAProxy statistics
    screenshot"){: .indentedTightSpacing}
{: .boldFont}

</div>
## Using HAProxy with Splice Machine on a Kerberos-Enabled Cluster   {#Using}

Your JDBC applications can authenticate to the backend region server
through HAProxy on a Splice Machine cluster that has Kerberos enabled,

You can enable Kerberos mode on a CDH5.8.x cluster using the
configuration wizard described here:

<div class="preWrapperWide" markdown="1">
    https://www.cloudera.com/documentation/enterprise/5-8-x/topics/cm_sg_intro_kerb.html.
{: .Plain}

</div>
As a Kerberos pre-requisite for Splice Machines JDBC access:

* Database users must be added in the Kerberos realm as principals
* Keytab entries must be generated and deployed to the remote clients on
  which the JDBC applications are going to connect.

HAProxy will then transparently forward the connections to the back-end
cluster in Kerberos setup.

### Example

This example assumes that you are using the default user name `splice`.
Follow these steps to connect through HAProxy:

<div class="opsStepsList" markdown="1">
1.  Create the principal in Kerberos Key Distribution Center
    {: .topLevel}

    Create the principal splice@kerberos_realm_name in Kerberos Key
    Distribution Center (KDC). This generates a keytab file named
    `splice.keytab`.
    {: .indentLevel1}

2.  Copy the generated keytab file
    {: .topLevel}

    Copy the `splice.keytab` file that to all client systems.
    {: .indentLevel1}

3.  Connect:
    {: .topLevel}

    You can now connect to the Kerberos-enabled Splice Machine cluster
    through HAProxy, using the following URL:

    <div class="preWrapperWide" markdown="1">
        jdbc:splice://<haproxy_host>:1527/splicedb;principal=splice@<realm_name>;keytab=/<path>/splice.keytab
    {: .Plain}

    </div>
{: .boldFont}

</div>
Use the same steps to allow other Splice Machine users to connect by
adding them to the Kerberos realm and copying the keytab files to their
client systems. This example sets up access for a new user name `jdoe`.

<div class="opsStepsList" markdown="1">
1.  Create the user in your Splice Machine database:
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">
        call syscs_util.syscs_create_user( 'jdoe', 'jdoe' );
    {: .Example}

    </div>

2.  Grant privileges to the user
    {: .topLevel}

    For this example, we are granting all privileges on a table named
    `myTable` to the new user:
    {: .indentLevel1}

    <div class="preWrapperWide" markdown="1">
        grant all privileges on splice.myTable to jdoe;
    {: .Example}

    </div>

3.  Use KDC to create a new principal and generate a keytab file. For
    example:
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">
        # kadmin.local addprinc -randkey jdoe@SPLICEMACHINE.COLO
    {: .Example}

    </div>

4.  Set the password for the new principal:
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">
        # kadmin.local cpw jdoeEnter password for principal "jdoe@SPLICEMACHINE.COLO":
    {: .ShellCommand}

    </div>

5.  Create keytab file jdoe.keytab
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">
        # kadmin: xst -k jdoe.keytab jdoe@SPLICEMACHINE.COLO
    {: .ShellCommand}

    </div>

6.  Copy the generated keytab file to the client system
    {: .topLevel}

7.  Connect through HAProxy with the following URL:
    {: .topLevel}

    <div class="preWrapperWide" markdown="1">
        jdbc:splice://ha-proxy-host:1527/splicedb;principal=user1@SPLICEMACHINE.COLO;keytab=/home/splice/user1.keytab
    {: .Plain}

    </div>
{: .boldFont}

</div>
</div>
</section>
