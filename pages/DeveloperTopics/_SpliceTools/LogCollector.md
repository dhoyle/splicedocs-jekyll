---
title: The Log Collector
summary:
keywords:
toc: false
product: all
sidebar: developers_sidebar
permalink: developers_splicetools_logcollector.html
folder: DeveloperTopics/SpliceTools
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

# The Splice Machine Log Collector

The *Log Collector* tool is a script that gathers logged information that is related to Splice Machine on your cluster for a specified time range from various service logs, including:
* ZooKeeper
* The YARN resource manager
* YARN application logs related to Splice Machine, including OLAP Spark jobs
* HBase Master and RegionServer logs, which include Splice Machine logging
* Splice Machine Derby logs
* Garbage Collection logs for Splice Machine

## How It Works
The *Log Collector* does the following; it:
1. Retrieves logs on each server and stores them in a temporary directory on that server.
2. Compresses the collected logs on each server into a tarball and deletes the temporary files.
3. Copies the tarball to the `splice-logs` directory on your local machine (the machine on which you ran the *Log Collector*)
2. It copies the retrieved logs from each server into the `splice-logs` directory on the machine on which you have run the *Log Collector*.

## Usage

You can run the Log Collector from the command line; assuming the `collect-splice-logs.sh` script is in your current directory, use:

```
./collect-splice-logs.sh -s <start_time> -e <end_time> -u <ssh_user> -d <tmp_output_dir> [-c]
```
{: .ShellCommand}

The following table details the command line options:

<table>
    <col width="25%" />
    <col width="65%" />
    <col width="10%" />
    <thead>
        <tr>
            <th>Option</th>
            <th>Description</th>
            <th>Required?</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont">-u ssh_user</td>
            <td><p>The user name associated with the commands issued by the *Log Collector* to create directories, access logs, and copy files.</p>
                <p>If you've specified the <code>-c</code> option to collect YARN application logs, the specified <code>ssh_user</code> must have permission to run <code>sudo</code> on the servers.</p>
            </td>
            <td>Required</td>
        </tr>
        <tr>
            <td class="CodeFont">-s start_time</td>
            <td><p>The starting date-time for collecting logs, which must be in this format:</p>
                <pre class="AppCommandCell">%Y-%m-%d %H:%M:%S</pre>
                <p>If you don't specify a <code>start_time</code>, this app displays its help and then exits.</p>
            </td>
            <td>Required</td>
        </tr>
        <tr>
            <td class="CodeFont">-e end_time</td>
            <td><p>The ending date-time for collecting logs, which must be in this format:</p>
                <pre class="AppCommandCell">%Y-%m-%d %H:%M:%S</pre>
                <p>If you don't specify a <code>start_time</code>, this app displays its help and then exits.</p>
            </td>
            <td>Required</td>
        </tr>
        <tr>
            <td class="CodeFont">-d tmp_output_dir</td>
            <td>The temporary output directory on each server in which to store the collected logs.</td>
            <td>Required</td>
        </tr>
        <tr>
            <td class="CodeFont">-c</td>
            <td><p>Include this flag to indicate that you want YARN application logs collected.</p>
                <p>Note that the <code>ssh_user</code> that you specified with the <code>-u</code> option must have permission to use <code>sudo</code> in order to collect YARN application logs: YARN applications are submitted by other users, so superuser permissions are required to read their logs.</p>
            </td>
            <td>Optional</td>
        </tr>
    </tbody>
</table>

Here's an example command line that collects 24 hours worth of logs, including  and stores them in the `splice-log-dump` directory:

```
./collect-splice-logs.sh -s "2018-12-06 00:00:00" -e "2018-12-07 00:00:00" -u someuser -d /home/splice/splice-log-dump  -c
```
{: .ShellCommand}

If you run `collect-splice-logs.sh` without all required options, the script displays its help menu and then exits.

### Modifying Script Defaults
If needed, you can modify a few default values used by the *Log Collector*, as detailed here, by editing  the `collect-splice-logs.sh` script.

