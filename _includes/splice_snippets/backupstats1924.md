
Note that statistics are also backed up and restored as of version 2.7.0.1924 (August 5, 2019) or later of Splice Machine. This means that if you restore a backup created with 2.7.0.1924 or later and the statistics were accurate when the backup was done, you do not need to use `analyze` to generate fresh statistics for the table immediately after restoring it. If the statistics were not accurate, you can run `analyze` to refresh them.

If you've restored from a table or schema backup and aren't sure if statistics were restored, you can use the following query to determine if statistics are available, replacing `<mySchemaName>` and `<myTableName>` with the appropriate names:

```
SELECT * FROM SYSVW.SYSTABLESTATISTICS
WHERE schemaname='<mySchemaName>' and tablename='<myTableName>'
```
{: .Example}
