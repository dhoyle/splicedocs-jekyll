---
title: What is a Feature Store?
summary: Splice Machine's Feature Store
keywords: feature store
toc: false
product: all
sidebar: home_sidebar
permalink: featurestore_introduction.html
folder: FeatureStore
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

# What is a Feature Store?

## Problem Statement

Over the past few years there has been increased focus on how to best put Machine Learning into production. MLOps is an emerging space with a handful of great products, with new ideas emerging every day. Development teams are creating systems for packaging and deploying machine learning models, and managing their health once deployed. The problem is that MLOps is not the whole story. FeatureOps or DataOps is needed to manage the data, features, and pipelines that are actually feeding your ML models. These features are the lifeblood of your algorithms, and without knowing *exactly* where they came from, you cannot trust your models in production.

So the question becomes, “How do I manage the extraction, engineering, serving, and management of my features?” DevOps has a clear set of industry standard tools, and standard tools for MLOps are rapidly emerging. The space for DataOps has not yet been defined, and this creates open questions for every team trying to implement Machine Learning in a production environment.

## The Feature Store

The feature store is the solution to this problem. A feature store is a centralized repository of clean and curated data that is used to power ML models. It is the layer that sits between the raw data and the data science. This extra layer adds governance, tracking, and management of data to meet the specific needs of data scientists and engineers. Its feature serving function enables fast application integration by providing a consistent source of low latency feature sets with fresh values that are readily accessible to the ML models as they are deployed to production. The feature store is the *interface between data scientists and data engineers.*

</div>
</section>
