Allianz Jira Scrub

Non-flattened subqueries perform better than flattened subqueries in this case because we can leverage the correlating condition. We could cost both and choose the more efficient approach. The decision to flatten the subquery is rule-based, so this is a bigger change since we just currently cost join order, join strategy, access path. That expands the search space further, but that increases compiler time.

This is not doable in Derby as a general case. We could look for pattern and do this in an ugly, one-off way.

So not really a good idea to implement a general fix in pre-Calcite Optimizer. Even in the Calcite optimizer, it’s a plug-in rule that increases the search space and so might not be worth the additional cost in that implementation either.

One possible adaptation would be to provide a new hint at a subquery level to say “don’t flatten” or “do flatten.” That goes against the “no-hints” goal, but would be feasible for meeting performance requirements if needed. This hint could be implemented before the calcite migration.


Solution
Add the hint doNotFlatten for subquery. Correspondingly in the SubqueryNode, introduce a Boolean variable hintNotFlatten to store the hinted value. By default it is set to false.
An example to use this hint is as follows:

```
create table t1 (a1 int, b1 int, c1 int, primary key (a1));
create table t2 (a2 int, b2 int, c2 int, primary key (a2));
insert into t1 values (1,1,1), (2,2,2), (3,3,3), (4,4,4), (5,5,5);
insert into t2 select * from t1;
analyze table t1;
analyze table t2;
```
{: .Example}


 Here is the plan with doNotFlatten set to true:

explain select * from t1 where b1=1 and c1 = (select max(c2) from t2 where a1=a2 and b1=b2) --splice-properties doNotFlatten=true
;

Plan
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Cursor(n=10,rows=1,updateMode=READ_ONLY (1),engine=control)
  ->  ScrollInsensitive(n=9,totalCost=8.016,outputRows=1,outputHeapSize=12 B,partitions=1)
    ->  ProjectRestrict(n=8,totalCost=4.006,outputRows=1,outputHeapSize=12 B,partitions=1,preds=[(C1[1:3] = subq=6)])
      ->  Subquery(n=7,totalCost=12.006,outputRows=1,outputHeapSize=0 B,partitions=1,correlated=true,expression=true,invariant=true)
        ->  ProjectRestrict(n=6,totalCost=8.002,outputRows=1,outputHeapSize=0 B,partitions=1)
          ->  GroupBy(n=5,totalCost=8.002,outputRows=1,outputHeapSize=0 B,partitions=1)
            ->  ProjectRestrict(n=4,totalCost=4.001,outputRows=1,outputHeapSize=5 B,partitions=1)
              ->  TableScan[T2(1600)](n=3,totalCost=4.001,scannedRows=1,outputRows=1,outputHeapSize=5 B,partitions=1,preds=[(B1[1:2] = B2[2:2]),(A1[1:1] = A2[2:1])])
      ->  ProjectRestrict(n=2,totalCost=4.006,outputRows=1,outputHeapSize=12 B,partitions=1)
        ->  TableScan[T1(1584)](n=1,totalCost=4.006,scannedRows=5,outputRows=1,outputHeapSize=12 B,partitions=1,preds=[(B1[0:2] = 1)])

10 rows selected
As we can see, there is Subquery in the plan, indicating that the subquery is not flattened.

Below is the plan with doNotFlatten set to false, the subquery is flattened. It is the same behavior as when this hint is not provided

explain select * from t1 where b1=1 and c1 = (select max(c2) from t2 where a1=a2 and b1=b2) --splice-properties doNotFlatten=false
;
Plan
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Cursor(n=9,rows=1,updateMode=READ_ONLY (1),engine=control)
  ->  ScrollInsensitive(n=8,totalCost=18.518,outputRows=1,outputHeapSize=19 B,partitions=1)
    ->  ProjectRestrict(n=7,totalCost=12.022,outputRows=1,outputHeapSize=19 B,partitions=1)
      ->  BroadcastJoin(n=6,totalCost=12.022,outputRows=1,outputHeapSize=19 B,partitions=1,preds=[(A1[8:1] = AggFlatSub-0-1.A2[8:5]),(C1[8:3] = AggFlatSub-0-1.SQLCol1[8:4])])
        ->  ProjectRestrict(n=5,totalCost=8.011,outputRows=1,outputHeapSize=12 B,partitions=1)
          ->  GroupBy(n=4,totalCost=8.011,outputRows=1,outputHeapSize=12 B,partitions=1)
            ->  ProjectRestrict(n=3,totalCost=4.006,outputRows=1,outputHeapSize=12 B,partitions=1)
              ->  TableScan[T2(1600)](n=2,totalCost=4.006,scannedRows=5,outputRows=1,outputHeapSize=12 B,partitions=1,preds=[(AggFlatSub-0-1.B2[2:2] = 1)])
        ->  TableScan[T1(1584)](n=1,totalCost=4.006,scannedRows=5,outputRows=1,outputHeapSize=12 B,partitions=1,preds=[(B1[0:2] = 1)])

9 rows selected
