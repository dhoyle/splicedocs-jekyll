Best Practices Notes:  Mar 18, 2019


1.  Simplify:  Automatic splitting or Manual Splitting
    - eliminate row boundaries
    - mention in SplitTable : split keys in human-readable versus split-keys in encoded hbase format
2.  Ingest with Spark DataSource: "insert" --> "insert or upsert"
3.  Get rid of Upsert and just describe Merge in BP
4.  Bulk Import & Index:
    If you have less than 100 GB of data just import your data and build your indexes and go to town, you will be happy.

    However, if you have more than 100 gigs of data you should consider different methods to bulk import it.

    One of the first questions to ask is do you have any indexes on that table?
    If you do have indexes you need to consider whether you want to create the indexes while the table is empty or else first load the data and then create the indexes. The consideration for indexes is whether or not you’re going to be able to say something about the data before the index is created. We have a method to supply indexes with their split keys, but that can only be employed if you know something about your data. For instance if your index includes the primary key of your database then you can use the same split keys for your table and index. However if your index does share the underlying table's primary key, and you do not know the # of unique values, you might need to load the data before you can inspect the data to determine split keys for that index.

    Once you have determined if you will create indexes first or later; then you can load the data to your table.

5.  New BP section: managing extreme data cases ?
6.  If you specify skipSampling=true and don't pre-split ==> All data will be bulk imported into one region
    (pre-splitting marks the table)
7.  Statement re: compaction not needed is false
8.  Data < 100GB:  use import; if not fast enuf, use auto-split
9.  Data > 100GB:  use bulk with auto; if not, use manual split. Extra complication=index
10. First time ingest versus incremental ingest
11. If on > 10 machine cluster --> bulk
    (import won't split into 2nd region until 1st region is full, so split for parallelism )
