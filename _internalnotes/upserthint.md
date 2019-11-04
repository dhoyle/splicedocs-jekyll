I think our upsert hint supports a special case of what the Postgres syntax covers.

That is, the target table has to have PK.  The behavior is :
1) if the source row contains a PK value that exists in the target table, then update the existing row using the source row;
2) if the source row contains a PK value that does not exist in the target table, then insert the source row.

For example:

```
create table t1 (a1 int, b1 int, c1 int, primary key(a1));
insert into t1 values (1,1,1), (2,2,2), (3,3,3), (4,4,4), (5,5,5), (6,6,6);

create table t2 (a2 int, b2 int, c2 int);
insert into t2 values (1,10,10), (2,20,20), (10,10,10);

splice> select * from t1;
A1         |B1         |C1
-----------------------------------
1          |1          |1
2          |2          |2
3          |3          |3
4          |4          |4
5          |5          |5
6          |6          |6

6 rows selected


insert into t1(a1, b1) --splice-properties insertMode=UPSERT
select a2, b2 from t2;

3 rows inserted/updated/deleted

select * from t1;
A1         |B1         |C1
-----------------------------------
1          |10         |1  <== updated row based on the PK value A1
2          |20         |2  <== updated row based on the PK value A1
3          |3          |3
4          |4          |4
5          |5          |5
6          |6          |6
10         |10         |NULL   <== inserted row

7 rows selected
```

I think the query:

```
insert into t1(a1, b1) --splice-properties insertMode=UPSERT
select a2, b2 from t2;
```

would be equivalent to Postgres's query:

```
insert into t1 (a1, b1)
select a2, b2 from t2
on conflict (a1)
do update
   set b1=EXCLUDED.b1;
```

Looking at Postgres's syntax, it is more general, for example, Postgres can support "on conflict on a unique index", but in our upsert statement, it has to be PK.
Another restriction of splicemachine upsert is that the target table cannot have auto-generated columns. If it has, the auto-generated column won't be updated correctly.
In that case, we have to use two statements(insert for PK not exists, and update for PK exists) to achieve the upsert effect. In fact, these two statements(insert for PK not exists, and update for PK exists) are actually what the system procedure merge_data_from_file does underneath.
