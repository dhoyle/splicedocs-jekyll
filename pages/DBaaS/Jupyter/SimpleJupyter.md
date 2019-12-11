---
summary: A quick and simple tutorial that show you how you can use Jupyter notebook to load and query data, and apply different visualizations to the results.
title: A Simple Jupyter Tutorial
keywords: jupyter, notebook, dbaas, paas, tutorial
sidebar: home_sidebar
toc: false
product: dbaas
permalink: dbaas_jup_simple.html
folder: DBaaS/Jupyter
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# A Simple Jupyter Tutorial

This topic walks you through using a very simple Jupyter notebook, to
help you learn about using Jupyter with the Splice Machine database service.

{% include splice_snippets/dbaasonlytopic.md %}

Our [Getting Started with Jupyter](dbaas_jup_getstarted.html) page
provides a very brief overview of using  ; If you're new to
Jupyter, we strongly encourage you to visit the [Jupyter documentation
site][1]{: target="_blank"} to learn about creating, modifying, and
running your own Jupyter notebooks.
{: .noteNote}

## Running the Tutorial Notebook

You can access this Jupyter notebook by clicking the Basics (Spark)
link under Jupyter Tutorials on the Jupyter Dashboard page:

![](images/Zeppelin2.png){: .indentedTightSpacing}

Once you've opened the tutorial, you can run each step (each Zeppelin
*paragraph*) by clicking the <span class="CalloutFont">Ready</span>
button that you'll see on the right side of each paragraph. This example
includes these steps:

* Click the first <span class="CalloutFont">READY</span> button to
  create the schema and a table:

  ![](images/ZepSimple1.png){: .indentedTightSpacing}

* Import data (in this case, TPCH1 benchmark data) into the table, then
  verify the data load by counting the number of records in the table:

  ![](images/zepSimple2a.png){: .indentedTightSpacing}

* Create indexes on the table, and then run compaction on the data,
  which is always a good idea after updating a large number of records:

  ![](images/zepSimple2b.png){: .indentedTightSpacing}

* Collect statistics, to improve query planning, and then run a query:

  ![](images/ZepSimple3.png){: .indentedTightSpacing}

After the query runs, you can take advantage of Zeppelin's built-in
visualization tools to display the query results in various graphical
and tabular formats.

When you click the <span class="CalloutFont">READY</span> button,
Zeppelin runs the paragraph that loads your data and subsequently
displays the *Finished* message.

If you see *Error* instead of *Finished*, it usually means that you've
forgotten to set SpliceMachine interpreter as the default.
{: .noteNote}

## Apply Different Visualizations to Your Results   {#view}

Zeppelin provides a wealth of data visualization tools you can use. In
the example below, we have modified the presentation of query results to
use different visualizations by clicking different visualization icons
in the output pane. You can define and modify the values of variables
that you use in your queries; for example, the `maxAge` and `marital`
values in the examples below:

![](images/ZepVis1.png){: .indentedTightSpacing}

</div>
</section>



[1]: https://jupyter.org/documentation
