
You can configure _log4j_ to prevent sensitive information such as passwords and credit card information from being logged in log messages. You configure this HBase setting here:

<table>
    <col />
    <col />
    <thead>
        <tr>
            <th>Platform</th>
            <th>Configuration Option</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Cloudera</td>
            <td class="CodeFont">Logging Advanced Configuration Snippet (Safety Valve)</td>
        </tr>
        <tr>
            <td>Hortonworks</td>
            <td class="CodeFont">Advanced hbase-log4j</td>
        </tr>
    </tbody>
</table>

To mask sensitive information, you:

* Use the `com.splicemachine.utils.logging.MaskPatternLayout` log4j layout pattern.
* Specify a regular expression in `MaskPattern` that matches the part of log messages you want matched; the regular expression is parsed using the Java built-in regex parse.

When logging with this layout, log4j will replace any text that matches the filter with this text:

```
_MASKED SENSITIVE INFO_
```
{: .Example}

For example:
```
log4j.appender.spliceDerby.layout=com.splicemachine.utils.logging.MaskPatternLayout
log4j.appender.spliceDerby.layout.ConversionPattern=%d{ISO8601}Thread[%t%m%n
log4j.appender.spliceDerby.layout.MaskPattern=insert (?:.*) ([0-9]+),([0-9]+)
```
{: .Example}

Given that layout, the following statement:

```
splice> INSERT INTO a VALUES 123,234;
```
{: .Example}

will be logged as:

```
INSERT INTO a VALUES MASKED SENSITIVE INFO, MASKED SENSITIVE INFO
```
{: .Example}
