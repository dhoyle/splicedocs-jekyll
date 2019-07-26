---
title: How do I know a query is running on Spark or Control?
summary: Determining which engine is running your Splice Machine query
keywords: optimization
toc: false
compatible_version: 2.7
product: all
category: Optimizing
sidebar: home_sidebar
permalink: spliceanswers_q5.html
folder: SpliceAnswers/Optimizing
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

# How do I know a query is running on Spark or Control?
This topic shows you how to determine if your query is running in the Spark engine or the Control (HBase) engine.

## Applies When?
You want to improve the performance of a query.

## Answer: Look at the Explain Plan

The top line of every Explain plan shows you which engine will be selected to run that query; the plan starts with a line that looks like this:

```
Cursor(n=6,rows=1,updateMode=,engine=Spark)
```

The engine will either be `Spark` or `Control`.

## Related Questions:

* [How do I understand the Explain plan?](spliceanswers_q6.html)
* [How do I access the Spark UI?](spliceanswers_q7.html)

## Questions That Link to This Topic:

* [How can I make an Explain Plan?](spliceanswers_q4.html)


</div>
</section>
