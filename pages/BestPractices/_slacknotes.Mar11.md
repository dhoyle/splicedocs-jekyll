sergio [3:42pm]
    I’m trying to improve INSERT performance on an INSERT SELECT statement. The SELECT portion runs in 30 seconds or so when using order by and {limit 100}. The INSERT portion seems to use very little CPU (aprox 6% of all CPU on a 4 executor DB service system). Can the INSERT be parallelized further? I/O doesn’t seem to be the bottleneck either:
    System utilization - the request started at about 15:30
    Pasted image at 2019-03-10, 3:43 PM

    Is this a situation where using the hint “splits” might help? I tried using it on the INSERT INTO {table} line but it didn’t have any effect, as in:
    Untitled

    INSERT INTO ModelData --splice-properties splits=12
    SELECT tn.pp_item_sk, tn.pp_month_seq,
        tn.pp_quantity label,
        tn_1.pp_listprice lagprice_1, tn_2.pp_listprice lagprice_2, tn_1.pp_listprice - tn_2.pp_listprice pricediff,
         CASE WHEN tn_2.pp_listprice>0 THEN (tn_1.pp_listprice - tn_2.pp_listprice) / tn_2.pp_listprice ELSE 1 END pricediff_pct,
    Click to expand inline (23 lines)

daniel [4:14 PM]
    @sergio the splits hint only affects table scans in Spark, it doesn't work for an insert the way you are using it. How many rows does the select generate? Is this running in control or spark? If spark how many tasks does the last stage have?

sergio [4:15 PM]
    it runs on spark, generates about 500000 rows in the current test.
    taking about 15 min to complete on a small DB-service cluster 4 OLTP 4 OLAP

gene [4:16 PM]
    @sergio where are you running this?  might be interesting to look at your SparkUI (edited)

sergio [4:16 PM]
    If I run the SELECT by itself, with an ORDER BY and LIMIT 100 it takes about 30 s
    I don’t see anything but the INSERT step running for a long time on the SparkUI (but I could just be reading it wrong). So, is this just expected for the INSERT portion or is there a way to make it better? The primary key on the insert table is the first two columns in the select pp_item_sk, pp_month_seq… both integers. (edited)

gene [4:21 PM]
    Can you point us to your instance so we can look at your SparkUI also?  If you don’t have much parallelism that could be part of the problem

sergio [4:21 PM]
    http://sergiosaccount-pricingdemo.splicemachine-dev.io:4040/jobs/

gene [4:22 PM]
    Wow I thought they were going to bring dev down over the weekend

sergio [4:22 PM]
    I asked them to hold on while I finished this. Is it urgent to do that work?
    I can always move to a prod box if there is room.

gene [4:25 PM]
    No I don’t want to mess with what you’ve got going
    OK you are getting from what I see no parallelism on the insert

sergio [4:25 PM]
    right. how can I help that?

gene [4:31 PM]
    @daniel will lowering splitBlockSize help?  He’s only getting 1 task for the 500,000 inserts

Xiao Liu [6:18 PM]
    I think the hint split and splitBlockSize both only affect table scan

gene [7:01 PM]
    I think you are right @Xiao Liu

jun [7:27 PM]
    @sergio Can you try running bulk load? You may add some hint like this
    INSERT INTO ModelData --splice-properties useSpark=true, bulkImportDirectory=/tmp
    SELECT tn.pp_item_sk, tn.pp_month_seq,
          tn.pp_quantity label,
… …

daniel [1:24 AM]
    @gene @sergio yes, you can use the splits hint, but you have to tag a table for it to work. What's the explain plan? I'm guessing you are getting all broadcast joins or nested loop joins, which don't provide parallelism. If you hint a merge sort join for one of the joins you'll get 200 tasks

sergio [6:52 AM]
    I’ll try it out.

sergio [9:22 AM]
    @daniel @jun - tried both hint options. the bulkimport hint did not have any effect, but the hint on sort merge join for the first two large joins did! It ran in 1min 22 sec (including the ANALYZE) as opposed to 15 min in the previous run. Thanks!

gene [10:15 AM]
    great! - how many parallel tasks were generated?

gene [10:19 AM]
    @sergio nevermind I see your Spark UI - I think if the Spark Executors would have been hot it would have run faster still

sergio [10:53 AM]
    @gene, yes a second run (i.e. hot executors) runs in 51 sec with the insert only taking 27s and using 403 tasks.d
