---
title: What is a Feature Store?
summary: Splice Machine's Feature Store
keywords: feature store
toc: false
product: all
sidebar: home_sidebar
permalink: featurestore_using.html
folder: FeatureStore
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

This topic explains what a feature store is and how you can use it to accelerate MLOps.

{% include splice_snippets/dbaasonlytopic.md %}

# What is a Feature Store?

## Problem
Over the past few years, the industry has seen increased focus on how to best put Machine Learning in production. MLOps is an emerging space with a handful of great products, and new ideas coming every day. Dedicated teams are creating great systems for packaging and deploying machine learning models, and managing their health once deployed. The problem though, is that MLOps isn’t the whole story. FeatureOps or DataOps is needed to manage the data, features, and pipelines that are actually feeding your ML models. These features are the lifeblood of your algorithms, and without knowing *exactly* where they came from, you cannot trust your models in production.

So the question becomes, “how do I manage the extraction, engineering, serving and management of my features?” DevOps has a clear set of industry standard tools, and MLOps is fast approaching. The space for DataOps has not yet been defined, and it leaves open questions to every team trying to productionalize Machine Learning.

## The Feature Store

The Feature Store is the answer to this question. A feature store is a centralized repository of clean and curated data to power ML models. It is the layer that sits between your raw data and the data science. This extra layer adds governance, tracking, and management of data specific to the needs of data scientists and engineers. Its feature serving function enables fast application integration by providing a consistent source of low latency feature sets with fresh values that are readily accessible to the ML models as they are deployed to production.  The Feature Store is the *interface between data scientists and data engineers.*

</div>
</section>
