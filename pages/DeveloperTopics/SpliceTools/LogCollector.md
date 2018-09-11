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
    <col />
    <col />
    <thead>
        <tr>
            <th>Option</th>
            <th>Description</th>
            <th>Example</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>-s</td>
            <td>Specifies the starting date/time for the log collection.</td>
            <td>2018-07-06 00:00:00</td>
        </tr>
        <tr>
            <td>-e</td>
            <td>Specifies the ending date/time for the log collection</td>
            <td>2018-07-07 00:00:00</td>
        </tr>
        <tr>
            <td>-u</td>
            <td>The user name **** Need Info Here ****</td>
            <td>splice</td>
       </tr>
        <tr>
            <td>-d</td>
            <td>The directory in which to store the output ****????**** </td>
            <td>/home/splice/splice-log-dump</td>
        </tr>
        <tr>
            <td>-c</td>
            <td><p>Include Yarn application logs in the collection process.</p>
                <p class="noteNote">You can only use this option if you have permissions to use `sudo`: Yarn applications are submitted by other users, which means that non-superusers cannot access their logs.</p>
            </td>
            <td>-c</td>
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

## Customizing the Script
You can customize the `collect-splice-logs.sh` script

### Customize Based on Your Logs

This script makes some assumption about log locations and log formats. If you have log files other than the default configuration, you may need to customize it in the script `collect-splice-logs.sh`.

There are some variables can be configured in the script:

1. `*_time_regex`: these variables specify how to match the time for a single line in a log file. For example, `^(.{19})(.*)` will match the first 19 chars in a line as the time.
2. `*_time_format`: these variables specify what is the time format.
3. `*_logs`: these variables specify where are the log files. `yarn_container_dir` specifies where is the yarn application log directory.
</div>
</section>
