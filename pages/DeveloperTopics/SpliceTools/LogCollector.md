---
title: The Splice Machine Log Collector Tool
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
The *Splice Machine Log Collector* tool collects logging information related to Splice Machine from your cluster, including logs from:

* ZooKeeper
* The Yarn resource manager
* The Yarn application logs (optional)
* HBase master and region server logs, including Splice Machine logs
* The Splice Machine Derby logs
* Garbage collection logs for Splice Machine

## Usage

You can invoke the *log collector* in your terminal window, by navigating to your `splicemachine` directory, and then issuing this command:
```
./collect-splice-logs.sh <options>
```
{: .ShellCommand}

Here are the command line options:

<table>
    <col width="25%" />
    <col width="45%" />
    <col width="30%" />
    <thead>
        <tr>
            <th>Option</th>
            <th>Description</th>
            <th>Example</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont">-s &lt;timestamp&gt;</td>
            <td>Specifies the starting date/time for the log collection.</td>
            <td class="CodeFont">2018-07-06 00:00:00</td>
        </tr>
        <tr>
            <td class="CodeFont">-e &lt;timestamp&gt;</td>
            <td>Specifies the ending date/time for the log collection</td>
            <td class="CodeFont">2018-07-07 00:00:00</td>
        </tr>
        <tr>
            <td class="CodeFont">-u &lt;userId&gt;</td>
            <td>The user name XXXXXXXXXXX NEED INFO HERE XXXXXXXXXXXXX</td>
            <td class="CodeFont">splice</td>
       </tr>
        <tr>
            <td class="CodeFont">-d &lt;directoryName&gt;</td>
            <td>The directory in which to store the output XXXXXXXXXXX NEED INFO HERE XXXXXXXXXXXXX </td>
            <td class="CodeFont">/home/splice/splice-log-dump</td>
        </tr>
        <tr>
            <td class="CodeFont">-c</td>
            <td><p>Include Yarn application logs in the collection process.</p>
                <p class="noteNote">You can only use this option if you have permissions to use <code>sudo</code>: Yarn applications are submitted by other users, which means that non-superusers cannot access their logs.</p>
            </td>
            <td class="CodeFont">-c</td>
        </tr>
    </tbody>
</table>

For example, this command collects all logs available from between midnight 2018-07-06 and midnight 2018-07-07:

```
./collect-splice-logs.sh -s "2018-07-06 00:00:00" -e "2018-07-07 00:00:00" -u splice -d /home/splice/splice-log-dump  -c
```
{: .ShellCommand}

### Using *Log Collector* with Kerberos
If you are using the *log collector* on a kerberized cluster and collecting Yarn logs, you must issue the following command before running the collector:

```
kinit yarn
```
{: .ShellCommand}

### Redirecting Output

Here's an example of saving the *log collector* output to a text file:

```
./collect-splice-logs.sh -s "2018-07-06 00:00:00" -e "2018-07-07 00:00:00" -u splice -d /home/splice/splice-log-dump  -c &> log.txt
```
{: .ShellCommand}

## Customizing the Log Collector Script
You can customize the `collect-splice-logs.sh` script by modifying some of its script variables:

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
            <td><p>This set of variables specify the number of characters used to match time values for each line in a log file.</p>
                <p>For example, <span class="Example">^(.{19})(.*)</span> will use the first 19 chars in each line as the time value to compare to your specified time range.</p>
            </td>
        </tr>
        <tr>
            <td class="CodeFont">*_time_format</td>
            <td>This set of variables specify the format of time values.</td>
        </tr>
        <tr>
            <td class="CodeFont">*_logs</td>
            <td><p>This set of variables specify the locations of log files</p>
                <p>The <code>yarn-container-dir</code> variable specifies the location of the yarn application log directory.</p>
            </td>
        </tr>
    </tbody>
</table>
</div>
</section>
