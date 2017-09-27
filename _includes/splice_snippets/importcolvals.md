<div markdown="1">
## Inserting and Updating Column Values When Importing Data   {#ImportColVals}

This section summarizes what happens when you are importing, upserting,
or merging records into a database table, based on:

* Whether you are importing a new record or updating an existing record.
* If the column is specified in your `insertColumnList` parameter.
* If the table column is a generated value or has a default value.

The important difference in actions taken when importing data occurs
when you are updating an existing record with the UPSERT or MERGE and
your column list does not contain the name of a table column:

* For newly inserted records, the default or auto-generated value is
  always inserted, as usual.
* If you are updating an existing record in the table with `UPSERT`, the
  default auto-generated value in that record is overwritten with a new
  value.
* If you are updating an existing record in the table with `MERGE`, the
  column value is not updated.

### Importing a New Record Into a Database Table

The following table shows the actions taken when you are importing new
records into a table in your database. These actions are the same for
all three importation procedures (IMPORTing, UPSERTing, or MERGEing):

<table>
            <col />
            <col />
            <col />
            <thead>
                <tr>
                    <th>Column included in <code>importColumnList</code>?</th>
                    <th>Table column conditions</th>
                    <th>Action Taken</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>YES</td>
                    <td>N/A</td>
                    <td>Import value inserted into table column if valid; if not valid, a bad record error is logged.</td>
                </tr>
                <tr>
                    <td rowspan="3">NO</td>
                    <td>Has Default Value</td>
                    <td>Default value is inserted into table column.</td>
                </tr>
                <tr>
                    <td>Is Generated Value</td>
                    <td>Generated value is inserted into table column.</td>
                </tr>
                <tr>
                    <td>None</td>
                    <td>NULL is inserted into table column.</td>
                </tr>
            </tbody>
        </table>

The table below shows what happens with default and generated column
values when adding new records to a table using one of our import
procedures; we use an example database table created with this
statement:

    CREATE TABLE myTable (   colA INT,   colB CHAR(12) DEFAULT 'myDefaultVal',   colC INT);
{: .Example}

<table summary="Detailed example of what gets imported for different input values in a new record">
            <col />
            <col />
            <col />
            <col />
            <thead>
                <tr>
                    <th><span class="CodeBoldFont">insertColumnList</span>
                    </th>
                    <th>Values in import record</th>
                    <th>Values inserted into database</th>
                    <th>Notes</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><code>"colA,colB,colC"</code></td>
                    <td><code>1,,2</code></td>
                    <td><code>[1,NULL,2]</code></td>
                    <td> </td>
                </tr>
                <tr>
                    <td><code>"colA,colB,colC"</code></td>
                    <td><code>3,de,4</code></td>
                    <td><code>[3,de,4]</code></td>
                    <td> </td>
                </tr>
                <tr>
                    <td><code>"colA,colB,colC"</code></td>
                    <td><code>1,2,</code></td>
                    <td><code>Error: column B wrong type</code></td>
                    <td> </td>
                </tr>
                <tr>
                    <td><code>"colA,colB,colC"</code></td>
                    <td><code>1,DEFAULT,2</code></td>
                    <td><code>[1,"DEFAULT",2]</code></td>
                    <td><code>DEFAULT</code> is imported as a literal value</td>
                </tr>
                <tr>
                    <td><code>Empty</code></td>
                    <td><code>1,,2</code></td>
                    <td><code>[1,myDefaultVal,2]</code></td>
                    <td> </td>
                </tr>
                <tr>
                    <td><code>Empty</code></td>
                    <td><code>3,de,4</code></td>
                    <td><code>[3,de,4]</code></td>
                    <td> </td>
                </tr>
                <tr>
                    <td><code>Empty</code></td>
                    <td><code>1,2,</code></td>
                    <td><code>Error: column B wrong type</code></td>
                    <td> </td>
                </tr>
                <tr>
                    <td><code>"colA,colC"</code></td>
                    <td><code>1,2</code></td>
                    <td><code>[1,myDefaultVal,2]</code></td>
                    <td> </td>
                </tr>
                <tr>
                    <td><code>"colA,colC"</code></td>
                    <td><code>3,4</code></td>
                    <td><code>[3,myDefaultVal,4]</code></td>
                    <td> </td>
                </tr>
            </tbody>
        </table>

Note that the value \`DEFAULT\` in the imported file **is not
interpreted** to mean that the default value should be applied to that
column; instead:

* If the target column in your database has a string data type, such as
  `CHAR` or `VARCHAR`, the literal value `"DEFAULT"` is inserted into
  your database..
* If the target column is not a string data type, an error will occur.

#### Importing New Records That Contain Generated or Default Values

When you export a table with generated columns to a file, the actual
column values are exported, so importing that same file into a different
database will accurately replicate the original table values.

If you are importing previously exported records into a table with a
generated column, and you want to import some records with actual values
and apply generated or default values to other records, you need to
split your import file into two files and import each:

* Import the file containing records with non-default values with the
  column name included in the `insertColumnList`.
* Import the file containing records with default values with the column
  name excluded from the `insertColumnList`.

### Updating a Table Record with UPSERT

The following table shows the action taken when you are using the
`SYSCS_UTIL.UPSERT_DATA_FROM_FILE` procedure to update an existing
record in a database table:

<table>
            <col />
            <col />
            <col />
            <thead>
                <tr>
                    <th>Column included in <em>importColumnList</em>?</th>
                    <th>Table column conditions</th>
                    <th>Action Taken</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>YES</td>
                    <td>N/A</td>
                    <td>Import value updated in table column if valid; if not valid, a bad record error is logged.</td>
                </tr>
                <tr>
                    <td rowspan="3">NO</td>
                    <td>Has Default Value</td>
                    <td>Table column is overwritten with default value.</td>
                </tr>
                <tr>
                    <td>Is Generated Value</td>
                    <td>Table column is overwritten with newly generated value.</td>
                </tr>
                <tr>
                    <td>None</td>
                    <td>Table column is overwritten with NULL value.</td>
                </tr>
            </tbody>
        </table>

### Updating a Table Record with MERGE

The following table shows the action taken when you are using the
`SYSCS_UTIL.MERGE_DATA_FROM_FILE` procedure to update an existing record
in a database table:

<table>
            <col />
            <col />
            <col />
            <thead>
                <tr>
                    <th>Column included in <em>importColumnList</em>?</th>
                    <th>Table column conditions</th>
                    <th>Action Taken</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>YES</td>
                    <td>N/A</td>
                    <td>Import value updated in table column if valid; if not valid, a bad record error is logged.</td>
                </tr>
                <tr>
                    <td rowspan="3">NO</td>
                    <td>N/A</td>
                    <td>Table column is not updated.</td>
                </tr>
            </tbody>
        </table>

#### Generated Column Import Examples

Our [Importing Data](tutorials_ingest_importing.html) tutorial includes
an example that illustrates this difference. We recommend reviewing it
before upserting or merging data into a table.
</div>
