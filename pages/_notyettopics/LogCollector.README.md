
## Description

Log collector: collect logs in a time range related to Splice on a cluster. Specifically, it will collect these logs:

1. Zookeeper
2. YARN resource manager
3. YARN application logs related to Splice: Spark jobs related to Splice and OLAP server (optional)
4. HBase master and region server logs (which includes Splice logs)
5. Splice derby logs.
6. GC logs for Splice.


## Usage

Run `./collect-splice-logs.sh` to see the options. This is an example:

```
./collect-splice-logs.sh -s "2018-07-06 00:00:00" -e "2018-07-07 00:00:00" -u splice -d /home/splice/splice-log-dump  -c
```

This will collect all the logs between 2018-07-06 to 2018-07-07.

### Redirect Outputs to File for Debug

The log configurations may different for customers. So it is a good idea to run this script and redirect all the output to a file in order to debug if the script fails. For example:

```
bash +x ./collect-splice-logs.sh -s "2018-07-06 00:00:00" -e "2018-07-07 00:00:00" -u splice -d /home/splice/splice-log-dump  -c &> log.txt
```

`bash +x` here will print every commands in the script when it runs.

### Use with Kerberos

If you are using on a kerberized cluster, you must `kinit yarn` first in order to run yarn related commands.

### Collect Yarn Application Logs

In order to collect yarn application logs (with `-c` option), the user you specify must have permission to run `sudo`. This is because yarn applications are submitted by other users (`hbase` in our case) and normal user will not have permission to read these.

### Customize Based on Your Logs

This script makes some assumption about log locations and log formats. If you have log files other than the default configuration, you may need to customize it in the script `collect-splice-logs.sh`.

There are some variables can be configured in the script:

1. `*_time_regex`: these variables specify how to match the time for a single line in a log file. For example, `^(.{19})(.*)` will match the first 19 chars in a line as the time.
2. `*_time_format`: these variables specify what is the time format.
3. `*_logs`: these variables specify where are the log files. `yarn_container_dir` specifies where is the yarn application log directory.
