Bulk Import & Index:
    If you have less than 100 GB of data just import your data and build your indexes and go to town, you will be happy.

    However, if you have more than 100 gigs of data you should consider different methods to bulk import it.

    One of the first questions to ask is do you have any indexes on that table?
    If you do have indexes you need to consider whether you want to create the indexes while the table is empty or else first load the data and then create the indexes. The consideration for indexes is whether or not you’re going to be able to say something about the data before the index is created. We have a method to supply indexes with their split keys, but that can only be employed if you know something about your data. For instance if your index includes the primary key of your database then you can use the same split keys for your table and index. However if your index does share the underlying table's primary key, and you do not know the # of unique values, you might need to load the data before you can inspect the data to determine split keys for that index.

    Once you have determined if you will create indexes first or later; then you can load the data to your table.

    If you specify skipSampling=true and don't pre-split ==> All data will be bulk imported into one region
    (pre-splitting marks the table)

First time ingest versus incremental ingest
