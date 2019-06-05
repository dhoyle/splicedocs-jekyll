---
title: Splice Machine Query Optimizer
summary: Overview of the Splice Machine Query Optimizer
keywords: query optimization
toc: false
compatible_version: 2.7
product: all
sidebar: home_sidebar
permalink: bestpractices_optimizer_intro.html
folder: BestPractices/Optimizer
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

# The Splice Machine Query Optimizer

With a perfect optimizer, you don't need to worry about the efficiency of your SQL statements; the optimizer’s responsibility is to convert your SQL into a semantically equivalent and more performant execution plan. The Splice Machine optimizer does a great job; however, there's no such thing as a perfect optimizer, which means that there are times when you'll need to apply some manual tuning and rewriting to queries. That's because:

* The optimizer’s heuristic rewrite functionalities has limitations with regard to what it can do.
* The optimizer can only explore a limited portion of the search space.
* Statistics and cost estimation are not 100% accurate.
* The optimizer must not use excessive time parsing query paths.

This other topics in this chapter show you how to use Splice Machine features to analyze and tune query performance:

* [*Using Explain Plan to Tune Queries*](bestpractices_optimizer_explain.html) shows you how to use the `explain` feature to understand the execution plan for your queries.
* [*Using Statistics to Tune Queries*](bestpractices_optimizer_statistics.html) introduces the statistics views that you can use to see key metrics about the tables in your queries.
* [*Using Indexes to Improve Performance*](bestpractices_optimizer_indexes.html) shows you the importance of defining appropriate indexes on your tables to boost performance.
* [*Using Hints to Optimize Queries*](bestpractices_optimizer_hints.html) introduces the various `--splice-properties` hints that you can provide to the optimizer to make certain queries run faster.
* [*Advanced Query Optimization Techniques*](bestpractices_optimizer_advanced.html) provides guidance for addressing specific and common performance issues.


</div>
</section>
