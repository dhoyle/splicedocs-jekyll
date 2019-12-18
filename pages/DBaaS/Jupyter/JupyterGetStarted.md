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
    <thead>
        <tr>
            <th>UI Element</th>
            <th>Description</th>
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
        </tr>
        <tr>
            <td class="ConsoleLink">BeakerX</td>
            <td>
                <p>Displays the BeakerX tab. BeakerX is an open source collection of kernels and extensions for Jupyter that provides support in notebooks for polygot programming, interactive plots, tables, forms, publishing and more.</p>
                <p>You can use this tab to modify some of the properties and options provided by BeakerX.</p>
            </td>
        </tr>
        <tr>
            <td class="ConsoleLink">Upload</td>
            <td>Allows you to upload notebooks to your Jupyter server.</td>
        </tr>
        <tr>
            <td class="ConsoleLink">New</td>
            <td>Displays the <span class="ConsoleLink">New</span> menu, which you can use to create new notesbooks, text files, folders, and terminal windows.</td>
        </tr>
        <tr>
            <td class="ConsoleLink">Sorting Options</td>
            <td>Use the <span class="ConsoleLink">Name</span>, <span class="ConsoleLink">Last Modified</span>, and <span class="ConsoleLink">File size</span> buttons to change the order in which the files are displayed in the Files tab.</td>
        </tr>
    </tbody>
</table>


### The Jupyter Files Tab  {#filestab}

The <span class="ConsoleLink">Files</span> tab displays the Jupyter notebooks and folders of notebooks that Splice Machine has created for you to learn more about our products:

<img class="indentedTightSpacing" src="images/jupsplicenotebooks.png" alt="image of the Splice Machine cloud notebooks" />

You can click a folder to display the notebooks in the folder.

You can run or edit a notebook by clicking it; Jupyter opens the notebook in a separate browser tab. See the [Running or Editing a Notebook](#runoredit) section below for more information.


## Running or Editing a Notebook  {#runoredit}

Introduce cells, kernels, magics, run or edit

### The Jupyter Notebook Toolbar   {#toolbar}

Jupyter displays a toolbar at the top of each notebook that provides
convenient access to a number of options:

<img class="indentedTightSpacing" src="images/juptoolbar.png" alt="image of the Jupyter notebook toolbar" />

You can hover over any of the icons in the toolbar to display its function; these include:
<table>
    <col width="72px" />
    <col />
    <tbody>
        <tr>
            <td><img src="images/jupiconsave.png" /></td>
            <td class="Middle">Saves and checkpoints the notebook.</td>
        </tr>
        <tr>
            <td><img src="images/jupiconinsert.png"  /></td>
            <td class="Middle">Inserts a new cell below the current cell.</td>
        </tr>
        <tr>
            <td><img src="images/jupiconcutcells.png"  /></td>
            <td class="Middle">Cuts the selected cells.</td>
        </tr>
        <tr>
            <td><img src="images/jupiconcopycells.png"  /></td>
            <td class="Middle">Copies the currently selected cells.</td>
        </tr>
        <tr>
            <td><img src="images/jupiconpastecells.png"  /></td>
            <td class="Middle">Pastes cells below the current cell.</td>
        </tr>
        <tr>
            <td><img src="images/jupiconmoveup.png"  /></td>
            <td class="Middle">Moves the selected cells up.</td>
        </tr>
        <tr>
            <td><img src="images/jupiconmovedown.png"  /></td>
            <td class="Middle">Moves the selected cells down.</td>
        </tr>
        <tr>
            <td><img src="images/jupiconrun.png"  /></td>
            <td class="Middle">Runs the selected cells.</td>
        </tr>
        <tr>
            <td><img src="images/jupiconinterrupt.png"  /></td>
            <td class="Middle">Interrupts the kernel.</td>
        </tr>
        <tr>
            <td><img src="images/jupiconrestart.png"  /></td>
            <td class="Middle">Restarts the kernel.</td>
        </tr>
        <tr>
            <td><img src="images/jupiconrerun.png"  /></td>
            <td class="Middle">Restarts the kernel and re-runs the cells in the notebook.</td>
        </tr>
        <tr>
            <td><img src="images/jupiconcelltype.png"  /></td>
            <td class="Middle">Displays/selects the cell type of the current cell.</td>
        </tr>
        <tr>
            <td><img src="images/jupiconpalette.png"  /></td>
            <td class="Middle">Opens the command palette.</td>
        </tr>
        <tr>
            <td><img src="images/jupiconspark.png"  /></td>
            <td class="Middle">Toggles the Spark monitoring displays.</td>
        </tr>
        <tr>
            <td><img src="images/jupiconruninit.png"  /></td>
            <td class="Middle">Runs all initialization cells.</td>
        </tr>
        <tr>
            <td><img src="images/jupicontoc.png"  /></td>
            <td class="Middle">Displays a table of contents for the notebook.</td>
        </tr>
        <tr>
            <td><img src="images/jupiconpublish.png"  /></td>
            <td class="Middle">Publishes the notebook as a GitHub GIST.</td>
        </tr>
    </tbody>
</table>















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
