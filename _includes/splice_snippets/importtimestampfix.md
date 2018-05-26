The Splice Machine `Timestamp` data type has a range of `1677-09-21 00:12:43.147 GMT` to `2262-04-11 23:47:16.853 GMT`. If you import data that falls outside these ranges (some customers have used dummy timestamp values like `9999-01-01` in their data), your import will fail because the value is out of range for a timestamp. We have a very simple workaround for this:

This is not an issue with `Date` values.
{: .noteNote}

You can work around this issue by telling Splice Machine to convert any out-of-range timestamp values that you're importing to in-range timestamp values. To do so, follow these steps:

1. Set the `derby.database.convertOutOfRangeTimeStamps` value to `true` as follows:
   ````
       CALL SYSCS_UTIL.SYSCS_SET_GLOBAL_DATABASE_PROPERTY('derby.database.convertOutOfRangeTimeStamps', 'true');
   ````

2. Clear the Splice Machine compiled statement cache as follows:
   ````
       CALL SYSCS_UTIL.SYSCS_EMPTY_STATEMENT_CACHE();
   ````

3. Import your data.

Once you've set the property and cleared the cache, when you import data into Splice Machine, any timestamp value in the imported data that is less than the minimum value (`1677-09-21 00:12:43.147 GMT`) is converted to that minimum value, and any timestamp value greater than the maximum value (`2262-04-11 23:47:16.853 GMT`) is converted to that maximum value.
