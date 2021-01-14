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

This topic shows you how to use the Splice Machine Feature Store.

{% include splice_snippets/dbaasonlytopic.md %}

This topic is organized into these sections:

* [*Getting Started*](#getting_started)
* [*Feature Set*](#feature_set)
* [*Feature*](#feature)
* [*Training View*](#training_view)
* [*Training Set*](#training_set)
* [*Deployment*](#deployment)
* [*Point in time consistency*](#point_in_time)



# Getting Started  {#getting_started}
To start using the feature store, in your Splice Machine workspace, inside of your Jupyter Notebooks, run the following:
```
from pyspark.sql import SparkSession
from splicemachine.spark import PySpliceContext
from splicemachine.mlflow_support import *
from splicemachine.features import FeatureStore

spark = SparkSession.builder.getOrCreate() # Start Spark
splice = PySpliceContext(spark) # Native Spark Datasource
fs = FeatureStore(splice) # Feature Store
mlflow.register_splice_context(splice) # Link mlflow with the database
mlflow.register_feature_store(fs) # Link mlflow with feature store
```
All of the components above can work separately, but when combined bring added lineage and governance to the ML and Data workflow. One you register the Feature Store with mlflow, the work you do in building models using training datasets from the Feature Store will be tracked automatically and implicitly with mlflow.

# Feature Set {#feature_set}

## Definition
A feature set is a grouping of features, typically created from a single pipeline and from a single data source, although the user can organize their feature sets in whatever way works for them.

## Design
What is fundamentally different about Splice Machines Feature Store is how users add data to their feature sets.

In other Feature Stores, all interactions with the feature store must go through the custom feature store API. To add data to a feature set, users must reference the feature store API/SDK inside their data pipelines. Something similar to:
```
featureset.add_to_featureset(dataframe)
```

In the Splice Machine Feature Store, Features and Feature Sets are defined via the Feature Store API, and the population of those Feature Sets is made available to the user in any format that is supported by the Splice Machine database. This can be through a Kafka topic with Spark Streaming, a Nifi Job using a JDBC/ODBC connection, or raw SQL that is performing aggregations and joins.

As values the Feature Set table are updated, the historical values are recorded in the Feature Set History table, which is created and managed automatically by the Feature Store, and made available for point-in-time correct training datasets.

<img class='indentedTightSpacing' src='images/fs_tables.png'>

## API Usage
** TO create a feature set:

[splicemachine.features.feature_set.FeatureSet](https://pysplice.readthedocs.io/en/feature_store_api_cleanup/splicemachine.features.html#splicemachine.features.feature_set.FeatureSet)
```
create_feature_set(schema_name: str, table_name: str, primary_keys: Dict[str, str], desc: Optional[str] = None)
```

This function takes:
* schema_name: Schema name of the feature set table (once deployed)
* table_name: Table name of the feature set table (once deployed)
* primary_keys: a dictionary of primary keys, with a map of {column_name: SQL_data_type}
    * The value must be a valid [SQL data type](https://doc.splicemachine.com/sqlref_datatypes_intro.html)
* desc: An optional (but highly recommended) description of the feature set

This creates and returns a FeatureSet object, and registers the feature set in the feature store metadata, but **does not** create the feature set table for you. You must deploy the feature set to create the table.

To deploy a feature set:
```
deploy_feature_set(feature_set_schema, feature_set_table)
```

From the Feature Store, or

```
deploy()
```

Directly from the returned FeatureSet object. This created the ```schema.table``` in the database, and registers all of the Features that belong to this feature set. Before deploying a feature set, you should add your [features](#feature) to it.

As you can see, this API structure helps you build metadata about your Features and Feature Sets, and then steps aside to allow for direct access to the underlying SQL tables. This can drastically reduce complexity and latency in the Feature Store. Once deployed, data can enter the feature set by any means most convenient to the data engineer/data scientist.

<img class='indentedTightSpacing' src='images/fs_structure.png'>

Limitations:
* Users cannot delete a feature set. This is coming in a later version
* Users cannot alter a feature set after deployment. This means users cannot add or delete features. This is coming in a later version

# Feature {#features}

## Definition
The feature is the smallest unit of measure in the feature store. This represents a single data point. An example of a Feature is a 30 Day rolling average of purchases for a customer.

## API Usage
Currently, you can create a feature and view/access a feature. You cannot yet delete a feature; that is coming in the next release.

To create a feature:

```
create_feature(schema_name: str, table_name: str, name: str, feature_data_type: str, feature_type: splicemachine.features.constants.FeatureType, desc: Optional[str] = None, tags: Optional[List[str]] = None)
```

This function takes:
* schema_name: The schema of the feature set to add the feature to
* table_name: The table of the feature set to add the feature to
* name: The name of the feature
* feature_data_type: The data type of this feature. This must be a valid [SQL data type](https://doc.splicemachine.com/sqlref_datatypes_intro.html)
* feature_type: the type of the feature (ordinal, continuous, nominal). You can pass in a valid splicemachine.feature.FeatureType by running:
    ```
    from splicemachine.features import FeatureType
    print(FeatureType.get_valid())
    ```
* desc: An optional (but strongly recommended) description of your feature
* tags: An optional (but strongly recommended) list of tags to search for your feature

Limitations:
* You can only add a feature to a feature set that has not been deployed yet
* You cannot yet remove a feature
* Automated backfill of features is coming in a future release

# Training View {#training_view}

## Definition
A Training View is the means by which a data scientist/data engineer combines features across feature sets alongside data outside the Feature Store (if your label exists externally). Training Views ensure [point-in-time consistent](#point_in_time) datasets for model training. The metadata of a Training View is stored in the feature store and can be used to create many training datasets.

When using a Training View to create a Training Set, the training dataset itself is not persisted, only metadata about how to create it upon request. This removes any data duplication, and allows users to utilize the same Training View to access *different* training datasets, both in the features requested as well as the time windows desired.

A Training View can query across Feature Sets, and incorporate database tables that are [not in the Feature Store](#outside_fs). These database tables can be tables inside the Splice Machine database, or external tables from sources such as S3, Snowflake, or any JDBC enabled or Object Data Stores. Arbitrary SQL is available so users can define arbitrary labels and construct fully customizable training datasets (that the Feature Store ensures will be time consistent).

The user provides the SQL to generate the labeled event across arbitrary tables. When the user provides this SQL, and identifies the Join Key Columns, the Label Column, and the Event Timestamp column, the Feature Store automatically joins the requested Features from the Feature store across time.

<img class='indentedTightSpacing' src='images/training_sql.png'>

## Example
Let’s take an example with 2 Feature Sets in the Feature Store and another table that is outside the Feature Store. As a data scientist, we want to create a product recommendation model based on user search clicks, past spending profile, and customer demographics.

The data engineers in our team have created 2 Feature Sets already and they are being populated by 2 different data pipelines. The two Feature Sets are:

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

External to the Feature Store, we have 2 tables (either on Splice Machine, or potentially on Snowflake, S3, or Redshift etc).

One table contains every click that a customer made on the storefront application.
```
RetailExternal.ClickEvents
```
The second table contains customer purchase history.
```
RetailExternal.CustomerPurchases
```

We’d now like to create a Training View that allows us to later create training datasets using Features from both of the Feature Sets mentioned above.

In order to use the Features from both Feature Sets, the SQL provided to the Training View must have the key columns of each individual Feature Set. Feature Sets do not need to share join keys, but the table(s) queried by the Training View must have them.

To illustrate this, in order to use the Features in **Retail.CustomerDemographics** the Training View SQL must have the column **customer_id**.

In order to join Retail.CustomerRFM the Training View SQL must have both columns customer_id and product_category.

## Using data from outside the feature store {#outside_fs}

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
* join_keys = ```[CUSTOMER_ID,PRODUCT_CATEGORY]``` # The keys of any Feature Set whose Features you wish to join

When we pass this information to the Feature Store, it will persist this metadata and the SQL query itself. When a user now wants to create a training dataset, they can simply call:
```
fs.get_training_set_from_view(name=’recommendation_purchase_search_events’)
```

And that will return a Spark dataframe with all of the available Features and the label of each event.

If the user instead wants a subset of Features for their model, they can pass in a list of Features to this query and receive just those features in their dataframe:
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
What we see here is that the Feature Store provides 100% flexibility for creating fully custom Training instances for model development. Users can define their labels in as simple or advanced terms as required for the task at hand. And the user needs only to define this once, as the result will be persisted and other data scientists can pick and choose individual features from the Training View, which will be automatically aligned with the label in a [point-in-time consistent](#point_in_time) manner.

## API Usage
To create the TrainingView, we call:
```
create_training_view(name: str, sql: str, primary_keys: List[str], join_keys: List[str], ts_col: str, label_col: Optional[str] = None, replace: Optional[bool] = False, desc: Optional[str] = None, verbose=False) → None
```

Which takes:
* name: The name of the Training View
* sql: the Training SQL as described above
* primary_keys: The columns from the provided SQL that are the unique identifiers of the query
* join_keys: The join keys from the provided SQL to the Feature Sets. These keys must be the same in name to the primary keys of the desired Feature Sets
* ts_col: The timestamp column of the provided SQL to run point in time consistent joins across features
* label_col: The column of the provided SQL that represents the label
* replace: An optional boolean to replace the Training View. This current has no effect
* desc: An optional (but highly recommended) description for the Training View
* verbose: An optional boolean deciding whether or not to print the SQL that is automatically generated before executing it.

Limitations:
* You cannot delete or otherwise alter a Training View. This is coming in a later release


# Training Set {#training_set}

## Definition
A Training Set can be thought of as a Training View across a specific time window with a selected set of features. When a Training View is paired with a time window and set of desired features, the Feature Store generated the proper query and returns a distributed Spark Dataframe using the Native Spark Datasource.

Additionally, when a user is using the Splice Machine Feature Store in combination with Splice Machine’s enhanced MLflow, the requested Training Set, Feature selection, and time window will be logged to the active MLflow run, or the next created MLflow run automatically. This ensures that users can track the data that was used to train their models.

When a user later deploys that particular model, this action will be recorded by the Feature Store as a deployment, with the time window, desired features, run ID, as well as Training View ID, for further tracking and governance.

### What if my training dataset doesn’t need the label? Or the historical features? What about clustering?

There are scenarios in which a data scientist simply needs features from the Feature Store and nothing else. This could be in a case where the label is another Feature in the Feature store, or in a simple clustering example, trying to segment different types of customers or transactions. A data scientist or data engineer may simply want to build a KNN or K-means clustering algorithm based on the feature vectors defined across different Feature Sets. A Feature Store should enable this functionality, and it should be tracked implicitly in the same way. In Splice Machine’s Feature Store, this can be attained with the ```get_training_set``` function, definition below.

The way point-in-time correctness is guaranteed with ```get_training_set``` (where no Training View is provided) is by choosing one of the Feature Sets as the “anchor” dataset. This means that the points in time that the query is based off of will be the points in time in which the anchor Feature Set recorded changes. The anchor Feature Set is the Feature Set that contains the superset of all primary key columns across all Feature Sets from all Features provided. If more than 1 Feature Set has the superset of all Feature Sets, the Feature Set with the most primary keys is selected. If more than 1 Feature Set has the same maximum number of primary keys, the Feature Set is chosen by alphabetical order (schema_name, table_name).

## API Usage
```
get_training_set_from_view(training_view: str, features: Union[List[splicemachine.features.feature.Feature], List[str]], start_time: Optional[datetime.datetime] = None, end_time: Optional[datetime.datetime] = None, return_sql: bool = False) → pyspark.sql.dataframe.DataFrame
```

Which takes:
* training_view – (str) The name of the registered Training View
* features – (List[str] OR List[Feature]) the list of features from the feature store to be included in the training. If a list of strings is passed in it will be converted to a list of Feature
    * NOTE: This function will error if the Training View SQL is missing a join key required to retrieve the desired features
* start_time – (Optional[datetime]) The start time of the query (how far back in the data to start). Default None
    * NOTE: If start_time is None, query will start from beginning of history
* end_time – (Optional[datetime]) The end time of the query (how far recent in the data to get). Default None
    * NOTE: If end_time is None, query will get most recently available data
* return_sql – (Optional[bool]) Return the SQL statement (str) instead of the Spark DF. Defaults False

```
get_training_set(features: Union[List[splicemachine.features.feature.Feature], List[str]], current_values_only: bool = False, start_time: Optional[datetime.datetime] = None, end_time: Optional[datetime.datetime] = None, return_sql: bool = False) → pyspark.sql.dataframe.DataFrame
```


Which takes:
* features – (List[str] OR List[Feature]) the list of features from the feature store to be included in the training. If a list of strings is passed in, they are interpreted as a list of feature namesFeatures
    * NOTE: The Features Sets which the list of Features come from must have a common join key, otherwise the function will fail. If there is no common join key, it is recommended to create a Training View to specify the join conditions.
* current_values_only -- If you only want the most recent values of the features, set this to true. Otherwise, all history will be returned. Default False
* start_time – How far back in history you want Feature values. If not specified (and current_values_only is False), all history will be returned. This parameter only takes effect if current_values_only is False.
* end_time – The most recent values for each selected Feature. This will be the cutoff time, such that any Feature values that were updated after this point in time won’t be selected. If not specified (and current_values_only is False), Feature values up to the moment in time you call the function (now) will be retrieved. This parameter only takes effect if current_values_only is False.

### Note on tracking Training Sets:

When you ```register_feature_store``` with mlflow, Training Set usage will be implicitly logged for you during active runs. When calling get_training_set or get_training_set from view, mlflow will recognize the new active Training Set and log it automatically. This, however, comes with a few limitations.

If you call fs.get_training_set or fs.get_training_set_from_view **before** starting an mlflow run, all **following** runs will assume that Training Set to be the active Training Set, and will log that Training Set as metadata.

Alternatively, if you do **not** have any active runs and **begin a new run** any subsequent calls to fs.get_training_set or fs.get_training_set_from_view will set the resulting Training Set as the active Training Set, and all following runs will assume (and log) the same.

This means that if you, for example, run the following:
```
fs.get_training_set()
mlflow.start_run()
fs.get_training_set()
```
You will see an error message because you cannot get a new active Training Set during an active run.

## Limitations
* The user must manually call ```mlflow.register_feature_store(fs)``` before making any calls ```get_training_set``` or ```get_training_set_from_view``` if they want the training set usage to be tracked in mlflow automatically.
* It is assumed that the set of Features retrieved from the call to ```get_training_set``` or ```get_training_set_from_view``` is the full set of Features being used for model training.
    * If the user calls either ```get_training_set``` or ```get_training_set_from_view``` in the context of an MLFlow run, and then uses only a subset of the features from the training dataset, this model will be tracked with a *superset of the Features used*.

# Deployment {#deployment}

## Definition
A deployment from the perspective of the Feature Store is the case when a user deploys a model built and tracked in Splice Machine’s enhanced MLFlow environment which was trained using a training dataset from the Feature Store. If users are using the Splice Machine Feature Store without the Splice Machine enhanced MLFlow environment, this concept is not needed and will not be utilized.

For users using the full Splice Machine ML Manager suite, models deployed using Training Datasets from the Feature Store are fully tracked, and statistics on the live changes of features associated to the deployed model are calculated regularly.

## API Usage
There is no explicit API call for this concept, but merely an implicit tracking of the Training Dataset used in a run when the call to
```mlflow.deploy_db``` is called.

## Limitations
* This does not yet track ```mlflow.deploy_kubernetes``` deployments, but this is coming very soon!

# Point in time consistency {#point_in_time}

When training Machine Learning models, it is crucial that you construct your dataset as it would have existed at the time of inference. This means aligning the valid values of features with each label as time progresses.

As we’ve seen in our section on [Training Views](#training_view), you can create Training Sets over time by providing a parameterized SQL statement, and parameterizing the desired features, label column, timestamp column, and join key columns.

The Splice Machine Feature Store manages point-in-time consistency by creating timestamp based joins across the Features in the Feature Sets, as the Feature Store knows which columns are the timestamp columns.

The Feature Store saves a history of all prior Feature Values, and keeps timestamp tracking at the Feature Level granularity, instead of the Feature Set level granularity like many other Feature Stores. This enables a more dynamic and flexible time based join.

As seen above, when creating a Training View, a user provides an arbitrary SQL statement (which is validated by the Feature Store) and declaratively defines the inference timestamp column (along with others). Under the hood, this view SQL is fed into a larger SQL query constructed by the Feature Store to bring together (or coalesce) the historical values of each desired Feature from each Feature Set, aligning the proper inference timestamps with the Feature values to construct Feature Vectors that would have been available at the time of inference. This ensures there is no data leakage or bias in Training Datasets.

<img class='indentedTightSpacing' src='images/fs_sql.png'>

<img class='indentedTightSpacing' src='images/point_in_time_tables.png'>

## Serving
Another requirement of a production Feature Store is millisecond Feature vector serving for real-time use cases. When serving models in real-time, it’s crucial to be able to retrieve the relevant (and most up to date) Feature values to feed into your models. If retrieval of Feature values takes too long, you may not be able to run particular models in real-time. Likewise, if the Feature values you retrieve are not guaranteed to be the most up to date, you may end up with different behavior in development than production.

## API Usage
To retrieve a particular feature vector, you call the ```get_feature_vector``` or the ```get_feature_vector_sql_from_training_view``` APIs.

The ```get_feature_vector``` API retrieves an arbitrary set of Feature values, given a list of desired Features as well as a dictionary of join key values to join the Features on. This function can return either a Dataframe (for usage in development), or the SQL used to generate this Dataframe. The SQL should be used in real-time applications, wherein the application calls the API once, and stores the SQL as a stored procedure for millisecond Feature vector retrieval.

The ```get_feature_vector_sql_from_training_view``` API is similar, but only returns SQL. In this API, there is no need to provide the join_key_values as they are already encapsulated in the provided Training View, so only a list of desired Features is required.

```
get_feature_vector(features: List[Union[str, splicemachine.features.feature.Feature]], join_key_values: Dict[str, str], return_sql=False) → Union[str, pandas.core.frame.DataFrame]
```

This function takes:
* features – List of str Feature names or Features
* join_key_values – (dict) join key vals to get the proper Feature values formatted as {join_key_column_name: join_key_value}
* return_sql – Whether to return the SQL needed to get the vector or the values themselves. Default False


```
get_feature_vector_sql_from_training_view(training_view: str, features: List[splicemachine.features.feature.Feature]) → str
```
This function takes:
* training_view – (str) The name of the registered training view
* features –(List[str]) the list of features from the feature store to be included in the training
    * note- This function will error if the Training View SQL is missing a view key(s) required to retrieve the desired features


</div>
</section>
