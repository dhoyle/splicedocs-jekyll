Note that you can only use specific restore procedures with specific types of backups. For example, you can use the `RESTORE_TABLE` procedure to restore from a backup created by `BACKUP_TABLE`, but you cannot use `RESTORE_TABLE` to restore from a backup created by `BACKUP_DATABASE`.
The following table summarizes backup-restore compatibility:

<table>
    <col />
    <col />
    <thead>
        <tr>
            <th>If you backed up with this procedure:</th>
            <th>You can restore with these procedures:</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>SYSCS_UTIL.SYSCS_BACKUP_DATABASE</code></td>
            <td><code>SYSCS_UTIL.SYSCS_RESTORE_DATABASE</code></td>
        </tr>
        <tr>
            <td><code>SYSCS_UTIL.SYSCS_BACKUP_SCHEMA</code></td>
            <td><p><code>SYSCS_UTIL.SYSCS_RESTORE_SCHEMA</code>,</p>
                <p><code>SYSCS_UTIL.SYSCS_RESTORE_TABLE</code></p>
            </td>
        </tr>
        <tr>
            <td><code>SYSCS_UTIL.SYSCS_BACKUP_TABLE</code></td>
            <td><code>SYSCS_UTIL.SYSCS_RESTORE_TABLE</code></td>
        </tr>
    </tbody>
</table>
