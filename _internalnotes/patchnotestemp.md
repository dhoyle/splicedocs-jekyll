## 2.6.1.1807 Patch Release  11-Mar-18  {#xxxxxxPatch1807}
<table>
    <col width="125px" />
    <col />
    <thead>
        <tr>
            <th>JIRA-ID</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>DB-5914</td>
            <td>Fix inconsistent selectivity with predicate order change</td>
        </tr>
        <tr>
            <td>DB-6146</td>
            <td>Delete region</td>
        </tr>
        <tr>
            <td>DB-6194</td>
            <td>Add system procedure to enable/disable all column statistics</td>
        </tr>
        <tr>
            <td>DB-6202</td>
            <td>Backup - read metadata more efficiently</td>
        </tr>
        <tr>
            <td>DB-6262</td>
            <td>Improve failure handling during initialization</td>
        </tr>
        <tr>
            <td>DB-6277</td>
            <td>Clean up incremental changes from offline regions that were offline before full backup.</td>
        </tr>
        <tr>
            <td>DB-6284</td>
            <td>Ignore txn started after backup</td>
        </tr>
        <tr>
            <td>DB-6295</td>
            <td>Add maximum concurrent compactions parameter</td>
        </tr>
        <tr>
            <td>DB-6332</td>
            <td>Flatten non-correlated aggregate subquery in where clause</td>
        </tr>
        <tr>
            <td>DB-6342</td>
            <td>Disable test for mem profile. Monitor/kill running operations for all nodes</td>
        </tr>
        <tr>
            <td>DB-6343</td>
            <td>Handle CannotCommit exception correctly</td>
        </tr>
        <tr>
            <td>DB-6345</td>
            <td>Fix query failure with non-covering index as right table of a…(2.6.1)</td>
        </tr>
        <tr>
            <td>DB-6399</td>
            <td>Broadcast Kerberos tokens to executors instead of keytabs. Fix build in splice_spark</td>
        </tr>
        <tr>
            <td>DB-6408</td>
            <td>Add more logging for trouble shooting. use nested connection for backup</td>
        </tr>
        <tr>
            <td>DB-6409</td>
            <td>Terminate backup timely if it has been cancelled</td>
        </tr>
        <tr>
            <td>DB-6410</td>
            <td>Prepend schemaname to columns in PK conditions in update statement genereated by MERGE_DATA_FROM_FILE</td>
        </tr>
        <tr>
            <td>DB-6411</td>
            <td>Make UpdateFromSubqueryIT sequential to avoid concurrent update on the same table and lead to non-deterministic result</td>
        </tr>
        <tr>
            <td>DB-6412</td>
            <td>Bound the outer join row count by the left outer table's row count (2.6.1)</td>
        </tr>
        <tr>
            <td>DB-6416</td>
            <td>Parameter sanity check for region operations</td>
        </tr>
        <tr>
            <td>DB-6418</td>
            <td>Avoid backup timeout</td>
        </tr>
        <tr>
            <td>DB-6428</td>
            <td>Adjust selectivity estimation by excluding skewed default values</td>
        </tr>
        <tr>
            <td>DB-6438</td>
            <td>Populate default value for column of DATE type in defaultRow with the right type (regression fix for SPLICE-1700)</td>
        </tr>
        <tr>
            <td>DB-6440</td>
            <td>Reduce lengthy lineage of transformation for MultiProbeTableScan operation</td>
        </tr>
        <tr>
            <td>DB-6453</td>
            <td>Avoid sort for outer join when applicable</td>
        </tr>
        <tr>
            <td>DB-6456</td>
            <td>Add missing getEncodedName() method</td>
        </tr>
        <tr>
            <td>DB-6463</td>
            <td>Add JDBC timeout support</td>
        </tr>
        <tr>
            <td>DB-6464</td>
            <td>Set isOpen to true for an operation for Spark execution</td>
        </tr>
        <tr>
            <td>DB-6476</td>
            <td>Forward port spark decoupling changes to branch-2.6</td>
        </tr>
        <tr>
            <td>DB-6478</td>
            <td>Fix error in IT test case and ignored it in MEM mode</td>
        </tr>
        <tr>
            <td>DB-6478</td>
            <td>Fix IT error in SpliceAdmin_OperationsIT.testRunningOperation_DB6478()</td>
        </tr>
        <tr>
            <td>DB-6484</td>
            <td>Exclude metrics jar for CDH</td>
        </tr>
        <tr>
            <td>DB-6511</td>
            <td>Fixed Discrepancy between internal and external Nexus repos.</td>
        </tr>
        <tr>
            <td>DB-6516</td>
            <td>Disable dependency manager for spark</td>
        </tr>
        <tr>
            <td>DB-6517</td>
            <td>Get keytab file name correctly</td>
        </tr>
        <tr>
            <td>DB-6523</td>
            <td>Add hint useDefaultRowCount and defaultSelectivityFactor, als…(2.6.1)</td>
        </tr>
        <tr>
            <td>DB-6534</td>
            <td>Increase timeout for mem platform</td>
        </tr>
        <tr>
            <td>DB-6537</td>
            <td>Fix upsert index</td>
        </tr>
        <tr>
            <td>DB-6543</td>
            <td>Vacuum disabled table</td>
        </tr>
        <tr>
            <td>DB-6558</td>
            <td>Cache more database properties</td>
        </tr>
        <tr>
            <td>DB-6569</td>
            <td>Restore from s3 regression</td>
        </tr>
        <tr>
            <td>DB-6574</td>
            <td>Retry write workload on host unreachable exceptions</td>
        </tr>
        <tr>
            <td>DB-6582</td>
            <td>Remove SparkListener for export</td>
        </tr>
        <tr>
            <td>DB-6594</td>
            <td>Fix illegal merge join</td>
        </tr>
        <tr>
            <td>DB-6603</td>
            <td>Incremental restore: set timestamp from latest incremental backup</td>
        </tr>
        <tr>
            <td>DB-6610</td>
            <td>Log warning messages if backup is corrupted</td>
        </tr>
        <tr>
            <td>SPLICE-1717</td>
            <td>Asynchronous transaction resolution in compactions</td>
        </tr>
        <tr>
            <td>SPLICE-175</td>
            <td>External Olap server</td>
        </tr>
        <tr>
            <td>SPLICE-1870</td>
            <td>Fix update through index lookup path (2.6.1)</td>
        </tr>
        <tr>
            <td>SPLICE-1888</td>
            <td>[External Table]: NPE appear while trying to read NUMERIC</td>
        </tr>
        <tr>
            <td>SPLICE-1899</td>
            <td>Failed to re-create empty external table with the same parameters after it was dropped.</td>
        </tr>
        <tr>
            <td>SPLICE-1900</td>
            <td>Incorrect error message while reading data from Empty external table of AVRO file format.</td>
        </tr>
        <tr>
            <td>SPLICE-1901</td>
            <td>Failed to run select query from partitioned Parquet external table</td>
        </tr>
        <tr>
            <td>SPLICE-1905</td>
            <td>Failed to run select query from partitioned external table</td>
        </tr>
        <tr>
            <td>SPLICE-1920</td>
            <td>Procedure to delete rows from dictionary tables</td>
        </tr>
        <tr>
            <td>SPLICE-1927</td>
            <td>Amend pattern string for detecting splice machine ready to accept connections</td>
        </tr>
        <tr>
            <td>SPLICE-1970</td>
            <td>Exclude metrics jars from splice-uber jar to avoid class</td>
        </tr>
        <tr>
            <td>SPLICE-1971</td>
            <td>Wrap SqlException into StandardException</td>
        </tr>
        <tr>
            <td>SPLICE-1973</td>
            <td>Exclude Kafka jars from splice-uber.jar for all platforms</td>
        </tr>
        <tr>
            <td>SPLICE-1974</td>
            <td>Splice derby timestamp format not compliant with Hadoop</td>
        </tr>
        <tr>
            <td>SPLICE-1975</td>
            <td>Allow JavaRDD<Row> to be passed for CRUD operations in SplicemachineContext</td>
        </tr>
        <tr>
            <td>SPLICE-1976</td>
            <td>Fix OlapClientTest failures in Jenkins</td>
        </tr>
        <tr>
            <td>SPLICE-1978</td>
            <td>Add null check to GET_RUNNING_OPERATIONS</td>
        </tr>
        <tr>
            <td>SPLICE-1983</td>
            <td>OOM in Spark executors while running TPCH1 repeatedly</td>
        </tr>
        <tr>
            <td>SPLICE-1984</td>
            <td>Parallelizes MultiProbeTableScan and Union Operatons.  Customers with large number of in list elements or with numerous real-time union operations should see a reduction in execution time</td>
        </tr>
        <tr>
            <td>SPLICE-1987</td>
            <td>Add fully qualified table name into HBASE "TableDisplayName" Attribute</td>
        </tr>
        <tr>
            <td>SPLICE-1991</td>
            <td>Add info to Spark UI for Compaction jobs to indicate presence of Reference Files</td>
        </tr>
        <tr>
            <td>SPLICE-1995</td>
            <td>Correct imported rows</td>
        </tr>
        <tr>
            <td>SPLICE-2000</td>
            <td>Modify log4j layout value from PatternLayout to EnhancedPatternLayout (2.6.1)</td>
        </tr>
        <tr>
            <td>SPLICE-2004</td>
            <td>Fix inconsistency between plan logged in log and that in the explain</td>
        </tr>
        <tr>
            <td>SPLICE-2008</td>
            <td>Resolve transactions during flushes</td>
        </tr>
        <tr>
            <td>SPLICE-2012</td>
            <td>HMaster doesn't exit after shutdown</td>
        </tr>
        <tr>
            <td>SPLICE-2022</td>
            <td>Improve the spark job description for compaction</td>
        </tr>
        <tr>
            <td>SPLICE-2032</td>
            <td>Reenable OlapServerIT and increase robustness</td>
        </tr>
        <tr>
            <td>SPLICE-2062</td>
            <td>Set standalone yarn user to logged in user</td>
        </tr>
        <tr>
            <td>SPLICE-2062</td>
            <td>Set yarn user without affecting Spark</td>
        </tr>
        <tr>
            <td>SPLICE-2066</td>
            <td>Duplicate create connection in Splicemachinecontext</td>
        </tr>
    </tbody>
</table>
