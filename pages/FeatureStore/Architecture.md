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

This topic is organized into these sections:

- [Design  {#Design}](#design--design)
- [Conceptual Hierarchy {#Concept_Hierarchy}](#conceptual-hierarchy-concept_hierarchy)
- [Implementation {#Implementation}](#implementation-implementation)

# Design  {#Design}
Users interact with the feature store through an API, but under the hood, the feature store interacts directly (via SQL) with relational tables in your Splice Machine database. When you create new data, features, and training sets, that information as well as its metadata is persisted in Splice Machine and tracked automatically.

This is fundamentally different than other feature stores, because the Splice Machine feature store is powered directly by the Splice Machine database, and is embedded in the core of your Splice Machine Workspace. Other feature stores are loosely coupled with their data stores, which can add complexity, latency, and potential data leakage.

<img class='indentedTightSpacing' src='images/overall_architecture.png'>

The Splice Machine feature store is designed as an *implicit* tracker of features and data. It is meant to be unobtrusive to the data flow, tracking changes to features and metadata behind the scenes. In this interaction model, data scientists and engineers define metadata (features, feature sets, training datasets) in the feature store through the API, but do not need to use the API itself to feed or use the feature store.

<img class='indentedTightSpacing' src='images/splice_FS.png'>

# Conceptual Hierarchy {#Concept_Hierarchy}

<img class='indentedTightSpacing' src='images/concept_hierarchy.png'>

* **Entities** are conceptual frameworks used to organize your feature sets. They are used to define a business domain such as customer or product. Entities are instantiated  within one or more feature sets; individual customers or products in our example. In practice, an entity is represented as the primary key(s) of a feature set.
* **Feature sets** are a group of features (represented as a relational table) that typically come from a single source or data pipeline.
* **Features** are individual data points within a feature set. In the Splice Machine feature store, features are implemented as columns in the feature set table.

# Implementation {#Implementation}
Under the hood, everything created in the feature store is persisted as relational tables. When users create a feature set, a table is created to hold current feature values, along with a history table that keeps track of all past values of the features, as well as their “period of applicability”. Period of applicability represents the timespan during which a particular value for a feature was active. As values for features are updated, their past versions are persisted in this history table in order to create training datasets.

* The base feature set table is used for real-time serving of features. This is the table that is directly updated when features change, and therefore contains the most recent feature values. In other feature store implementations this could be thought of as your “online” features.

* The history table (automatically created) automatically stores previous versions of each record in the base table whenever new values are applied. It contains all of the past values for those features, and is used to create training datasets for model training, monitoring, and retraining. In other feature stores this would be your “offline” features.

The difference between Splice Machine and other feature stores is that *all* features are  both “online” and “offline” because all features are stored in a **single database** that maintains low-latency lookups and petabyte scale aggregations.

<img class='indentedTightSpacing' src='images/create_fs.png'>

<img class='indentedTightSpacing' src='images/fs_tables.png'>

The ***YELLOW BOLD*** fields in the image above are the primary keys of each of these sample tables. In general, feature sets have a primary key that identifies the entity for which we are collecting features. Note that the primary key of the history table is the same as the base table, but is expanded to include the period of applicability (```ASOS_TS, UNTIL_TS```), which allows it to retain the full history of each feature’s value.

In the Splice Machine feature store, once a feature set is deployed, users can interact with the feature set as a standard relational table using ANSI SQL. As features are updated in the base table, the before-update rows are stored in the corresponding history table to allow for point-in-time feature retrieval that is needed when creating training datasets.

Updates to the feature set base table can take any form that the database supports. Updates can be made using basic SQL CRUD operations, bulk batch loads, real-time streaming, or through native DataFrame APIs via the Native Spark DataSource.

<img class='indentedTightSpacing' src='images/fs_structure.png'>

In this architecture, the feature store API steps out of the interaction model and implicitly manages all features. This greatly reduces complexity and latency, as there is no need to install and invoke the feature store API every time you want to add or retrieve features.


</div>
</section>
