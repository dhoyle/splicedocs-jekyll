---
title: Show Roles command
summary: Displays information about all of the roles defined in the database.
keywords: role, show commands
toc: false
product: all
sidebar: home_sidebar
permalink: cmdlineref_showroles.html
folder: CmdLineReference
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Show Roles

The <span class="AppCommand">show roles</span> command a sorted list of
all of the roles that have been defined in the database.

Use the "`values current_role;`" statement to display the list of roles that are active in the current session.
{: .noteNote}

### Syntax

<div class="fcnWrapperWide" markdown="1">
    SHOW ROLES
{: .FcnSyntax xml:space="preserve"}

</div>
### Examples

<div class="preWrapperWide" markdown="1">
    splice> create role testRole;
    0 rows inserted/updated/deleted
    splice> show roles;

    ROLEID
    ------------------------------
    ADMIN, EDITOR, WRITER

    1 row selected
{: .AppCommand xml:space="preserve"}

</div>
</div>
</section>
