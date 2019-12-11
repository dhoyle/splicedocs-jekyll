---
summary: Introduction to using Jupyter with Splice Machine.
title: Getting Started with Jupyter
keywords: getting started, jupyter, notebook, paragraph
sidebar: home_sidebar
toc: false
product: dbaas
permalink: dbaas_jup_getstarted.html
folder: DBaaS/Jupyter
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Getting Started with Jupyter

This topic helps you to get started with using Jupyter with your Splice Machine database service, in the following sections:

* [The Jupyter Dashboard](#dashboard)
* [Adding Your Credentials](#credentials)
* [The Jupyter Note Toolbar](#toolbar)
* [The Jupyter Drop-Down Menu](#Dropdown)
* [Monitoring Job Status](#Job)
* [Creating Notebooks](#create)
*
{% include splice_snippets/dbaasonlytopic.md %}


## The Jupyter Dashboard  {#dashboard}

When you click the <span class="CalloutFont">Notebook</span> button in
your Cluster Management dashboard, you land on the Jupyter welcome
page. To start using Jupyter with your database service, you need to
log in to your database by clicking the <span
class="ConsoleLink">Login</span> button.

![](images/Notebooks1.png){: .indentedTightSpacing}

Use the same user ID and password to log into Jupyter as you use to log
into your database.

When you log into Jupyter for your database, you'll land on the
Jupyter dashboard, which displays the list of available notebooks and notebook folders. Simply click a folder name to display the notebooks within that folder.

Splice Machine has already created a number of useful notebooks, which we've organized into folders:

![](images/Jupyter1.png){: .indentedTightSpacing}

We suggest that you try running some of them to get a feel for what
Jupyter can do: click a notebook name, and you'll land on the notebook
page in Jupyter. From there, you can run all or portions of the
notebook, modify its content, and create new notebooks. Our next topic,
[A Simple Tutorial](dbaas_jup_simple.html), uses the our <span
class="CalloutFont">Simple Example</span> tutorial.

## Adding Your Credentials  {#credentials}

You use the Splice Machine interpreter (`%splicemachine`) in Jupyter notebooks to interact with your Splice Machine database; this interpreter uses a JDBC connection to the database, and making that connection requires you to supply user credentials. Here's how you can create the credentials to use with the Splice Machine interpreter in your Jupyter notebooks:

<div class="opsStepsList" markdown="1">
1.  Log in to Jupyter, using the <span class="ConsoleLink">Notebook</span> button, as described above.

2.  Click the <span class="ConsoleLink">Jupyter</span> dropdrop in the upper right corner of the window, and select <span class="ConsoleLink">Credential</span>:

    <img class="indentedSmall" src="images/CloudZepDropdown.png" alt="image of the Jupyter drop-down" />

    The <span class="ConsoleLink">Jupyter Credentials Management</span> page displays:

    <img class="indented" src="images/CloudZepCredentials.png" alt="image of the Jupyter credentials management page" />

3.  Click the <span class="ConsoleLink">Add</span> button to add your credentials:

    <img class="indented" src="images/CloudZepAddCredential.png" alt="image of the Jupyter add credentials page" />

    * Enter `jdbc.splicemachine` as the <span class="ConsoleLink">Entity</span>.
    * Use the same <span class="ConsoleLink">Username</span> and <span class="ConsoleLink">password</span> that you use to log into your database.

4.  Click the <span class="ConsoleLink">Save</span> button to add your credentials.
</div>

Now, when you specify the `%splicemachine` interpreter for a Jupyter paragraph, your credentials will be used to connect to your Splice Machine database.

Remember to explicitly specify the `%splicemachine` interpreter in paragraphs, even if `%splicemachine` is the default interpreter for the notebook you're working on.
{: .noteImportant}

### First Notebook Run: Save Interpreter Bindings

The first time that you run any Jupyter notebook, you need to bind any
interpreters needed by the notebook. For our tutorials, these are
preconfigured for you; all you need to do is click the Save button:

![](images/ZepInterpreters.png){: .indentedTightSpacing}

If you neglect to save its bindings, the notebook will not run. And
again: you only need to do this one time for each notebook that you run.
{: .noteNote}

## The Zeppelin Note Toolbar   {#toolbar}

Zeppelin displays a toolbar at the top of each note that provides
convenient access to a number of options:

![](images/ZepToolbar.png){: .indentedTightSpacing}

The following table describes the toolbar buttons:

<table>
    <tr>
        <td><img src="images/ZepToolbarIcon1.png" class="icon36" /></td>
        <td>Executes all of the paragraphs in the note, in display-order sequence.</td>
    </tr>
    <tr>
        <td><img src="images/ZepToolbarIcon2.png" class="icon36" /></td>
        <td>Shows or hides the code sections of the paragraphs in the note.</td>
    </tr>
    <tr>
        <td><img src="images/ZepToolbarIcon3.png" class="icon36" /></td>
        <td>Shows or hides the result sections of the paragraphs in the note.</td>
    </tr>
    <tr>
        <td><img src="images/ZepToolbarIcon4.png" class="icon36" /></td>
        <td>Clears the result sections of the paragraphs in the note.</td>
    </tr>
    <tr>
        <td><img src="images/ZepToolbarIcon5.png" class="icon36" /></td>
        <td>Clones the current note.</td>
    </tr>
    <tr>
        <td><img src="images/ZepToolbarIcon6.png" class="icon36" /></td>
        <td>Exports the current note in JSON format.
            <p class="noteNote">The code and result sections of all paragraphs are exported; you might want to clear your results before exporting a note.</p></td>
    </tr>
    <tr>
        <td><img src="images/ZepToolbarIcon7.png" class="icon36" /></td>
        <td>Switches between personal and collaboration modes.</td>
    </tr>
    <tr>
        <td><img src="images/ZepToolbarIcon8.png" class="icon36" /></td>
        <td>Commits changes that you've made to the content of the current note (and allows you to add a commit note).</td>
    </tr>
    <tr>
        <td><img src="images/ZepToolbarIcon9.png" class="icon72" /></td>
        <td>Displays the revision you're currently viewing, and lets you select from available revisions.</td>
    </tr>
    <tr>
        <td><img src="images/ZepToolbarIcon12.png" class="icon36" /></td>
        <td>Deletes the note.</td>
    </tr>
    <tr>
        <td><img src="images/ZepToolbarIcon13.png" class="icon36" /></td>
        <td>Schedules execution of the note, using CRON syntax.</td>
    </tr>
</table>
## The Zeppelin Drop-Down Menu   {#Dropdown}

When you're working in Zeppelin, you can quickly jump to another
notebook or create a new note by clicking the <span
class="ConsoleLink">Zeppelin</span> drop-down menu:

![](images/zepdropdown.png){: .indentedTightSpacing}

## Monitoring Job Status   {#Job}

You can monitor the status of any Zeppelin notebook job(s) running in
your cluster by clicking the <span class="ConsoleLink">Job</span> button
at the top of the Zeppelin screen. This displays a list of the notebook
jobs that are running and have run on your cluster.

![](images/ZepJobs1.png){: .indentedTightSpacing}

From the <span class="ConsoleLink">Job</span> screen, you can:

* Monitor all jobs associated with your account.
* Filter which jobs are displayed.
* Search for notebooks.
* Start, Pause, or Terminate a running job.
* Click a notebook job name to navigate to that notebook.

## Creating Notebooks   {#create}

Be sure to view our [Usage Notes](dbaas_zep_notes.html) page for
important information about creating Zeppelin notebooks to use with
Splice Machine.

We strongly encourage you to visit the [Zeppelin documentation
site][1]{: target="_blank"} to learn about creating, modifying, and
running your own Zeppelin notebooks.
{: .noteNote}

</div>
</section>



[1]: https://zeppelin.apache.org/docs/
