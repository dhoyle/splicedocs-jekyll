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

* [*About Jupyter*](#about)
* [*The Jupyter Dashboard*](#dashboard)
* [*Creating or Uploading a Notebook*](#createnotebook)
* [*Running or Editing a Notebook*](#runoredit)
* [*Saving or Closing a Notebook*](#save)

{% include splice_snippets/dbaasonlytopic.md %}

## About Jupyter  {#about}

JupyterLab is a web-based interactive development environment for Jupyter notebooks, code, and data. JupyterLab is flexible: configure and arrange the user interface to support a wide range of workflows in data science, scientific computing, and machine learning. JupyterLab is extensible and modular: write plugins that add new components and integrate with existing ones.

The Jupyter Notebook is an open-source web application that allows you to create and share documents that contain live code, equations, visualizations and narrative text. Uses include: data cleaning and transformation, numerical simulation, statistical modeling, data visualization, machine learning, and much more.

We strongly encourage you to visit the [Jupyter documentation site](https://jupyter.org/documentation) to learn about creating, modifying, and running your own Jupyter notebooks.

Here's some basic Jupyter Notebook terminology:

* Notebooks are broken into *cells*. You are now viewing the first cell in this notebook.

* Each cell has a *cell type* that knows how to process the source content in the cell.

  We are using the *markdown* type in this cell. Markdown generates HTML from easy-to-read, plain text input that uses simplified formatting instructions.

* You run a cell by clicking the *Run* button at the top (or clicking *Shift + Enter*); you can see the output of the cell after it runs. For example, the result of running this Markdown cell is to see the formatted text that you are currently reading.

### Cell Types

Each Jupyter Notebook cell has a type, which defines how it works. The two main cell types are *Markdown* (like this one) and *Code*. You can change the type of a cell in the <span class="ConsoleLink">Cell</span> menu or by using the dropdown in the toolbar:

<img class="indentedTightSpacing" src="images/jupcelltype.png" alt="The cell type toolbar drop-down" />

### Magics

In *Code* cells, you can use [magics](https://ipython.readthedocs.io/en/stable/interactive/magics.html) to change the language you want to write in; to see the available magic types, you can run a cell with <code>%lsmagic</code> in it:

```
%lsmagic
```

There are two kinds of magics:

* _Line magics_ are magic functions that help you within that individual line of code.
* _Cell magics_ are magic functions that help you within that *entire cell*.

### SQL Cells

You can use the `%%sql` magic to interact with your Splice Machine database with our implementation of the SQL language.


## The Jupyter Dashboard  {#dashboard}

When you click the <span class="CalloutFont">Notebook</span> button in your Cluster Management dashboard, you'll be asked to log into your database, and will then land on the Jupyter home page (dashboard):

<img class="indentedTightSpacing" src="images/juphome.png" alt="The Jupyter dashboard or home page" />

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
            <td>Displays the <a href="#filestab">Files</a> tab.</td>
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
            <td>Displays the <span class="ConsoleLink">New</span> menu, which you can use to create new notebooks, text files, folders, and terminal windows.</td>
        </tr>
        <tr>
            <td class="ConsoleLink">Sorting Options</td>
            <td>Use the <span class="ConsoleLink">Name</span>, <span class="ConsoleLink">Last Modified</span>, and <span class="ConsoleLink">File size</span> buttons to change the order in which the files are displayed in the Files tab.</td>
        </tr>
    </tbody>
</table>

When you select a notebook in the dashboard, Jupyter displays the <span class="ConsoleLink">Notebook Actions</span> menu, which you can use for actions such as viewing, renaming, or downloading the selected notebook:

<img class="fithalfwidth" src="images/jupfileactions2.png" alt="image of the Splice Machine file actions menu" />

### The Jupyter Files Tab  {#filestab}

The <span class="ConsoleLink">Files</span> tab displays the Jupyter notebooks (files) and folders of notebooks that Splice Machine has created for you to learn more about our products:

<img class="indentedTightSpacing" src="images/jupsplicenotebooks.png" alt="image of the Splice Machine cloud notebooks" />

You can click a folder to display the notebooks in the folder.

You can run or edit a notebook by clicking it; Jupyter opens the notebook in a separate browser tab. See the [Running or Editing a Notebook](#runoredit) section below for more information.

## Creating or Uploading a Notebook {#createnotebook}

You can create a new Jupyter notebook using either the <span class="ConsoleLink">New</span> menu in the Jupyter dashboard, or by selecting *New Notebook* from the <span class="ConsoleLink">File</span> menu in an active notebook.

You can also upload to your Jupyter server a notebook or folder of notebooks that was previously downloaded:

1. In the Jupyter dashboard, navigate to the folder into which you want to upload the notebook.
2. Click the <span class="ConsoleLink">Upload</span> button in the Dashboard.
3. Navigate to the notebook location on your computer.
4. Select the file or folder that you want to upload.
5. Click the <span class="ConsoleLink">Open</span> button in the file dialog.
6. Click the <span class="ConsoleLink">Upload</span> button to upload the file(s) to your Jupyter server.

   <img class="indentedTightSpacing" src="images/jupuploadfile.png" alt="uploading a local notebook file" />


## Running or Editing a Notebook  {#runoredit}

You can use the [Jupyter Notebook Menu](#menu) or the [Jupyter Notebook Toolbar](#toolbar) to interact with an active notebook.

* To edit a cell, simply activate the cell by clicking in it, and then start typing or selecting menu choices.
* To run a cell, activate the cell, and then press the Shift and Enter keys together. Alternatively, you can click the run icon in the toolbar.

Typically, after you run a cell, Jupyter automatically activates the next cell in the notebook.

### The Jupyter Notebook Menu {#menu}

The <span class="ConsoleLink">Jupyter Notebook</span> menu allows you to run, edit, and interact with the active notebook and its cells:

<img class="indentedTightSpacing" src="images/jupnotebookmenu.png" alt="The Jupyter notebook menu" />

<table>
    <col />
    <col />
    <tbody>
        <tr>
            <td class="ConsoleLink">File</td>
            <td>Contains commands to create a new notebook, open an existing notebook, download or publish the notebook, and other notebook-oriented actions.</td>
        </tr>
        <tr>
            <td class="ConsoleLink">Edit</td>
            <td>Commands to work with the active or selected cell(s) with actions including cut, copy, paste, delete, merge, and find/replace.</td>
        </tr>
        <tr>
            <td class="ConsoleLink">View</td>
            <td>View options.</td>
        </tr>
        <tr>
            <td class="ConsoleLink">Insert</td>
            <td>Commands to insert cells above or below the active cell.</td>
        </tr>
        <tr>
            <td class="ConsoleLink">Cell</td>
            <td>Commands to run, show or clear the output, or modify the type of the active or selected cell(s).</td>
        </tr>
        <tr>
            <td class="ConsoleLink">Kernel</td>
            <td>Commands to interrupt, restart, or shut down the notebook kernel. You can also change the kernel for the current notebook.</td>
        </tr>
        <tr>
            <td class="ConsoleLink">Navigate</td>
            <td>Not currently available.</td>
        </tr>
        <tr>
            <td class="ConsoleLink">Widgets</td>
            <td>Allows you to save or clear the current state of the notebook widgets. Jupyter *widgets* are users interface elements like sliders and textboxes.</td>
        </tr>
        <tr>
            <td class="ConsoleLink">Help</td>
            <td>The <span class="ConsoleLink">Help</span> menu has commands to display the available keyboard shortcuts, and links to external topics such as general notebook information, a markdown summary, and reference information for various libraries.</td>
        </tr>
    </tbody>
</table>


### The Jupyter Notebook Toolbar   {#toolbar}

Jupyter displays a toolbar at the top of each notebook that provides
convenient access to a number of options; note that most of these options are also accessible from the notebook menus:

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

## Saving or Closing a Notebook

To save a notebook that you're working on, select *Save and Checkpoint* from the File
Note that when you close a notebook tab, the notebook continues to be active in your Jupyter server. To actually shut down the notebook, you can either:

* Select *Close and Halt* from the notebook's <span class="ConsoleLink">File</span> menu; this shuts down the notebook and closes the browser tab that was displaying the notebook.
* Select the notebook in the Jupyter Dashboard home screen, and then click the *Shutdown* option:

  <img class="fithalfwidth" src="images/jupfileactions1.png" alt="image of the Jupyter file actions submenu" />

Note that Jupyter displays the names of currently active notebooks in green in the Files tab to make it easier to select them.

You can also download the active notebook to your computer in various formats by selecting the *Download As* option in the <span class="ConsoleLink">File</span> menu.

</div>
</section>
