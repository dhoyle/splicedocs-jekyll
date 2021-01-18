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
# Using the Splice Machine ML Manager API

This topic describes the methods available in the ML Manager API; you'll find examples of each of these in the [Using ML Manager](mlmanager_using.html) topic, in this chapter.

You can use Splice ML Manager with Python in Jupyter notebooks, using  our `pyspark` interpreter and our `MLManager` class in your program to manipulate experiments.

This topic contains the following sections:

* [Getting Started with the ML Manager API](#getstarted)
* [ML Manager API: Properties](#mlprops)
* [ML Manager API: Methods](#mlmethods)
* [ML Manager API: Shortcut Functions](#mlshortcuts)


## Getting Started with the ML Manager API {#getstarted}

To get started with MLManager, you need to:

1. Create your MLManager instance.
2. Establish a connection to your database.
3. Create an experiment.
4. Create a run.
5. Run your experiment(s).

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


## MLManager API: Properties   {#mlprops}

The MLManager provides the following properties:

* [current_run_id](#current_run_id)
* [experiment_id](#experiment_id)

#### current_run_id  {#current_run_id}

The `current_run_id` property returns the UUID of the current run.

```
current_run_id
```
{: .FcnSyntax}


#### experiment_id  {#experiment_id}

The `experiment_id` property returns the UUID of the current experiment.

```
experiment_id
```
{: .FcnSyntax}


## MLManager API: Methods  {#mlmethods}

This section describes the methods available in the MLAPI:

* [`create_experiment`](#create_experiment)
* [`current_run_id`](#current_run_id)
* [`delete_active_run`](#delete_active_run)
* [`deploy_aws`](#deploy_aws)
* [`deploy_azure`](#deploy_azure)
* [`disable_service`](#disable_service)
* [`download_artifact`](#download_artifact)
* [`enable_service`](#enable_service)
* [`end_run`](#end_run)
* [`experiment_id`](#experiment_id)
* [`get_run`](#get_run)
* [`lm`](#lm)
* [`load_spark_model`](#load_spark_model)
* [`log_and_stop_timer`](#log_and_stop_timer)
* [`log_artifact`](#log_artifact)
* [`log_artifacts`](#log_artifacts)
* [`log_batch`](#log_batch)
* [`log_evaluator_metrics`](#log_evaluator_metrics)
* [`log_feature_transformations`](#log_feature_transformations)
* [`log_metric`](#log_metric)
* [`log_metrics`](#log_metrics)
* [`log_model_params`](#log_model_params)
* [`log_param`](#log_param)
* [`log_params`](#log_params)
* [`log_pipeline_stages`](#log_pipeline_stages)
* [`log_spark_model`](#log_spark_model)
* [`login_director`](#login_director)
* [`reset_run`](#reset_run)
* [`retrieve_artifact_stream`](#retrieve_artifact_stream)
* [`set_active_experiment`](#set_active_experiment)
* [`set_active_run`](#set_active_run)
* [`set_tag`](#set_tag)
* [`set_tags`](#set_tags)
* [`st`](#st)
* [`start_run`](#start_run)
* [`start_timer`](#start_timer)
* [`toggle_service`](#toggle_service)




### create_experiment  {#create_experiment}
{: .extraTopSpace}

The `create_experiment` method creates a new experiment.

If the experiment already exists, it becomes the active experiment. If the experiment doesn't exist, it will be created and set to active.

#### Syntax

```
create_experiment(experiment_name, reset=False)
```
{: .FcnSyntax}

<div class="paramList" markdown="1">
experiment_name
{: .paramName}

A string that specifies the name of the experiment to create.
{: .paramDefnFirst}

reset
{: .paramName}

A Boolean value that specifies whether or not to overwrite the existing run.
{: .paramDefnFirst}

Use this option with caution: all runs within the existing experiment will be deleted.
{: .noteWarning}

</div>


### delete_active_run  {#delete_active_run}
{: .extraTopSpace}

The `delete_active_run` method deletes the current run.

#### Syntax

```
delete_active_run()
```
{: .FcnSyntax}


### deploy_azure  {#deploy_azure}
{: .extraTopSpace}

The `deploy_azure` method deploys the specified run to AzureML.

#### Syntax

```
def deploy_azure(endpoint_name, resource_group, workspace, run_id=None, region='East US', cpu_cores=0.1, allocated_ram=0.5, model_name=None)
```
{: .FcnSyntax}

<div class="paramList" markdown="1">
endpoint_name
{: .paramName}

A string that specifies the name of the endpoint in AzureML once deployed to Azure Container Services. This name must be unique.
{: .paramDefnFirst}

resource_group
{: .paramName}

A string that specifies the Azure Resource Group for model. This is automatically created if it doesn't already exist.
{: .paramDefnFirst}

workspace
{: .paramName}

A string that specifies the name of the AzureML workspace to deploy the model under. This is created if it doesn't already exist.
{: .paramDefnFirst}

run_id
{: .paramName}

A string that specifies the ID of the run; if you specify this, the run with that ID is deployed; that run must have a logged Spark model. If you don't specify a run ID, the active run is deployed.
{: .paramDefnFirst}

region
{: .paramName}

A string that specifies the AzureML region where you want the app deployed; you can currently specify one of: `East US`, `East US 2`, `Central US`, `West US 2`, `North Europe`, `West Europe`, or `Japan East`.
{: .paramDefnFirst}

cpu_cores
{: .paramName}

A floating point value that specifies the number of CPU Cores to allocate to the instance. This can be a fractional value. The default value is `0.1`.
{: .paramDefnFirst}

allocated_ram
{: .paramName}

A floating point value that specifies the amount, in GB, of RAM allocated to the container. The default value is `0.5`.
{: .paramDefnFirst}

model_name
{: .paramName}

A string that specifies the name of the model in AzureML. If you don't specify this value, the model is assigned a randomly generated name.
{: .paramDefnFirst}
</div>


### disable_service  {#disable_service}
{: .extraTopSpace}

The `disable_service` method disables the specifies service.

#### Syntax

```
disable_service(service_name)
```
{: .FcnSyntax}

<div class="paramList" markdown="1">

service_name
{: .paramName}

A string that specifies the name of the service to disable.
{: .paramDefnFirst}
</div>


### download_artifact  {#download_artifact}
{: .extraTopSpace}

The `download_artifact` method downloads an artifact for a specified run ID.

#### Syntax

```
download_artifact(name, local_path, run_id=None)
```
{: .FcnSyntax}

<div class="paramList" markdown="1">

name
{: .paramName}

A string that specifies the artifact name to load; this `name` is relative to the run.
{: .paramDefnFirst}

local_path
{: .paramName}

A string that specifies the local path to which you want the model downloaded.
{: .paramDefnFirst}

run_id
{: .paramName}

A string that specifies the ID of the run from which you want the artifact downloaded. This defaults to the active run (`None`).
{: .paramDefnFirst}
</div>


### enable_service  {#enable_service}
{: .extraTopSpace}

The `enable_service` method enables a specified service.

#### Syntax

```
enable_service(service_name)
```
{: .FcnSyntax}

<div class="paramList" markdown="1">

service_name
{: .paramName}

A string that specifies the service to enable.
{: .paramDefnFirst}
</div>


### end_run  {#end_run}
{: .extraTopSpace}

The `end_run` method terminates the current run.

#### Syntax

```
end_run(create=False, metadata={})
```
{: .FcnSyntax}


### get_run  {#get_run}
{: .extraTopSpace}

The `get_run` method retrieves a run and its data. It returns the specified run.

#### Syntax

```
get_run(run_id)
```
{: .FcnSyntax}

<div class="paramList" markdown="1">

run_id
{: .paramName}

The ID of the run that you want to retrieve.
{: .paramDefnFirst}
</div>


### load_spark_model  {#load_spark_model}
{: .extraTopSpace}

The `load_spark_model` method downloads a model from S3 and loads it into Spark.

#### Syntax

```
load_spark_model(run_id=None, name='model')
```
{: .FcnSyntax}

<div class="paramList" markdown="1">

run_id
{: .paramName}

A string that specifies the ID of the run to get a model from; the run must have an associated model with it named spark_model.
{: .paramDefnFirst}
</div>


### log_and_stop_timer  {#log_and_stop_timer}
{: .extraTopSpace}

The `log_and_stop_time` method stops and active timer, and logs as parameter values the time that the timers were active.

This method returns the total time, in milliseconds.

#### Syntax

```
log_and_stop_timer()
```
{: .FcnSyntax}


### log_artifact  {#log_artifact}
{: .extraTopSpace}

The `log_artifact` method logs an artifact for the active run.

#### Syntax

```
log_artifact(file_name, name)
```
{: .FcnSyntax}

<div class="paramList" markdown="1">

file_name
{: .paramName}

A string that specifies the name of the file name to log.
{: .paramDefnFirst}
name
{: .paramName}

A string that specifies the run-relative name to store the model under.
{: .paramDefnFirst}
</div>


### log_artifacts  {#log_artifacts}
{: .extraTopSpace}

The `log_artifacts` method logs a list of artifacts for the active run.

#### Syntax

```
log_artifacts(file_names, names)
```
{: .FcnSyntax}

<div class="paramList" markdown="1">

file_names
{: .paramName}

A list of file names to retrieve.
{: .paramDefnFirst}

names
{: .paramName}

A corresponding list of names for each artifact in `file_names`.
{: .paramDefnFirst}

</div>


### log_batch  {#log_batch}
{: .extraTopSpace}

The `log_batch` method logs a batch of metrics, parameters, and tags.

#### Syntax

```
log_batch((metrics, parameters, tags)
```
{: .FcnSyntax}

<div class="paramList" markdown="1">

metrics
{: .paramName}

A list of tuples, each of which is a (`metric name`, `metric value`) pair.
{: .paramDefnFirst}

parameters
{: .paramName}

A list of tuples, each of which is a (`parameter name`, `parameter value`) pair.
{: .paramDefnFirst}

tags
{: .paramName}

A list of tuples, each of which is a (`tag name`, `tag value`) pair.
{: .paramDefnFirst}
</div>


### log_evaluator_metrics  {#log_evaluator_metrics}
{: .extraTopSpace}

The `log_evaluator_metrics` method logs all of the metrics with the specified Splice Machine evaluator.

This method returns the retrieved dictionary of metrics.

#### Syntax

```
log_evaluator_metrics(splice_evaluator)
```
{: .FcnSyntax}

<div class="paramList" markdown="1">

splice_evaluator
{: .paramName}

A Splice evaluator, from the `splicemachine.ml.utilities` package in `pysplice`.
{: .paramDefnFirst}
</div>


### log_feature_transformations  {#log_feature_transformations}
{: .extraTopSpace}

The `log_feature_transformations` method logs the preprocessing transformation sequence for every feature in an __unfitted__ Spark pipeline.

#### Syntax

```
log_feature_transformations(unfit_pipeline)
```
{: .FcnSyntax}

<div class="paramList" markdown="1">

unfit_pipeline
{: .paramName}

An unfitted spark pipeline.
{: .paramDefnFirst}
</div>


### log_metric  {#log_metric}
{: .extraTopSpace}

The `log_metric` method logs a metric for the active run.

This method allows you to specify the metric name and value in various forms; for example:

```
log_metric( **{"mymetric":"0.90"} )
log_metric( 'mymetric', 0.90 )
log_metric( key='mymetric', value=0.90 )
```
{: .Example}

#### Syntax

```
log_metric(*args, **kwargs)
```
{: .FcnSyntax}

<div class="paramList" markdown="1">

*args
{: .paramName}

A metrics name and value.
{: .paramDefnFirst}

**kwargs
{: .paramName}

A metrics name and value, expressed in `key=`, `value=` form.
{: .paramDefnFirst}
</div>


### log_metrics  {#log_metrics}
{: .extraTopSpace}

The `log_metrics` method allows you to log a list of metrics, in the order that you specify.

#### Syntax

```
log_metrics(metrics)
```
{: .FcnSyntax}

<div class="paramList" markdown="1">

metrics
{: .paramName}

A list of tuples, each of which is a (`metric name`, `metric value`) pair.
{: .paramDefnFirst}
</div>


### log_model_params  {#log_model_params}
{: .extraTopSpace}

The `log_model_params` method logs the parameters of a fitted model, or logs the parameters for a model part of a fitted pipeline.

#### Syntax

```
log_model_params(pipeline_or_model, stage_index=-1)
```
{: .FcnSyntax}

<div class="paramList" markdown="1">

pipeline_or_model
{: .paramName}

The fitted pipeline/fitted model.
{: .paramDefnFirst}

stage_index
{: .paramName}

The index stage in the Spark pipeline that denoted the actual model. This parameter only applies when you are calling this method to log a Pipeline; it is not used when logging a model.
{: .paramDefnFirst}

The default value, `-1`, specifies that the model you are logging is the last parameter in the pipeline.
{: .paramDefn}

If you're calling this method on a Pipeline and the model is not the last stage of the pipeline, you must set this value.
{: .paramDefn}

A pipeline is just a list [] of Spark transformers.
{: .noteNote}
</div>


### log_param  {#log_param}
{: .extraTopSpace}

The `log_param` method logs a parameter for the active run

This method allows you to specify the parameter name and value in various forms; for example:

```
log_param( **{"accuracy":"0.90"} )
log_param( 'accuracy', 0.90 )
log_param( key='accuracy', value=0.90 )
```
{: .Example}

#### Syntax

```
log_param(*args, **kwargs)
```
{: .FcnSyntax}

<div class="paramList" markdown="1">
*args
{: .paramName}

A parameter name and parameter value.
{: .paramDefnFirst}

**kwargs
{: .paramName}

A parameter name and parameter value, expressed in `key=`, `value=` form.
{: .paramDefnFirst}
</div>


### log_params  {#log_params}
{: .extraTopSpace}

The `log_params` method logs a list of parameters, in the specified order.

#### Syntax

```
log_params(params)
```
{: .FcnSyntax}

<div class="paramList" markdown="1">
params
{: .paramName}

A list of tuples; each tuple is a (`parameter name`, `parameter value`) pair.
{: .paramDefnFirst}
</div>


### log_pipeline_stages  {#log_pipeline_stages}
{: .extraTopSpace}

The `log_pipeline_stages` method logs the human-readable names of each stage in a  Spark pipeline.

This can result in a very large number of parameters in MLFlow for a big pipeline; we recommend that you log these yourself  to ensure useful tracking.
{: .noteWarning}

#### Syntax

```
log_pipeline_stages(pipeline)
```
{: .FcnSyntax}

<div class="paramList" markdown="1">

pipeline
{: .paramName}

The fitted or unfitted pipeline object.
{: .paramDefnFirst}
</div>


### log_spark_model  {#log_spark_model}
{: .extraTopSpace}

The `log_spark_model` method logs a fitted Spark pipeline or model.

#### Syntax

```
log_spark_model(model, name='model')
```
{: .FcnSyntax}

<div class="paramList" markdown="1">

model
{: .paramName}

The fitted Spark Model/Pipeline to store with the current run. This can be a `PipelineModel` or a `Model`.
{: .paramDefnFirst}

name
{: .paramName}

A string that specifies the run-relative name to store the model under.
{: .paramDefnFirst}

</div>


### login_director  {#login_director}
{: .extraTopSpace}

The `login_director` method logs a user into the *MLDirector*, so that user can submit jobs.

#### Syntax

```
login_director(username, password)
```
{: .FcnSyntax}


<div class="paramList" markdown="1">

username
{: .paramName}

A string that specifies the database user name.
{: .paramDefnFirst}

password
{: .paramName}

A string that specifies the database user password.
{: .paramDefnFirst}
</div>


### reset_run  {#reset_run}
{: .extraTopSpace}

The `reset_run` method resets the current run by deleting items such as logged parameters, metrics, and artifacts.

#### Syntax

```
reset_run()
```
{: .FcnSyntax}

### retrieve_artifact_stream  {#retrieve_artifact_stream}
{: .extraTopSpace}

The `retrieve_artifact_stream` method retrieves the binary stream for the artifact with the specified name and run id.

This method returns a `(bytearray(byte))` byte array from BLOB.

#### Syntax

```
retrieve_artifact_stream(run_id, name)
```
{: .FcnSyntax}

<div class="paramList" markdown="1">

run_id
{: .paramName}

A string that specifies the run id for the run that the artifact belongs to.
{: .paramDefnFirst}

name
{: .paramName}

A string that specifies the name of the artifact.
{: .paramDefnFirst}
</div>


### set_active_experiment  {#set_active_experiment}
{: .extraTopSpace}

The `set_active_experiment` method sets the active experiment to the specified name. All new runs will be created under this experiment. Note that existing runs are not affected.

#### Syntax

```
set_active_experiment(experiment_name)
```
{: .FcnSyntax}

<div class="paramList" markdown="1">
experiment_name
{: .paramName}

An integer that specifies the experiment ID, or a string that specifies the experiment name.
{: .paramDefnFirst}
</div>


### set_active_run  {#set_active_run}
{: .extraTopSpace}

The `set_active_run` method sets the active run to the previous run specified by `run_id`. You can use this to log metadata for completed run.

#### Syntax

```
set_active_run(run_id)
```
{: .FcnSyntax}

<div class="paramList" markdown="1">

run_id
{: .paramName}

The run UUID of the previous run.
{: .paramDefnFirst}
</div>


### set_tag  {#set_tag}
{: .extraTopSpace}

The `set_tag` method logs the value of a named tag.

This method allows you to specify the metric name and value in various forms; for example:

```
set_tag( **{"name":"myName"} )
set_tag( 'name', 'myName' )
set_tag( key='name', value='myName' )
```
{: .Example}

#### Syntax

```
set_tag(*args, **kwargs)
```
{: .FcnSyntax}

<div class="paramList" markdown="1">

*args
{: .paramName}

A tag name and value.
{: .paramDefnFirst}

**kwargs
{: .paramName}

A tag name and value, expressed in `key=`, `value=` form.
{: .paramDefnFirst}
</div>


### set_tags  {#set_tags}
{: .extraTopSpace}

The `set_tags` method allows you to log a list of tags, in the order that you specify.

#### Syntax

```
set_tags(tags)
```
{: .FcnSyntax}

<div class="paramList" markdown="1">

tags
{: .paramName}

A list of tuples, each of which is a (`tag name`, `tag value`) pair.
{: .paramDefnFirst}
</div>


### start_run  {#start_run}
{: .extraTopSpace}

The `start_run` method creates a new run in the active experiment and makes it the active run.

#### Syntax

```
start_run(tags=None, run_name=None, experiment_id=None, nested=False)
```
{: .FcnSyntax}

<div class="paramList" markdown="1">
tags
{: .paramName}

A dictionary containing metadata about the current run.
{: .paramDefnFirst}

For example:
```
    {
        'team': 'pd',
        'purpose': 'r&d'
    }
```
{: .Example}

run_name
{: .paramName}

An optional name for the run; this displays in the MLFlow UI.
{: .paramDefnFirst}

experiment_id
{: .paramName}

If you specify this value, it overrides the experiment ID of the active run.
{: .paramDefnFirst}

nester
{: .paramName}

A Boolean value that specifies whether (`True`) you want the run to beested within a parent run.
{: .paramDefnFirst}
</div>


### start_timer  {#start_timer}
{: .extraTopSpace}

The `start_timer` method names and starts a timer; the timer will be logged when the run is stopped.

#### Syntax

```
start_timer(timer_name)
```
{: .FcnSyntax}

<div class="paramList" markdown="1">

timer_name
{: .paramName}

The name to apply to the timer; this is the name that will appear in the MLFlow UI.
{: .paramDefnFirst}
</div>


### toggle_service  {#toggle_service}
{: .extraTopSpace}

The `toggle_service` method runs a modifier on a service.

This method returns the response text from the `POST` request.

#### Syntax

```
toggle_service(service_name, action)
```
{: .FcnSyntax}

<div class="paramList" markdown="1">

service_name
{: .paramName}

A string that specifies the name of the service to run.
{: .paramDefnFirst}

action
{: .paramName}

A string that specifies the action to execute.
{: .paramDefnFirst}
</div>



### MLManager API: Shortcut Functions  {#mlshortcuts}
{: .extraTopSpace}

MLManager provides a few shortcut functions for setting parameters, metrics, and tags:

* [`lp`](#lp)
* [`lm`](#sm)
* [`st`](#st)


### lm  {#lm}
{: .extraTopSpace}

`lm` is a shortcut function for the &nbsp;&nbsp;[`log_metric`](#log_metric) method.

```
lm(*args, **kwargs)
```
{: .FcnSyntax}


### lp  {#lp}
{: .extraTopSpace}

`lp` is a shortcut function for the &nbsp;&nbsp;[`log_param`](#log_param) method.

```
lp(*args, **kwargs)
```
{: .FcnSyntax}


### st  {#st}
{: .extraTopSpace}

`st` is a shortcut function for the &nbsp;&nbsp;[`set_tag`](#set_tag) method.

```
st(*args, **kwargs)
```
{: .FcnSyntax}

</div>
</section>
