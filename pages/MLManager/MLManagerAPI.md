---
title: Splice Machine ML Manager API
summary: The ML Manager API
keywords: data science, machine learning
toc: false
product: all
sidebar: mlmanager_sidebar
permalink: mlmanager_api.html
folder: MLManager
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# The Splice ML Manager API

This topic describes the methods available in the ML Manager API; you'll find examples of each of these in the [Using ML Manager](mlmanager_using.html) topic, in this chapter.

You can use Splice ML Manager with Python in Zeppelin notebooks, using  our `pyspark` interpreter and our `MLManager` class in your program to manipulate experiments.

This topic contains the following sections:

* [ML Manager Methods](#methods)
* [Getting Started with the ML Manager API](#getstarted)


## ML Manager Methods  {#methods}

This section describes the methods of the `MLManager` class.

### create_experiment

Use the `create_experiment` method to create and name an experiment.

```
manager.create_experiment( experiment_name )
```
{: .FcnSyntax}

<div class="paramList" markdown="1">
experiment_name
{: .paramName}

A string name you want to use for the experiment.
{: .paramDefnFirst}
</div>

<div class="indented" markdown="1">
Example:

```
manager.create_experiment( 'myFirstExperiment')
```
{: .Example}
</div>

### set_active_experiment

Use the `set_active_experiment` method to make an existing experiment the active experiment.

```
manager.set_active_experiment( experiment_name )
```
{: .FcnSyntax}

<div class="paramList" markdown="1">
experiment_name
{: .paramName}

A string name you want to use for the experiment.
{: .paramDefnFirst}
</div>

<div class="indented" markdown="1">
Example:

```
manager.set_active_experiment( myFirstExperiment)
```
{: .Example}
</div>

### create_new_run

Use the `create_new_run` method to name and make active (start) a new run.

```
manager.create_new_run( run_name )
```
{: .FcnSyntax}

<div class="paramList" markdown="1">
run_name
{: .paramName}

A string name to use for the run.
{: .paramDefnFirst}
</div>

<div class="indented" markdown="1">
Example:

```
manager.create_new_run( 'myFirstRun')
```
{: .Example}
</div>

### log_param

Use the `log_param` method to log a (key, string-value) pair for the currently active run.

```
manager.log_param( param_name, param_value )
```
{: .FcnSyntax}

<div class="paramList" markdown="1">
param_name
{: .paramName}

A string naming the parameter to log.
{: .paramDefnFirst}

param_value
{: .paramName}

The string value to log for the parameter.
{: .paramDefnFirst}

</div>

<div class="indented" markdown="1">
Example:

```
manager.log_param('classifier', 'neural network')
manager.log_param('maxIter', '100')
```
{: .Example}
</div>

### log_metric

Use the `log_metric` method to log a (key, numeric-value) pair for the currently active run. You can update a metric throughout the course of the run, and you can subsequently view the metric's history.

```
manager.log_metric( metric_name, metric_value )
```
{: .FcnSyntax}

<div class="paramList" markdown="1">
metric_name
{: .paramName}

A string naming the metric to log.
{: .paramDefnFirst}

metric_value
{: .paramName}

The double-precision numeric value to log for the metric.
{: .paramDefnFirst}

</div>

<div class="indented" markdown="1">
Example:

```
    #log how long the model took
manager.log_metric('time', time_taken)
```
{: .Example}
</div>

### log_spark_model

Use the `log_spark_model` method to save a MLlib model you've created to MLflow, for future deployment.

```
log_spark_model( model )
```
{: .FcnSyntax}

<div class="paramList" markdown="1">
model
{: .paramName}

The MLlib model object to save.
{: .paramDefnFirst}
</div>


<div class="indented" markdown="1">
Example:

```
    #save the pipeline and model to s3
model.save('s3a://myModels/myFirstModel')
    #save model to MLflow for deployment
manager.log_spark_model(model)
```
{: .Example}
</div>

## Getting Started with the ML Manager API {#getstarted}

To get started with MLManager, you need to:

1. Create your MLManager instance
2. Establish a connection to your database
3. Create an experiment
4. Create a run
5. Run your experiment(s)

### 1. Create your MLManager instance

To use ML Manager, you need to first create a class instance:
```
%spark.pyspark
from splicemachine.ml.management import MLManager
manager = MLManager()
```
{: .Example}
### 2. Connect to Your Database

You can establish a connection to your database using our Native Spark Datasource, which is encapsulated in the `SpliceMLContext` object. Once you've connected, you can use the SpliceMLContext to perform database inserts, selects, upserts, updates and many more functions, all directly from Spark, without any required serialization.


```
%spark.pyspark
from splicemachine.spark.context import SpliceMLContext
splice = SpliceMLContext(spark)
```
{: .Example}
### 3. Create an Experiment

This code creates a new experiment and sets it as the active experiment:
```
%spark.pyspark
manager.create_experiment('myFirstExperiment')
manager.set_active_experiment('myFirstExperiment')
```
{: .Example}
### 4. Create a Run
We use a method of our `MLManager` object to create a new run:
```
manager.create_new_run(user_id=‘firstrun’)
```
{: .Example}

### Run Your Experiment

The [Using ML Manager](mlmanager_using.html) topic in this chapter provides a complete example of running machine learning experiments with ML Manager in a Zeppelin notebook.
</div>
</section>
