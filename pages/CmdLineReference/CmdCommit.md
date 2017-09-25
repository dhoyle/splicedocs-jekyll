---
title: Commit command
summary: Commits the currently active transaction and initiates a new transaction.
keywords: commit, transactions
toc: false
product: all
sidebar: cmdlineref_sidebar
permalink: cmdlineref_commit.html
folder: CmdLineReference
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Commit Command

The <span class="AppCommand">commit</span> command issues a
`java.sql.Connection.commit` request, which commits the currently active
transaction and initiates a new transaction.

You should only use this command when auto-commit mode is disabled.
{: .noteNote}

## Syntax

<div class="fcnWrapperWide" markdown="1">
    COMMIT
{: .FcnSyntax xml:space="preserve"}

</div>
## Examples

<div class="preWrapper" markdown="1">
    splice> commit;
    splice>
{: .AppCommand xml:space="preserve"}

</div>
</div>
</section>

