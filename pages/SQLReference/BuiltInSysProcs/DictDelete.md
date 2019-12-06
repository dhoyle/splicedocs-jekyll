---
title: SYSCS_UTIL.SYSCS_DICTIONARY_DELETE built-in system procedure
summary: Built-in system procedure that deletes a dictionary entry.
keywords: Delete, dictionary
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_sysprocs_dictdelete.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# SYSCS_UTIL.SYSCS_DICTIONARY_DELETE

The `SYSCS_UTIL.SYSCS_DICTIONARY_DELETE` system procedure deletes an entry from the dictionary, and can be used when you've determined that your dictionary has become corrupted.

## Syntax

<div class="fcnWrapperWide" markdown="1">
    SYSCS_UTIL.SYSCS_DICTIONARY_DELETE( INT conglomerateId,
                                        BIGINT rowId );
{: .FcnSyntax xml:space="preserve"}

</div>
<div class="paramList" markdown="1">
conglomerateId
{: .paramName}

The ID of the conglomerate from which we want to delete a row.
{: .paramDefnFirst}

You can find the conglomerateId using either the `show tables` or `show indexes` commands.
{: .paramDefn}

rowId
{: .paramName}

The hexadecimal representation of the `ROWID` of the row we want to delete.
{: .paramDefnFirst}

</div>
## Results

This procedure does not return a result.

## Usage

Follow these steps to use this procedure:

1. Use `show tables` or `show indexes` to identify the conglomerate.
2. Identify the `ROWID` of the row we want to delete.

   You must ensure that the `ROWID` corresponds to the correct conglomerate (base table or index).

   <div class="noteIcon" markdown="1">
   You should always specify the desired access path for the `ROWID` using a `splice-properties index` directive. For example:

   To get the base table `ROWID`:
   `SELECT ROWID FROM baseTable --splice-properties index=null
    WHERE ...;`

   To get an index `ROWID`:
   `SELECT ROWID from baseTable --splice-properties index=INDEX_2
    WHERE ...;`
   </div>

The procedure deletes the desired row transactionally.

Splice Machine advises that you:

1. Set `autocommit off` prior to running the procedure
2. Make sure the dictionary corruption is solved
3. Then commit the transaction:


## Example

Heres an example that assumes you've already identified your `conglomerateId` and `ROWID`:

```
        // identify conglomerate id and row id
...
        // set autocommit off
AUTOCOMMIT OFF;

        // delete dictionary rows
CALL SYSCS_UTIL.SYSCS_DICTIONARY_DELETE(145, 'CAFE48');
CALL SYSCS_UTIL.SYSCS_DICTIONARY_DELETE(250, 'BEEF03');

        // make sure corruption went away, run problematic DDL
CREATE TABLE a ( i INT);

        // if everything works, commit; otherwise, rollback and identify new rows to be deleted
COMMIT;
```
{: .Example}

</div>
</section>
