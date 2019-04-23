---
title: Database Administration System Procedures and Functions in Splice Machine
summary: A table that summarizes the function of each available Splice Machine built-in system procedures for managing your database.
keywords: admin procedures, system admin procedures
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_sysprocs_dbadminintro.html
folder: SQLReference/BuiltInSysProcs
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Administrative Procedures and Functions

These system procedures and functions for administering your
database apply to both our on-premise and database-as-service products:
{: .body}

<table summary="Summary of Splice Machine system  procedures and functions for database administration">
    <col />
    <col />
    <thead>
        <tr>
            <th>Procedure / Function Name</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont"><a href="sqlref_sysprocs_checktable.html"><code>SYSCS_UTIL.CHECK_TABLE</code></a></td>
            <td>Reports on inconsistencies between a table and its indexes.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_user.html">SYSCS_UTIL.SYSCS_CREATE_USER</a>
            </td>
            <td>Adds a new user account to a database.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_builtinfcns_user.html">SYSCS_UTIL.SYSCS_DROP_USER</a>
            </td>
            <td>Removes a user account from a database.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_sysprocs_invaldictcache.html">SYSCS_UTIL.INVALIDATE_DICTIONARY_CACHE</a>
            </td>
            <td>Invalidates the dictionary cache on the connection's region server.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_sysprocs_invalglobaldictcache.html">SYSCS_UTIL.INVALIDATE_GLOBAL_DICTIONARY_CACHE</a>
            </td>
            <td>Invalidates the dictionary cache on all region servers.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_sysprocs_killoperation.html">SYSCS_UTIL.KILL_OPERATION</a>
            </td>
            <td>Terminates a Splice Machine operation running on the server to which you are connected.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_sysprocs_modifypassword.html">SYSCS_UTIL.SYSCS_MODIFY_PASSWORD</a>
            </td>
            <td>Called by a user to change that user's own password.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_sysprocs_compactschema.html">SYSCS_UTIL.SYSCS_PERFORM_MAJOR_COMPACTION_ON_SCHEMA</a>
            </td>
            <td>Performs a major compaction on a schema</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_sysprocs_compacttable.html">SYSCS_UTIL.SYSCS_PERFORM_MAJOR_COMPACTION_ON_TABLE</a>
            </td>
            <td>Performs a major compaction on a table.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_sysprocs_refreshexttable.html">SYSCS_UTIL.SYSCS_REFRESH_EXTERNAL_TABLE</a>
            </td>
            <td>Refreshes the schema of an external table in Splice Machine; use this when the schema of the table's source file has been modified outside of Splice Machine.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_sysprocs_resetpassword.html">SYSCS_UTIL.SYSCS_RESET_PASSWORD</a>
            </td>
            <td>Resets a password that has expired or has been forgotten.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_sysprocs_updateschemaowner.html">SYSCS_UTIL.SYSCS_UPDATE_SCHEMA_OWNER</a>
            </td>
            <td>Changes the owner of a schema.</td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_sysprocs_vacuum.html">SYSCS_UTIL.VACUUM</a>
            </td>
            <td>Performs clean-up operations on the system.</td>
        </tr>
    </tbody>
</table>

These system procedures and functions for administering your
database only apply to our on-premise product:
{: .body}

<table summary="Summary of Splice Machine system  procedures and functions for database administration">
    <col />
    <col />
    <thead>
        <tr>
            <th>Procedure / Function Name</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont"><a href="sqlref_sysprocs_backupdb.html">SYSCS_UTIL.SYSCS_BACKUP_DATABASE</a>
            </td>
            <td>
                <p>Backs up the database to a specified backup directory.</p>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_sysprocs_cancelbackup.html">SYSCS_UTIL.SYSCS_CANCEL_BACKUP</a>
            </td>
            <td>
                <p>Cancels a backup.</p>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_sysprocs_deletebackup.html">SYSCS_UTIL.SYSCS_DELETE_BACKUP</a>
            </td>
            <td>
                <p>Delete a specific backup.</p>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_sysprocs_deleteoldbackups.html">SYSCS_UTIL.SYSCS_DELETE_OLD_BACKUPS</a>
            </td>
            <td>
                <p>Deletes all backups that were created more than a certain number of days ago.</p>
            </td>
        </tr>
        <tr>
            <td class="CodeFont"><a href="sqlref_sysprocs_restoredb.html">SYSCS_UTIL.SYSCS_RESTORE_DATABASE</a>
            </td>
            <td>
                <p>Restores a database from a previous backup.</p>
            </td>
        </tr>
    </tbody>
</table>

</div>
</section>
