<table>
    <col />
    <col />
    <col />
    <col />
    <thead>
        <tr>
            <th>Category</th>
            <th>Parameter</th>
            <th>Description</th>
            <th>Example Value</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td rowspan="2" class="BoldFont">Table Info</td>
            <td class="CodeFont"><a href="bestpractices_ingest_params.html#schemaName">schemaName</a></td>
            <td>The name of the schema of the table into which to import.</td>
            <td class="CodeFont">SPLICE</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="bestpractices_ingest_params.html#tableName">tableName</a></td>
            <td>The name of the table into which to import.</td>
            <td class="CodeFont">playerTeams</td>
        </tr>
        <tr>
            <td rowspan="2" class="BoldFont">Data Location</td>
            <td class="CodeFont"><a href="bestpractices_ingest_params.html#insertColumnList">insertColumnList</a></td>
            <td>The names, in single quotes, of the columns to import. If this is <code>null</code>, all columns are imported.</td>
            <td class="CodeFont">'ID, TEAM'</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="bestpractices_ingest_params.html#fileOrDirectoryName">fileOrDirectoryName</a></td>
            <td><p>Either a single file or a directory. If this is a single file, that file is imported; if this is a directory, all of the files in that directory are imported. You can import compressed or uncompressed files.</p>
            <p class="notePlain">The <code>SYSCS_UTIL.MERGE_DATA_FROM_FILE</code> procedure only works with single files; <strong>you cannot specify a directory name</strong> when calling <code>SYSCS_UTIL.MERGE_DATA_FROM_FILE</code>.</p>
            <p>On a cluster, the files to be imported <code>MUST be on S3, HDFS (or
            MapR-FS)</code>. If you're using our Database Service product, files can only be imported from S3.</p>
            <p>See the <a href="developers_cloudconnect_configures3.html">Configuring an S3 Bucket for Splice Machine Access</a> topic for information about accessing data on S3.</p>
            </td>
            <td>
                <p class="CodeFont">/data/mydata/mytable.csv</p>
                <p class="CodeFont">'s3a://splice-benchmark-data/flat/TPCH/100/region'</p>
                <p class="NoteNote">
            </td>
        </tr>
        <tr>
            <td rowspan="7" class="BoldFont">Data Formats</td>
            <td class="CodeFont"><a href="bestpractices_ingest_params.html#oneLineRecords">oneLineRecords</a></td>
            <td>A Boolean value that specifies whether (<code>true</code>) each record in the import file is contained in one input line, or (<code>false</code>) if a record can span multiple lines.
            </td>
            <td class="CodeFont">true</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="bestpractices_ingest_params.html#charset">charset</a></td>
            <td>The character encoding of the import file. The default value is UTF-8.
            </td>
            <td class="CodeFont">null</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="bestpractices_ingest_params.html#columnDelimiter">columnDelimiter</a></td>
            <td>The character used to separate columns, Specify <code>null</code> if using the comma (<code>,</code>) character as your delimiter. </td>
            <td class="CodeFont">'|', '\t'</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="bestpractices_ingest_params.html#characterDelimiter">characterDelimiter</a></td>
            <td>The character used to delimit strings in the imported data.
            </td>
            <td class="CodeFont">'"', ''''</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="bestpractices_ingest_params.html#timestampFormat">timestampFormat</a></td>
            <td><p>The format of timestamps stored in the file. You can set this to <code>null</code> if there are no time columns in the file, or if the format of any timestamps in the file match the <code>Java.sql.Timestamp</code> default format, which is: "<em>yyyy-MM-dd HH:mm:ss</em>".</p>
            <p class="noteIcon">All of the timestamps in the file you are importing must use the same format.</p>
            </td>
            <td class="CodeFont">
                <p>'yyyy-MM-dd HH:mm:ss.SSZ'</p>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="bestpractices_ingest_params.html#dateFormat">dateFormat</a></td>
            <td>The format of datestamps stored in the file. You can set this to <code>null</code> if there are no date columns in the file, or if the format of any dates in the file match pattern: "<em>yyyy-MM-dd</em>".</td>
            <td class="CodeFont">yyyy-MM-dd</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="bestpractices_ingest_params.html#timeFormat">timeFormat</a></td>
            <td>The format of time values stored in the file. You can set this to null if there are no time columns in the file, or if the format of any times in the file match pattern: "<em>HH:mm:ss</em>".
            </td>
            <td class="CodeFont">HH:mm:ss</td>
        </tr>
        <tr>
            <td rowspan="2" class="BoldFont">Problem Logging</td>
            <td class="CodeFont"><a href="bestpractices_ingest_params.html#badRecordsAllowed">badRecordsAllowed</a></td>
            <td>The number of rejected (bad) records that are tolerated before the import fails. If this count of rejected records is reached, the import fails, and any successful record imports are rolled back. Specify 0 to indicate that no bad records are tolerated, and specify -1 to indicate that all bad records should be logged and allowed.
            </td>
            <td class="CodeFont">25</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="bestpractices_ingest_params.html#badRecordDirectory">badRecordDirectory</a></td>
            <td><p>The directory in which bad record information is logged. Splice Machine logs information to the <code>&lt;import_file_name&gt;.bad</code> file in this directory; for example, bad records in an input file named <code>foo.csv</code> would be logged to a file named <code><em>badRecordDirectory</em>/foo.csv.bad</code>.</p>
            <p>On a cluster, this directory <span class="BoldFont">MUST be on S3, HDFS (or MapR-FS)</span>. If you're using our Database Service product, files can only be imported from S3.</p>
            </td>
            <td class="CodeFont">'importErrsDir'</td>
        </tr>
        <tr>
            <td rowspan="2" class="BoldFont">Bulk HFile Import</td>
            <td class="CodeFont"><a href="bestpractices_ingest_params.html#bulkImportDirectory">bulkImportDirectory  (outputDirectory)</a></td>
            <td><p>For <code>SYSCS_UTIL.BULK_IMPORT_HFILE</code>, this is the name of the  directory into which the generated HFiles are written prior to being imported into your database.</p>
            <p>For the <code>SYSCS_UTIL.COMPUTE_SPLIT_KEY</code> procedure, where it is named <code>outputDirectory</code>, this parameter specifies the directory into which the split keys are written.</p>
            </td>
            <td class="CodeFont"><code>hdfs:///tmp/test_hfile_import/</code></td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="bestpractices_ingest_params.html#skipSampling">skipSampling</a></td>
            <td><p>The <code>skipSampling</code> parameter is a Boolean value that specifies how you want the split keys used for the bulk HFile import to be computed. Set to <code>false</code> to have <code>SYSCS_UTIL.BULK_IMPORT_HFILE</code> automatically determine splits for you.</p>
            <p>This parameter is only used with the <code>SYSCS_UTIL.BULK_IMPORT_HFILE</code> system procedure.</p>
            </td>
            <td class="CodeFont">false</td>
        </tr>
    </tbody>
</table>
