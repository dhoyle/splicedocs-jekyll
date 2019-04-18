---
title: Connecting to Splice Machine Through HAProxy
summary: How to connect to Splice Machine through HAProxy
keywords: haproxy, load balancing, high availability, TCP requests, http requests, client requests, kerberos
toc: false
compatible_version: 2.7
product: all
sidebar: home_sidebar
permalink: developers_fundamentals_haproxy.html
folder: DeveloperTopics/OnPremiseOnly
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

The remainder of this topic walks you through configuring HAProxy on a non-Splice Machine node that is running Red Hat Enterprise Linux.

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

    You may use a different `haproxy` package, depending on which Linux distribution you're using.
    {: .noteNote}

2.  Configure the `/etc/haproxy/haproxy.cfg` file, following the
    comments in the sample file below:
    {: .topLevel}

    In this example, we set the incoming requests to
    `haproxy_host:1527`, which uses a balancing algorithm of least
    connections to distribute among the nodes `srv127, srv128, srv129,
    `and `srv130`. This means that the incoming connection is routed to
    the region server that has the least number of connections; thus,
    the client JDBC URL should point to `<haproxy_host>:1527`.

    The example below uses the *least connections* load-balancing algorithm. There are other load balancing algorithms, such as round robin, that can also be used, depending on the nature of your desired workload distribution.
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
        jdbc:splice://<haproxy_host>:1527/splicedb;user=YourUserId;password=YourPassword
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
</div>
</section>
