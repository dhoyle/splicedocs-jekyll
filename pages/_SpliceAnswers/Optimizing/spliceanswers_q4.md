---
title: How can I make an Explain plan?
summary: Tuning your Splice Machine query performance
keywords: optimization
toc: false
compatible_version: 2.7
product: all
category: Optimizing
sidebar: home_sidebar
permalink: spliceanswers_q4.html
folder: SpliceAnswers/Optimizing
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

# How can I make an Explain plan?
This topic shows you how to generate and display an execution (*Explain*) plan for a Splice Machine query.

## Applies When?
When you want to improve the performance of a query.

## Answer: Prepend `explain`
To generate an Explain plan (aka execution plan) for query, simply preface your query with the word `explain` in the `splice>` command line interpreter. For example, to explain the following query:

```
SELECT * FROM mySchema.myTable;
```
{: .Example}

Use this command:

```
splice> EXPLAIN SELECT * FROM mySchema.myTable;
```
{: .Example}

## Related Questions:

* [How do I understand the Explain plan?](spliceanswers_q6.html)
* [How do I know if a query is running on Spark or Control?](spliceanswers_q5.html)

## Questions That Link to This Topic:

* [How can I make my query faster?](spliceanswers_q3.html)


</div>
</section>
