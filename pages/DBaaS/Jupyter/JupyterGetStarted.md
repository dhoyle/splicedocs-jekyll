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

When you click the <span class="CalloutFont">Notebook</span> button in your Cluster Management dashboard, you'll be asked to log into your database, and will then land on the Jupyter home page (dashboard):

![](images/juphome.png){: .indentedTightSpacing}

Use the same user ID and password to log into Jupyter as you use to log
into your database.

The Jupyter home page displays any notebooks and notebook folders that are available to you. The

<table >
    <col />
    <col />
    <col />
    <thead>
        <tr>
            <th>UI Element</th>
            <th>Description</th>
            <th>&nbsp;</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="ConsoleLink">Logout</td>
            <td>Click to log out of Jupyter.</td>
        </tr>
        <tr>
            <td class="ConsoleLink">Control Panel</td>
            <td>Click to display your control panel, which you can use to </td>
        </tr>
        <tr>
            <td class="ConsoleLink">Files</td>
            <td>Displays the [Files](#filestab) tab.</td>
        </tr>
        <tr>
            <td class="ConsoleLink">Running</td>
            <td>Displays the <span class="ConsoleLink">Running</span> tab, from which you can access or shut down a running notebook or terminal window.</td>
        </tr>
        <tr>
            <td class="ConsoleLink">Clusters</td>
            <td>Displays the <span class="ConsoleLink">Clusters</span> tab.</td>
            <td>XXX</td>
        </tr>
        <tr>
            <td class="ConsoleLink">BeakerX</td>
            <td>Displays the [BeakerX](#beakerx) tab.</td>
        </tr>
        <tr>
            <td class="ConsoleLink">Upload</td>
            <td>Allows you to upload notebooks to your Jupyter server.</td>
        </tr>
        <tr>
            <td class="ConsoleLink">New</td>
            <td>Displays the [New](#newmenu) menu, which you can use to create new notesbooks, text files, folders, and terminal windows.</td>
        </tr>
        <tr>
            <td class="ConsoleLink">Sorting Options</td>
            <td>Use the <span class="ConsoleLink">Name</span>, <span class="ConsoleLink">Last Modified</span>, and <span class="ConsoleLink">File size</span> buttons to change the order in which the files are displayed in the Files tab.</td>
            <td>&nbsp;</td>
        </tr>
    </tbody>
</table>


### The Jupyter Files Tab  {#filestab}

The <span class="ConsoleLink">Files</span> tab displays the Jupyter notebooks and folders of notebooks that Splice Machine has created for you to learn more about our products:

<img class="indentedTightSpacing" src="images/jupsplicenotebooks.png" alt="image of the Splice Machine cloud notebooks" />

You can click a folder to display the notebooks in the folder.

You can run or edit a notebook by clicking it; Jupyter opens the notebook in a separate browser tab. See the [Running or Editing a Notebook](#runoredit) section below for more information.

### The BeakerX Tab {#beakerx}


## Running or Editing a Notebook  {#runoredit}

Introduce cells, kernels, magics, run or edit

### The Jupyter Notebook Toolbar   {#toolbar}

Jupyter displays a toolbar at the top of each notebook that provides
convenient access to a number of options:

<img class="indentedTightSpacing" src="images/jupstoolbar.png" alt="image of the Jupyter notebook toolbar" />

You can hover over any of the icons in the toolbar to disp
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

Be sure to view our [Usage Notes](dbaas_jup_notes.html) page for
important information about creating Zeppelin notebooks to use with
Splice Machine.

We strongly encourage you to visit the [Zeppelin documentation
site][1]{: target="_blank"} to learn about creating, modifying, and
running your own Zeppelin notebooks.
{: .noteNote}

</div>
</section>



[1]: https://zeppelin.apache.org/docs/
