
See the subsection below on [managing permissions](#bulkperms) for bulk loading with the Native Spark DataSource.

### Managing Permissions for Bulk Loading with the Native Spark DataSource  {#bulkperms}

Follow these steps to allow a user to bulk load from a Native Spark DataSource program:

1. Obtain a splice token
2. Launch Spark tasks to shuffle and generate HFiles.

   Save the token to the bulk import directory with the file name `_token`.

   Any files with a “_” prefix will be ignored by HBase bulk load.
   {: .noteNote}

3. Grant the `create` privilege to the user running the HBase Bulk load.

4. Use `SIObserver.preBulkLoad` to read the token from the bulk import directory and check its privileges.

   Verify that the user has the `insert` privilege, which is required for an HBase user to bulk load to a table.

5. Delete the bulk import directory, which deletes the token stored in the directory.

#### Additional Information When Using KMS-enabled HBase

If you're using bulk load with the Splice Machine Native Spark DataSource, you need to verify the following settings:

1. The bulk import directory needs to be in the encryption zone
2. The user must have `execute` permission for the root directory of encryption zone:

   * If `/hbase` is the root directory of the HBase data and encryption zones, you must set permissions on `/hbase` to at least `701`.

   * If you require `/hbase` to have permissions set to `700` for stronger security, then you should not make `/hbase` the root directory for the encryption zone. For example, you could set up your directories as follows:

     <ul class="bullet">
         <li><code>/encrypt</code> as the root directory for the encryption zone</li>
         <li><code>/encrypt/hbase</code> as the root directory for storing HBase data</li>
         <li><code>/encrypt/bulkload</code> as the bulk import directory</li>
     </ul>
