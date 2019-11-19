---
title: Best Practices - Optimizing Your Queries
summary: Optimizing Your Database Queries
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

# Optimizing Your Database Queries

Improving query performance is a critical issue for most database users. Almost all database systems include a *query optimizer* that analyzes queries and determines efficient execution mechanisms. A query optimizer generates one or more query plans for each query, each of which may be a mechanism used to run a query. The most efficient query plan is selected and used to run the query. The Splice Machine optimizer does a great job of converting your SQL into a semantically equivalent and more performant execution plan, and in most cases, takes care of this for you.

However, any query optimizer has to deal with limitations, including:

* The optimizer’s heuristic rewrite functionalities has limitations with regard to what it can do.
* The optimizer can only explore a limited portion of the search space.
* Statistics and cost estimation are not 100% accurate.
* The optimizer must not use excessive time parsing query paths.

Because of optimizer limitations, there are times when you may want to apply some manual tuning and rewriting to your queries for maximum performance. This chapter presents the features available in Splice Machine for analyzing and tuning your queries, in these topics:

* [*Using Explain Plan to Tune Queries*](bestpractices_optimizer_explain.html) shows you how to use the `explain` feature to understand the execution plan for your queries.
* [*Using Statistics to Tune Queries*](bestpractices_optimizer_statistics.html) introduces the statistics views that you can use to see key metrics about the tables in your queries.
* [*Using Indexes to Improve Performance*](bestpractices_optimizer_indexes.html) shows you the importance of defining appropriate indexes on your tables to boost performance.
* [*Using Hints to Optimize Queries*](bestpractices_optimizer_hints.html) introduces the various `--splice-properties` hints that you can provide to the optimizer to make certain queries run faster.
{% comment %}
* [*Advanced Query Optimization Techniques*](bestpractices_optimizer_advanced.html) provides guidance for addressing specific and common performance issues.
{% endcomment %}
* [*Compacting and Vacuuming Your Database Files*](bestpractices_optimizer_compacting.html) describes how compacting and vacuuming your database files can help with database performance.


</div>
</section>
