---
title: Using the Splice Machine Feature Store
summary: Overview of using the Feature Store
keywords: feature store
toc: false
product: all
sidebar: home_sidebar
permalink: featurestore_using.html
folder: FeatureStore
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Using the Splice Machine Feature Store

This topic is organized into these sections:

* [*Getting Started*](#getting_started)
* [*Feature Set*](#feature_set)
* [*Feature*](#feature)
* [*Training View*](#training_view)
* [*Training Set*](#training_set)
* [*Deployment*](#deployment)
* [*Point in time consistency*](#point_in_time)



# Getting Started  {#getting_started}
To start using the feature store, run the following in Jupyter Notebooks in your Splice Machine workspace:
```
from pyspark.sql import SparkSession
from splicemachine.spark import PySpliceContext
from splicemachine.MLFlow_support import *
from splicemachine.features import FeatureStore

spark = SparkSession.builder.getOrCreate() # Start Spark
splice = PySpliceContext(spark) # Native Spark Datasource
fs = FeatureStore(splice) # feature store
MLFlow.register_splice_context(splice) # Link MLFlow with the database
MLFlow.register_feature_store(fs) # Link MLFlow with feature store
```
All of the components above can work separately, but when combined they provide additional lineage and governance to the ML and Data workflow. Once you register the feature store with MLFlow, models built using training datasets from the feature store will be tracked automatically and implicitly with MLFlow.

# Feature Set {#feature_set}

## Definition
A feature set is a group of features, typically created from a single pipeline and a single data source, but you can organize your feature sets however you want.

## Design
The fundamental difference between the Splice Machine feature store and other feature stores is how users add data to their feature sets.

In other feature stores, all interactions with the feature store must go through the custom feature store API. To add data to a feature set, users must reference the feature store API/SDK inside their data pipelines. Something similar to:
```
featureset.add_to_featureset(dataframe)
```

In the Splice Machine feature store, features and feature sets are defined via the feature store API, and the contents of those feature sets is made available to the user in any format that is supported by the Splice Machine database. This can be through a Kafka topic with Spark Streaming, a NiFi Job using a JDBC/ODBC connection, or raw SQL that is performing aggregations and joins.

As values in the feature set table are updated, the historical values are recorded in the feature set history table, which is created and managed automatically by the feature store, and is made available for accurate point-in-time training datasets.

<img class='indentedTightSpacing' src='images/fs_tables.png'>

## API Usage

**To create a feature set:**

Refer to [splicemachine.features.feature_store.FeatureStore.create_feature_set](https://pysplice.readthedocs.io/en/latest/splicemachine.features.html#splicemachine.features.feature_store.FeatureStore.create_feature_set).

```
create_feature_set(schema_name: str, table_name: str, primary_keys: Dict[str, str], desc: Optional[str] = None)
```

This function takes:
* schema_name – The schema name of the feature set table (once deployed).
* table_name – The name of the feature set table (once deployed).
* primary_keys – A dictionary of primary keys, with a map of {column_name: SQL_data_type}. This value must be a valid <a href="sqlref_datatypes_intro.html">SQL data type</a>.
* desc – An optional (but highly recommended) description of the feature set.

This function creates and returns a FeatureSet object, and registers the feature set in the feature store metadata, but **does not** create the feature set table. You must deploy the feature set to create the table.

**To deploy a feature set:**

To deploy from the feature store:

```
deploy_feature_set(feature_set_schema, feature_set_table)
```

Or to deploy directly from the returned FeatureSet object:

```
deploy()
```

This creates the `schema.table` in the database, and registers all of the Features that belong to this feature set. Before deploying a feature set, you should add your [features](#feature) to it.

This API structure helps you build metadata for your features and feature sets, and allows direct access to the underlying SQL tables. This can drastically reduce complexity and latency in the feature store. Once deployed, data can enter the feature set by any means most convenient to the data engineer or data scientist.

<img class='indentedTightSpacing' src='images/fs_structure.png'>

Limitations:
* Currently, feature sets cannot be deleted. This capability is planned for a future release.
* Currently, a feature set cannot be altered after deployment. This means you cannot add or delete features after deploying a feature set. This capability is planned for a future release.

# Feature {#feature}

## Definition
The feature is the smallest unit of measure in the feature store, and represents a single data point. An example of a feature is a 30-day rolling average of customer purchases.

## API Usage
Currently, you can create and view/access a feature, but you cannot delete a feature. This capability is planned for a future release.

**To create a feature:**

```
create_feature(schema_name: str, table_name: str, name: str, feature_data_type: str, feature_type: splicemachine.features.constants.FeatureType, desc: Optional[str] = None, tags: Optional[List[str]] = None)
```

This function takes:
* schema_name – The schema of the feature set in which the feature will be added.
* table_name – The name of the feature set table for the feature.
* name – The feature name.
* feature_data_type – The data type of the feature. This must be a valid <a href="sqlref_datatypes_intro.html">SQL data type</a>.
* feature_type – The type of the feature (ordinal, continuous, nominal). You can pass in a valid `splicemachine.feature.FeatureType` by running:

    ```
    from splicemachine.features import FeatureType
    print(FeatureType.get_valid())
    ```
* desc – An optional (but highly recommended) description of the feature.
* tags – An optional (but strongly recommended) list of search tags to search for the feature.

Limitations:
* You can only add a feature to a feature set that has not been deployed.
* You cannot remove a feature.
* Automated backfill of features is planned for a future release.

# Training View {#training_view}

## Definition

A training view is the means by which a data scientist or data engineer combines features across feature sets alongside data outside of the feature store (if your label exists externally). Training views ensure [point-in-time consistent](#point_in_time) datasets for model training. The metadata of a training view is stored in the feature store and can be used to create many training datasets.

When using a training view to create a training set, the training dataset itself is not persisted – only metadata about how to create it upon request is persisted. This removes any data duplication, and allows users to use the same training view to access *mulitple* training datasets, both in the features requested as well as the desired time windows.

A training view can query across feature sets, and incorporate database tables that are [not in the feature store](#outside_fs). These database tables can be tables inside the Splice Machine database, or external tables from sources such as S3, Snowflake, or any JDBC enabled or object data stores. Arbitrary SQL is available so users can define arbitrary labels and construct fully customizable training datasets (that the feature store ensures will be time consistent).

The user provides the SQL to generate the labeled event across arbitrary tables. When the user provides this SQL and identifies the Join Key columns, the Label column, and the Event Timestamp column, the feature store automatically joins the requested features from the feature store across time.

<img class='indentedTightSpacing' src='images/training_sql.png'>

## Example
Let’s use an example with two feature sets in the feature store and another table that is outside of the feature store. As data scientists, we want to create a product recommendation model based on user search clicks, past spending profile, and customer demographics.

The data engineers on our team have already created two feature sets, and they are being populated by two different data pipelines. The two feature sets are:

1. Retail.CustomerRFM
   * schema_name = Retail
   * table_name = CustomerRFM
   * primary_keys = {customer_id: INTEGER, product_category: VARCHAR(150)}
   * desc = The Recency, Frequency and Monetary aggregations by customer for 1, 7, 14, 30 and 90 day windows of purchasing behavior of a product category
2. Retail.CustomerDemographics
   * schema_name = Retail
   * table_name = CustomerDemographics
   * primary_keys = {customer_id: INTEGER}
   * desc = The age, gender, location, number of children, highest education for each customer

External to the feature store, we have two tables (either on Splice Machine, or potentially on Snowflake, S3, Redshift, etc.).

One table contains every click that a customer made on the storefront application:
```
RetailExternal.ClickEvents
```
The second table contains customer purchase history:
```
RetailExternal.CustomerPurchases
```

Now we would like to create a training view that allows us to later create training datasets using features from both of the feature sets described above.

In order to use the features from both feature sets, the SQL provided to the training view must have the key columns of each individual feature set. Feature sets do not need to share join keys, but the table(s) queried by the training view must have them.

To illustrate this, in order to use the features in `Retail.CustomerDemographics` the Training View SQL must have the column `customer_id`.

In order to join `Retail.CustomerRFM` the training view SQL must have both the `customer_id` and `product_category` columns.

## Using data from outside of the feature store {#outside_fs}

Now that we have the table needed and known Join Key columns, we can create our Training View SQL:
```
SELECT
  t1.SESSION_ID, t1.EVENT_TIMESTAMP, t1.CUSTOMER_ID, t1.PRODUCT_CATEGORY,
  CASE
    WHEN t2.PRODUCT_ID in (t1.PRODUCT_LIST) THEN True
    ELSE False
  END as PRODUCT_WAS_PURCHASED -- Our label
FROM
  RetailExternal.ClickEvents t1,
  RetailExternal.CustomerPurchases t2
WHERE t1.SESSION_ID = t2.SESSION_ID
AND t1.CLICK_TYPE = ‘search’
```

In this example, we can parameterize our SQL using the ```create_training_view``` function by stating:
* name = recommendation_purchase_search_events
* label_col = ```PRODUCT_WAS_PURCHASED```
* primary_keys = ```[SESSION_ID, EVENT_TIMESTAMP]``` # Unique identifier of a row from the provided SQL
* ts_col = ```EVENT_TIMESTAMP```
* join_keys = ```[CUSTOMER_ID,PRODUCT_CATEGORY]``` # The keys of any feature set whose features you wish to join

When we pass this information to the feature store, it will persist this metadata and the SQL query itself. When a user now wants to create a training dataset, they can simply call:

```
fs.get_training_set_from_view(name=’recommendation_purchase_search_events’)
```

This will return a Spark dataframe with all of the available features and the label of each event.

If the user instead wants a subset of features for their model, they can pass in a list of features to this query and receive only those features in their dataframe:

```
fs.get_training_set_from_view(
  name=‘recommendation_purchase_search_events’,
  features=[
    ‘monetary_1d_agg’,
    ‘monetary_30d_agg’,
    ‘age’,
    ‘highest_education’
    ]
)
```

The feature store provides 100% flexibility for creating fully customized training instances for model development. Users can define their labels in as simple or complex terms as required for the task at hand. And the user needs only to define this once, as the result will be persisted and other data scientists can pick and choose individual features from the training view, which will be automatically aligned with the label in a [point-in-time consistent](#point_in_time) manner.

## API Usage
To create the TrainingView, we call:

```
create_training_view(name: str, sql: str, primary_keys: List[str], join_keys: List[str], ts_col: str, label_col: Optional[str] = None, replace: Optional[bool] = False, desc: Optional[str] = None, verbose=False) → None
```

Which takes:

* name – The name of the training view.
* sql – The training SQL as described above.
* primary_keys – The columns from the provided SQL that are the unique identifiers of the query.
* join_keys – The join keys from the provided SQL to the feature sets. These keys must have the same name as the primary keys of the desired feature sets.
* ts_col – The timestamp column of the provided SQL to run point in time consistent joins across features.
* label_col – The column of the provided SQL that represents the label.
* replace – An optional boolean to replace the training view. This currently has no effect.
* desc – An optional (but highly recommended) description for the training view.
* verbose – An optional boolean specifying whether or not to print the SQL that is automatically generated before executing it.

Limitations:
* You cannot delete or otherwise alter a training view. This is planned for a future release.


# Training Set {#training_set}

## Definition
A training set can be thought of as a training view across a specific time window with a selected set of features. When a training view is paired with a time window and set of desired features, the feature store generates the proper query and returns a distributed Spark Dataframe using the Native Spark DataSource.

Additionally, when a user is using the Splice Machine feature store in combination with Splice Machine’s enhanced MLFlow, the requested training set, feature selection, and time window will be automatically logged to the active MLFlow run, or the next created MLFlow run. This ensures that users can track the data that was used to train their models.

When a user later deploys that particular model, this action will be recorded by the feature store as a deployment, with the time window, desired features, run ID, and training view ID, for further tracking and governance.

### What if my training dataset doesn’t need the label? Or the historical features? What about clustering?

There are scenarios in which a data scientist simply needs features from the feature store and nothing else. This could be in a case where the label is another feature in the feature store, or in a simple clustering example, trying to segment different types of customers or transactions. A data scientist or data engineer may simply want to build a KNN or K-means clustering algorithm based on the feature vectors defined across different feature sets. A feature store should enable this functionality, and it should be tracked implicitly in the same way. In the Splice Machine feature store, this can be achieved using the `get_training_set` function defined below.

Point-in-time correctness is guaranteed with `get_training_set` (where no training view is provided) by choosing one of the feature sets as the “anchor” dataset. This means that the points in time that the query is based on will be the points in time in which the anchor feature set recorded changes. The anchor feature set is the feature set that contains the superset of all primary key columns across all feature sets from all features provided. If more than one feature set has the superset of all feature sets, the feature set with the most primary keys is selected. If more than one feature set has the same maximum number of primary keys, the feature set is chosen by alphabetical order (schema_name, table_name).

## API Usage
```
get_training_set_from_view(training_view: str, features: Union[List[splicemachine.features.feature.Feature], List[str]], start_time: Optional[datetime.datetime] = None, end_time: Optional[datetime.datetime] = None, return_sql: bool = False) → pyspark.sql.dataframe.DataFrame
```

Which takes:
* training_view – (str) The name of the registered training view.
* features – (List[str] OR List[Feature]) The list of features from the feature store to be included in the training. If a list of strings is passed in it will be converted to a list of features.
    * NOTE: This function will error if the training view SQL is missing a join key required to retrieve the desired features.
* start_time – (Optional[datetime]) The start time of the query (how far back in the data to start). The default is None.
    * NOTE: If start_time is None, the query will start from beginning of history.
* end_time – (Optional[datetime]) The end time of the query (how far recent in the data to get). The default is None.
    * NOTE: If end_time is None, the query will get the most recently available data.
* return_sql – (Optional[bool]) Return the SQL statement (str) instead of the Spark DF. The default is False.

```
get_training_set(features: Union[List[splicemachine.features.feature.Feature], List[str]], current_values_only: bool = False, start_time: Optional[datetime.datetime] = None, end_time: Optional[datetime.datetime] = None, return_sql: bool = False) → pyspark.sql.dataframe.DataFrame
```


Which takes:
* features – (List[str] OR List[Feature]) the list of features from the feature store to be included in the training. If a list of strings is passed in, they are interpreted as a list of feature namesFeatures.
    * NOTE: The features sets that the list of features come from must have a common join key, otherwise the function will fail. If there is no common join key, it is recommended that you create a training view to specify the join conditions.
* current_values_only -- If you only want the most recent values of the features, set this to true. Otherwise, all history will be returned. The default is False.
* start_time – How far back in history you want feature values. If not specified (and current_values_only is False), all history will be returned. This parameter only takes effect if current_values_only is False.
* end_time – The most recent values for each selected feature. This will be the cutoff time, such that any feature values that were updated after this point in time will not be selected. If not specified (and current_values_only is False), feature values up to the moment in time you call the function (now) will be retrieved. This parameter only takes effect if current_values_only is False.

### Note on tracking training sets:

When you `register_feature_store` with MLFlow, training set usage will be implicitly logged for you during active runs. When calling `get_training_set` or `get_training_set_from_view`, MLFlow will recognize the new active training set and log it automatically. However, this comes with a few limitations.

If you call `fs.get_training_set` or `fs.get_training_set_from_view` **before** starting an MLFlow run, all **following** runs will assume that training set to be the active training set, and will log that training set as metadata.

Alternatively, if you do **not** have any active runs and begin a new run, any subsequent calls to `fs.get_training_set` or `fs.get_training_set_from_view` will set the resulting training set as the active training set, and all following runs will assume (and log) the same.

For example, if you run the following:
```
fs.get_training_set()
MLFlow.start_run()
fs.get_training_set()
```
You will see an error message because you cannot get a new active training set during an active run.

## Limitations
* You must manually call ```MLFlow.register_feature_store(fs)``` before making any calls using ```get_training_set``` or ```get_training_set_from_view``` if you want the training set usage to be tracked in MLFlow automatically.
* It is assumed that the set of features retrieved from the call to ```get_training_set``` or ```get_training_set_from_view``` is the full set of features being used for model training.
    * If you call either ```get_training_set``` or ```get_training_set_from_view``` in the context of an MLFlow run, and then use only a subset of the features from the training dataset, this model will be tracked with a *superset of the Features used*.

# Deployment {#deployment}

## Definition
From the perspective of the feature store, a deployment is the case when a user deploys a model built and tracked in Splice Machine’s enhanced MLFlow environment which was trained using a training dataset from the feature store. If users are using the Splice Machine feature store without the Splice Machine enhanced MLFlow environment, this concept is not needed and will not be utilized.

For users using the full Splice Machine ML Manager suite, models deployed using training datasets from the feature store are fully tracked, and statistics on the live changes of features associated with the deployed model are calculated regularly.

## API Usage
There is no explicit API call for this concept, but simply an implicit tracking of the training dataset used in a run when the call to
```MLFlow.deploy_db``` is called.

## Limitations
* Currently this does not track ```MLFlow.deploy_kubernetes``` deployments, but this is planned for a future release.

# Point in time consistency {#point_in_time}

When training Machine Learning models, it is crucial that you construct your dataset as it would have existed at the time of inference. This means aligning the valid values of features with each label as time progresses.

As we’ve seen in our section on [training views](#training_view), you can create training sets over time by providing a parameterized SQL statement, and parameterizing the desired features, label column, timestamp column, and join key columns.

The Splice Machine feature store manages point-in-time consistency by creating timestamp-based joins across the features in the feature sets, as the feature store knows which columns are the timestamp columns.

The feature store saves a history of all prior feature values, and keeps timestamp tracking at the feature level granularity, instead of the feature set level granularity with many other feature stores. This enables a more dynamic and flexible time-based join.

As seen above, when creating a training view, a user provides an arbitrary SQL statement (which is validated by the feature store) and declaratively defines the inference timestamp column (along with others). Under the hood, this view SQL is fed into a larger SQL query constructed by the feature store to bring together (or coalesce) the historical values of each desired feature from each feature set, aligning the proper inference timestamps with the feature values to construct feature vectors that would have been available at the time of inference. This ensures there is no data leakage or bias in training datasets.

<img class='indentedTightSpacing' src='images/fs_sql.png'>

<img class='indentedTightSpacing' src='images/point_in_time_tables.png'>

## Serving
Another requirement of a production feature store is millisecond feature vector serving for real-time use cases. When serving models in real-time, it is crucial to be able to retrieve the relevant (and most up to date) feature values to feed into your models. If retrieval of feature values takes too long, you may not be able to run particular models in real-time. Likewise, if the feature values you retrieve are not guaranteed to be the most up to date, you may end up with different behavior in development than production.

## API Usage
To retrieve a particular feature vector, you call the ```get_feature_vector``` or the ```get_feature_vector_sql_from_training_view``` APIs.

The ```get_feature_vector``` API retrieves an arbitrary set of feature values, given a list of desired features, as well as a dictionary of join key values to join the features on. This function can return either a dataframe (for use in development), or the SQL used to generate this dataframe. The SQL should be used in real-time applications, wherein the application calls the API once, and stores the SQL as a stored procedure for millisecond feature vector retrieval.

The ```get_feature_vector_sql_from_training_view``` API is similar, but only returns SQL. In this API, there is no need to provide the join_key_values as they are already encapsulated in the provided training view, so only a list of desired Features is required.

```
get_feature_vector(features: List[Union[str, splicemachine.features.feature.Feature]], join_key_values: Dict[str, str], return_sql=False) → Union[str, pandas.core.frame.DataFrame]
```

This function takes:
* features – List of str feature names or features.
* join_key_values – (dict) join key vals to get the proper feature values formatted as {join_key_column_name: join_key_value}
* return_sql – Whether to return the SQL needed to get the vector or the values themselves. The default is False.


```
get_feature_vector_sql_from_training_view(training_view: str, features: List[splicemachine.features.feature.Feature]) → str
```
This function takes:
* training_view – (str) The name of the registered training view.
* features –(List[str]) The list of features from the feature store to be included in the training.
    * Note - This function will error if the training view SQL is missing a view key(s) required to retrieve the desired features.


</div>
</section>
