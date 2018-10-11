You can specify the following Native Spark DataSource JDBC connection string options for running queries internally:
<table>
    <thead>
        <tr>
            <th>Option</th>
            <th>Default Value</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont">internal</td>
            <td class="CodeFont">false</td>
            <td>A string with value <code>true</code> or <code>false</code>, which indicates whether or not to run queries internally by default.</td>
        </tr>
        <tr>
            <td class="CodeFont">tmp</td>
            <td class="CodeFont">/tmp</td>
            <td><p>The path to the temporary directory that you want to use when persisting temporary data from internally executed queries.</p>
                <p class="noteIcon">The user running a query <strong>must have write permission</strong> on this directory, or your connected application may freeze or fail.</p>
            </td>
        </tr>
    </tbody>
</table>

Here's an example of a JDBC URL that specifies internal access for a Spark application, and also specifies a non-default directory in which the adapter can persist data:
```
jdbc:splice://myhost:1527/splicedb;user=myUserName;password=myPswd;internal=true;tmp=/tmp/mytempdir
```
{: .Example}
