To specify optional properties for your JDBC connection, `Map` those options using a `SpliceJDBCOptions` object, and then create your `SplicemachineContext` with that map. For example:

```
val options = Map(
  JDBCOptions.JDBC_URL -> "jdbc:splice://<jdbcUrlString>",
        SpliceJDBCOptions.JDBC_INTERNAL_QUERIES -> "true"
)

spliceContext  = new SplicemachineContext( options )
```
{: .Example}

A typicala JDBC URL looks like this:
```
jdbc:splice://myhost:1527/splicedb;user=myUserName;password=myPswd
```
{: .Example}


The `SpliceJDBCOptions` properties that you can currently specify are:

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
            <td class="CodeFont">JDBC_INTERNAL_QUERIES</td>
            <td class="CodeFont">false</td>
            <td>A string with value <code>true</code> or <code>false</code>, which indicates whether or not to run queries internally by default.</td>
        </tr>
        <tr>
            <td class="CodeFont">JDBC_TEMP_DIRECTORY</td>
            <td class="CodeFont">/tmp</td>
            <td><p>The path to the temporary directory that you want to use when persisting temporary data from internally executed queries.</p>
                <p class="noteIcon">The user running a query <strong>must have write permission</strong> on this directory, or your connected application may freeze or fail.</p>
            </td>
        </tr>
    </tbody>
</table>