The *Log Collector* parses logs on YARN nodes:
* `/var/log/hbase/hbase-*.log.out*`
* `/var/log/hbase/hbase-*.log.out*`

This script contain variables that define the log locations and formats; you can override these by modifying the variables, which are found near the top of the script:

<table>
    <col />
    <col />
    <thead>
        <tr>
            <th>Variables</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont">*_time_regex</td>
            <td><p>These variables specify the regular expression that is used to match the time for a single line in a log file. For example, <code>^(.{19})(.*)</code> will match the first 19 chars in a line as the time. The default values are as follows:</p>
                <ul class=".codeList">
                    <li>splice_time_regex=<span class="AppCommand">'^(.{19})(.*)'</span></li>
                    <li>derby_time_regex=<span class="AppCommand">'^(.{19})(.*)'</span></li>
                    <li>yarn_time_regex=<span class="AppCommand">'^(.{19})(.*)'</span></li>
                    <li>zk_time_regex=<span class="AppCommand">'^(.{19})(.*)'</span></li>
                    <li>gc_time_regex=<span class="AppCommand">'^(.{19})(.*)'</span></li>
                    <li>yarn_container_time_regex=<span class="AppCommand">'^(.{17})(.*)'</span></li>
                </ul>
             </td>
        </tr>
        <tr>
            <td class="CodeFont">*_time_format</td>
            <td><p>These variables specify the time format that is used to match the time for a single line in a log file. For information about supported time formats, see <a href="https://docs.python.org/2/library/datetime.html#strftime-and-strptime-behavior" target="_blank">https://docs.python.org/2/library/datetime.html#strftime-and-strptime-behavior</a>. The default values are as follows:</p>
                <ul class=".codeList">
                    <li>splice_time_format=<span class="AppCommand">'%Y-%m-%d %H:%M:%S'</span></li>
                    <li>derby_time_format=<span class="AppCommand">'%a %b %d %H:%M:%S'</span></li>
                    <li>yarn_time_format=<span class="AppCommand">'%Y-%m-%d %H:%M:%S'</span></li>
                    <li>zk_time_format=<span class="AppCommand">'%Y-%m-%d %H:%M:%S'</span></li>
                    <li>gc_time_format=<span class="AppCommand">'%Y-%m-%dT%H:%M:%S'</span></li>
                    <li>yarn_container_time_format=<span class="AppCommand">'%y/%m/%d %H:%M:%S'</span></li>
                </ul>
             </td>
        </tr>
        <tr>
            <td class="CodeFont">*_logs</td>
            <td><p>These variables specify the locations of the log files on the servers:</p>
                <p><code>yarn_container_dir</code> specifies where is the yarn application log directory.</p>
                <ul class=".codeList">
                    <li>splice_logs=<span class="AppCommand">'/var/log/hbase/hbase-*.log.out*'</span></li>
                    <li>derby_logs=<span class="AppCommand">'/var/log/hbase/splice-derby.log*'</span></li>
                    <li>yarn_logs=<span class="AppCommand">'/var/log/hadoop-yarn/*yarn*.log.out*'</span></li>
                    <li>zk_logs=<span class="AppCommand">'/var/log/zookeeper/zookeeper-*.log*'</span></li>
                    <li>gc_logs=<span class="AppCommand">'/var/log/hbase/gc.log-*'</span></li>
                    <li>yarn_container_dir=<span class="AppCommand">'/var/log/hadoop-yarn/container'</span></li>
                </ul>
            </td>
        </tr>
    </tbody>
</table>

### Troubleshooting
If the *Log Collector* script fails for any reason, you can rerun it, printing each executed command to a file. This will allow you to see where something might have gone wrong. For example:

```
bash +x ./collect-splice-logs.sh -s "2018-12-06 00:00:00" -e "2018-12-07 00:00:00" -u someuser -d /home/splice/splice-log-dump  -c &> log.txt
```
{: .ShellCommand}

### Use with Kerberos

If you are using on a kerberized cluster, you must `kinit yarn` first in order to run yarn related commands.

</div>
</section>
