---
title: Splice Machine ML Manager API
summary: The ML Manager API
keywords: data science, machine learning
toc: false
product: all
sidebar: home_sidebar
permalink: mlmanager_api.html
folder: MLManager
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# The Splice ML Manager API

This topic describes the methods available in the ML Manager API; you'll find examples of each of these in the [Using ML Manager](mlmanager_using.html) topic, in this chapter.

{% include splice_snippets/dbaasonlytopic.md %}

You can use Splice ML Manager with Python in Jupyter notebooks, using  our `pyspark` interpreter and our `MLManager` class in your program to manipulate experiments.

This topic contains the following sections:

* [Getting Started with the ML Manager API](#getstarted)
* [ML Manager Methods](#methods)


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

The [Using ML Manager](mlmanager_using.html) topic in this chapter provides a complete example of running machine learning experiments with ML Manager in a Jupyter notebook.


## ML Manager Methods  {#methods}

This section describes the methods of the `MLManager` class, in these three subsections:

* [Experiment and Run Methods](#runmethods)
* [Logging Methods](#logmethods)
* [Tagging Methods](#tagmethods)

### Experiment and Run Methods  {#runmethods}
This section describes the ML Manager methods for working with experiments and runs:

* [create_experiment](#createexperiment)
* [create_new_run](#createnewrun)
* [reset_run](#resetrun)
* [set_active_experiment](#setactiveexperiment)
* [set_active_run](#setactiverun)

#### create_experiment  {#createexperiment}

Use the `create_experiment` method to create and name an experiment.

```
manager.create_experiment( experiment_name )
```
{: .FcnSyntax}

<div class="paramList" markdown="1">
experiment_name
{: .paramName}

A string name or integer ID you want to use for the experiment.
{: .paramDefnFirst}
</div>

Example:

```
manager.create_experiment( 'myFirstExperiment')
```
{: .Example }


#### create_new_run  {#createnewrun}

Use the `create_new_run` to create a new run under the currently active experiment, and to make the new run the currently active run.

```
manager.create_new_run( run_name )
```
{: .FcnSyntax}

<div class="paramList" markdown="1">
run_name
{: .paramName}

The name of the user creating the run.
{: .paramDefnFirst}
</div>

Example:

```
manager.create_new_run( 'myNewRun')
```
{: .Example }


#### reset_run  {#resetrun}

Use the `reset_run` method to rest the current run. This deletes logged parameters, metrics, artifacts, and other information associated with the run.

```
manager.reset_run( )
```
{: .FcnSyntax}

Example:

```
manager.reset_run( )
```
{: .Example }



#### set_active_experiment  {#setactiveexperiment}

Use the `set_active_experiment` method to make an existing experiment the active experiment. All new runs will be created under this experiment.

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

Example:

```
manager.set_active_experiment( 'myFirstExperiment')
```
{: .Example }



#### set_active_run  {#setactiverun}

Use the `set_active_run` method to set a previous run as the active run under the current experiment; this allows you to log metadata for a completed run.

```
manager.set_active_run( run_name )
```
{: .FcnSyntax}

<div class="paramList" markdown="1">
run_name
{: .paramName}

The string name of the run you want to make the active run.
{: .paramDefnFirst}
</div>

Example:

```
manager.set_active_run( 'myNewRun')
```
{: .Example }


### Logging Methods  {#logmethods}

This section describes the ML Manager methods for logging models, parameters, metrics, and artifacts:

* [log_artifact](#logartifact)
* [log_artifacts](#logartifacts)
* [log_metric](#logmetric)
* [log_model](#logmodel)
* [log_param](#logparam)
* [log_spark_model](#logsparkmodel)


#### log_artifact  {#logartifact}

Use the `log_artifact` method to log a local file or directory as an artifact of the currently active run.

```
manager.log_artifact( local_path, artifact_path )
```
{: .FcnSyntax}

<div class="paramList" markdown="1">
local_path
{: .paramName}

The path to the file that you want written to your artifacts URI.
{: .paramDefnFirst}

artifact_path
{: .paramName}

Optional. The subdirectory of your artifacts URI to which you want the artifact written.
{: .paramDefnFirst}
</div>

Example:

```
manager.log_artifact( '/tmp/myRunData' )
```
{: .Example }



#### log_artifacts  {#logartifacts}

Use the `log_artifacts` method to log the contents of a local directory as  artifacts of the currently active run.

```
manager.log_artifacts( local_dir, artifact_path )
```
{: .FcnSyntax}

<div class="paramList" markdown="1">
local_dir
{: .paramName}

The path to the directory of files that you want written to your artifacts URI.
{: .paramDefnFirst}

artifact_path
{: .paramName}

Optional. The subdirectory of your artifacts URI to which you want the artifact written.
{: .paramDefnFirst}
</div>

Example:

```
manager.log_artifacts( '/tmp/myRunInfo' )
```
{: .Example }


#### log_metric  {#logmetric}

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

Example:

```
    #log how long the model took
manager.log_metric('time', time_taken)
```
{: .Example }


#### log_model  {#logmodel}

Use the `log__model` method to log a model for the currently active run.

```
log__model( model, module )
```
{: .FcnSyntax}

<div class="paramList" markdown="1">
model
{: .paramName}

The fitted pipeline/model (in Spark) that you want to log.
{: .paramDefnFirst}

module
{: .paramName}

The module that the model is part of; for example, `mlflow.spark` or `mlflow.sklearn`.
{: .paramDefnFirst}
</div>

Example:

```
    #save model to MLflow for deployment
manager.log_model( model, 'mlflow.sklearn' )
```
{: .Example }


#### log_param  {#logparam}

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

Example:

```
manager.log_param('classifier', 'neural network')
manager.log_param('maxIter', '100')
```
{: .Example }


#### log_spark_model  {#logsparkmodel}

Use the `log_spark_model` method to save a MLlib model you've created to MLflow, for future deployment.

```
log_spark_model( model )
```
{: .FcnSyntax}

<div class="paramList" markdown="1">
model
{: .paramName}

The fitted pipeline/model you want to log.
{: .paramDefnFirst}
</div>

Example:

```
    #save the pipeline and model to s3
model.save('s3a://myModels/myFirstModel')
    #save model to MLflow for deployment
manager.log_spark_model(model)
```
{: .Example }



### Tagging Methods  {#tagmethods}

This section describes the ML Manager methods for tagging:

* [set_tag](#settag)

#### set_tag  {#settag}

Use the `set_tag` method to set the value of a tag for the current run. Tags are specific pieces of information associated with a run, such as the project ID, the version ID, or the deployable status.

```
set_tag( key, value )
```
{: .FcnSyntax}

<div class="paramList" markdown="1">
tag_name
{: .paramName}

The name of the tag you want to assign a value to for the current run.
{: .paramDefnFirst}

tag_value
{: .paramName}

The string value to for the tag.
{: .paramDefnFirst}

</div>

Example:

```
manager.set_tag('projectId', 'myNewProject')
```
{: .Example}

</div>
</section>
