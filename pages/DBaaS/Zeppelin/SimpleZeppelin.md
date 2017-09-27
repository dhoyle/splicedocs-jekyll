---
summary: A quick and simple tutorial that show you how you can use Zeppelin notebook to load and query data, and apply different visualizations to the results.
title: A Simple Zeppelin Tutorial
keywords: zep, notebook, dbaas, paas, tutorial
sidebar: dbaas_sidebar
toc: false
product: dbaas
permalink: dbaas_zep_simple.html
folder: DBaaS/Zeppelin
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# A Simple Zeppelin Tutorial

{% include splice_snippets/dbaasonlytopic.md %}
This topic walks you through using a very simple Zeppelin notebook, to
help you learn about using Zeppelin with Splice Machine.

Our [Getting Started with Zeppelin](dbaas_zep_getstarted.html) page
provides a very brief overview of using Zeppelin; If you're new to
Zeppelin, we strongly encourage you to visit the [Zeppelin documentation
site][1]{: target="_blank"} to learn about creating, modifying, and
running your own Zeppelin notebooks.
{: .noteNote}

## Running the Tutorial Notebook

You can access this Zeppelin notebook by clicking the Basics (Spark)
link under Zeppelin Tutorials on the Zeppelin Dashboard page:

![](images/Zeppelin2.png){: .indentedTightSpacing}

Once you've opened the tutorial, you can run each step (each Zeppelin
*paragraph*) by clicking the <span class="CalloutFont">Ready</span>
button that you'll see on the right side of each paragraph. This example
includes these steps:

* Click the first <span class="CalloutFont">READY</span> button to
  create the schema and a table:
  
  ![](images/zepSimple1.png){: .indentedTightSpacing}

* Import data (in this case, TPCH1 benchmark data) into the table, then
  verify the data load by counting the number of records in the table:
  
  ![](images/zepSimple2a.png){: .indentedTightSpacing}

* Create indexes on the table, and then run compaction on the data,
  which is always a good idea after updating a large number of records:
  
  ![](images/zepSimple2b.png){: .indentedTightSpacing}

* Collect statistics, to improve query planning, and then run a query:
  
  ![](images/zepSimple3.png){: .indentedTightSpacing}

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



[1]: https://zeppelin.apache.org/docs/
