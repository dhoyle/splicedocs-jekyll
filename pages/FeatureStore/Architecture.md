---
title: Splice Machine Feature Store Architecture
summary: Splice Machine Feature Store Architecture
keywords: feature store
toc: false
product: all
sidebar: home_sidebar
permalink: featurestore_architecture.html
folder: FeatureStore
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

This topic explains the structure of the Splice Machine Feature Store.

{% include splice_snippets/dbaasonlytopic.md %}

This topic is organized into these sections:

* [*Design*](#Design)
* [*Concept Hierarchy*](#Concept_Hierarchy)
* [*Implementation*](#Implementation)

# Design  {#Design}
Users interact with the feature store through an API, but under the hood, the feature store interacts directly (via SQL) with relational tables in your Splice Machine database. When users create new data, features, and Training Sets, that information as well as it’s metadata is persisted in Splice Machine and tracked automatically.

This is fundamentally different from other feature stores, because the Splice Machine feature store is powered directly by the Splice Machine database and is embedded into the core of your Splice Workspace. Other feature stores are loosely coupled with their data stores, which can add complexity, latency, and potential data leakage.

<img class='indentedTightSpacing' src='images/overall_architecture.png'>

The Splice Machine Feature Store was designed as an *implicit* tracker of features and data. It is meant to be unobtrusive to the data flow, tracking changes to features and metadata behind the scenes. In this interaction model, data scientists and engineers define metadata (Features, Feature Sets, Training Datasets) in the feature store through the API, but do not need to use the api itself to feed or use the feature store.

<img class='indentedTightSpacing' src='images/splice_fs.png'>

# Concept Hierarchy {#Concept_Hierarchy}

<img class='indentedTightSpacing' src='images/concept_hierarchy.png'>

* **Entities** are a conceptual framework for organizing your feature sets. They are used to define a business domain like customer or product. Entities  are instantiated  within one or more feature sets; individual customers or products in our example. In practice, an entity is represented as the primary key(s) of a Feature Set.
* **Feature Sets** are a group of features (represented as a relational table) that typically come from a single source or data pipeline.
* **Features** are individual data points within a Feature Set. In the Splice Machine Feature Store, features are implemented as columns in the feature set table.

# Implementation {#Implementation}
Under the hood, everything created in the feature store is persisted as relational tables. When users create a Feature Set, a table is created to hold current feature values, as well as a history table that keeps track of all past values of the features, as well as their “period of applicability” Period of applicability represents the span of time during which a particular value for a feature was active. As values for features are updated, their past versions are persisted in this history table in order to create training datasets.
What you’re left with is 2 tables:
1. A base feature set table used for real-time serving of features. This is the table that is directly updated when features change and will therefore contain most recent feature values. In other Feature Store implementations this could be thought of as your “online” features.
2. A history table (automatically created) which will automatically store previous versions of each record in the base table whenever new values are applied. With all of the past values for those features, it is used to create training datasets for model training, monitoring, and retraining. In other Feature Stores this would be your “offline” features.

The difference between Splice Machine and other feature stores is that *all* features are  both “online” and “offline” because all features are stored in a **single database** that maintains low-latency lookups, and petabyte scale aggregations.

<img class='indentedTightSpacing' src='images/create_fs.png'>

<img class='indentedTightSpacing' src='images/fs_tables.png'>

The ***YELLOW BOLD*** fields in the picture above are the Primary Key of each of these sample tables. In general, Feature Sets will have a primary key that identifies the entity for which we are collecting features. Note that the primary key of the history table is the same as the base table, but expanded to include the period of applicability (```ASOS_TS, UNTIL_TS```) which allows it to keep the full history of each feature’s value.

In Splice Machine’s Feature Store, once a Feature Set is deployed, users can interact with the feature set as a standard relational table using ANSI SQL. As features are updated in the base table, the before-update rows are stored in the corresponding history table to allow for point-in-time feature retrieval that is needed when creating training datasets.

Updates to the feature set base table can take on any form that the database supports. It can be done through basic SQL CRUD operations, bulk batch loads, real-time streaming, or through native DataFrame APIs via the Native Spark Datasource.

<img class='indentedTightSpacing' src='images/fs_structure.png'>

In this architecture, the Feature Store API steps out of the interaction model and implicitly manages all features, removing the added complexity and latency from the user as the user no longer needs to install and invoke the feature store API every time they want to add or retrieve features.


</div>
</section>
