
class MLManager(MlflowClient):
A class for managing your MLFlow Runs/Experiments


@property


### current_run_id  {#current_run_id}

```
manager.current_run_id(self)
```
{: .FcnSyntax}

    Returns the UUID of the current run

@property


### experiment_id  {#experiment_id}

```
manager.experiment_id(self)
```
{: .FcnSyntax}

    Returns the UUID of the current experiment

    return self.active_experiment.experiment_id
```



manager.lp(*args, **kwargs)
```
{: .FcnSyntax}

    Shortcut function for logging
    parameters

    return self.log_param(*args, **kwargs)


### lm  {#lm}

```
manager.lm(*args, **kwargs)
```
{: .FcnSyntax}

    Shortcut function for logging
    metrics

    return self.log_metric(*args, **kwargs)


### st  {#st}

```
manager.st(*args, **kwargs)
```
{: .FcnSyntax}

    Shortcut function for setting tags

    return self.set_tag(*args, **kwargs)



======================================================



### create_experiment  {#create_experiment}

```
manager.create_experiment(experiment_name, reset=False)
```
{: .FcnSyntax}

Creates a new experiment.
{: .paramDefnFirst}

If the experiment already exists, it becomes the active experiment. If the experiment doesn't exist, it will be created and set to active.
{: .paramDefn}

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


### set_active_experiment  {#set_active_experiment}

```
manager.set_active_experiment(experiment_name)
```
{: .FcnSyntax}

Sets the active experiment to `experiment_name`. All new runs, will be created under this experiment. Note that existing runs are not affected.

<div class="paramList" markdown="1">
experiment_name
{: .paramName}

An integer that specifies the experiment ID, or a string that specifies the experiment name.
{: .paramDefnFirst}
</div>


### set_active_run  {#set_active_run}

```
manager.set_active_run(run_id)
```
{: .FcnSyntax}

Set the active run to the previous run specified by `run_id`. You can use this to log metadata for completed run.

<div class="paramList" markdown="1">

run_id
{: .paramName}

The run UUID of the previous run.
{: .paramDefnFirst}
</div>



### start_run  {#start_run}

```
manager.start_run(tags=None, run_name=None, experiment_id=None, nested=False)
```
{: .FcnSyntax}

Creates a new run in the active experiment, and makes it the active run.

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


### get_run  {#get_run}

```
manager.get_run(run_id)
```
{: .FcnSyntax}

Retrieve a run (and its data) by its run id.

--> Returns the run.

<div class="paramList" markdown="1">

run_id
{: .paramName}

The ID of the run that you want to retrieve.
{: .paramDefnFirst}
</div>


 ### reset_run  {#reset_run}

```
manager.reset_run()
```
{: .FcnSyntax}

Resets the current run by deleting items such as logged parameters, metrics, and artifacts.


### log_param  {#log_param}

```
manager.log_param(*args, **kwargs)
```
{: .FcnSyntax}

Logs a parameter for the active run.


### log_params  {#log_params}

```
manager.log_params(params)
```
{: .FcnSyntax}

Log a list of parameters in order

<div class="paramList" markdown="1">
params
{: .paramName}

A list of tuples; each tuple is a (`parameter name`, `parameter value`) pair.
{: .paramDefnFirst}
</div>



### set_tag  {#set_tag}

```
manager.set_tag(*args, **kwargs)
```
{: .FcnSyntax}

Sets a tag value for the active run.



### set_tags  {#set_tags}

```
manager.set_tags(tags)
```
{: .FcnSyntax}

Logs a set of tag values.

<div class="paramList" markdown="1">

tags
{: .paramName}

A list of tuples, each of which is a (`tag name`, `tag value`) pair.
{: .paramDefnFirst}


### log_metric  {#log_metric}

```
manager.log_metric(*args, **kwargs)
```
{: .FcnSyntax}

Logs a metric for the active run.

<div class="paramList" markdown="1">
</div>


### log_metrics  {#log_metrics}

```
manager.log_metrics(metrics)
```
{: .FcnSyntax}

Logs a list of metrics, in order.

<div class="paramList" markdown="1">

metrics
{: .paramName}

A list of tuples, each of which is a (`metric name`, `metric value`) pair.
{: .paramDefnFirst}
</div>



### log_artifact  {#log_artifact}

```
manager.log_artifact(file_name, name)
```
{: .FcnSyntax}

Logs an artifact for the active run.

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

```
manager.log_artifacts(file_names, names)
```
{: .FcnSyntax}

Logs a list of artifacts for the active run.

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



### log_spark_model  {#log_spark_model}

```
manager.log_spark_model(model, name='model')
```
{: .FcnSyntax}

Logs a fitted Spark pipeline or model.

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


=============start here====================
### log_batch  {#log_batch}

```
manager.log_batch((metrics, parameters, tags)
```
{: .FcnSyntax}

Log a batch set of metrics, parameters and tags

<div class="paramList" markdown="1">

metrics
{: .paramName}

a list of tuples mapping metrics to metric values
{: .paramDefnFirst}

parameters
{: .paramName}

a list of tuples mapping parameters to parameter values
{: .paramDefnFirst}

tags
{: .paramName}

a list of tuples mapping tags to tag values
{: .paramDefnFirst}
</div>




### log_pipeline_stages  {#log_pipeline_stages}

```
manager.log_pipeline_stages(pipeline)
```
{: .FcnSyntax}

Log the human-friendly names of each stage in a  Spark pipeline.

With a big pipeline, this could result in a lot of parameters in MLFlow; it is probably best to log them yourself, so you can ensure useful tracking.
{: .noteWarning}

<div class="paramList" markdown="1">

pipeline
{: .paramName}

the fitted/unfit pipeline object
{: .paramDefnFirst}
</div>




### log_feature_transformations  {#log_feature_transformations}

```
manager.log_feature_transformations(unfit_pipeline)
```
{: .FcnSyntax}

Log the preprocessing transformation sequence for every feature in the UNFITTED Spark pipeline

<div class="paramList" markdown="1">

unfit_pipeline
{: .paramName}

UNFITTED spark pipeline!!
{: .paramDefnFirst}
</div>




### start_timer  {#start_timer}

```
manager.start_timer(timer_name)
```
{: .FcnSyntax}

Start a given timer with the specified timer name, which will be logged when the run is stopped

<div class="paramList" markdown="1">


timer_name
{: .paramName}

the name to call the timer (will appear in MLFlow UI)
{: .paramDefnFirst}
</div>



### log_and_stop_timer  {#log_and_stop_timer}

```
manager.log_and_stop_timer()
```
{: .FcnSyntax}
<div class="paramList" markdown="1">

Stop any active timers, and log the time that the timer was active as a parameter.

--> Returns the total time, in milliseconds.




### log_evaluator_metrics  {#log_evaluator_metrics}

```
manager.log_evaluator_metrics(splice_evaluator)
```
{: .FcnSyntax}

Takes an Splice evaluator and logs all of the associated metrics with it.

--> Returns the retrieved metrics dictionary.

<div class="paramList" markdown="1">

splice_evaluator
{: .paramName}

a Splice evaluator (from `splicemachine.ml.utilities` package in pysplice).
{: .paramDefnFirst}
</div>




### log_model_params  {#log_model_params}

```
manager.log_model_params(pipeline_or_model, stage_index=-1)
```
{: .FcnSyntax}

Log the parameters of a fitted model or a model part of a fitted pipeline

<div class="paramList" markdown="1">

pipeline_or_model
{: .paramName}

fitted pipeline/fitted model
{: .paramDefnFirst}
stage_index
{: .paramName}

xxx
{: .paramDefnFirst}
</div>




### end_run  {#end_run}

```
manager.end_run(create=False, metadata={})
```
{: .FcnSyntax}

Terminate the current run.




### delete_active_run  {#delete_active_run}

```
manager.delete_active_run()
```
{: .FcnSyntax}

Delete the current run.




### retrieve_artifact_stream  {#retrieve_artifact_stream}

```
manager.retrieve_artifact_stream(run_id, name)
```
{: .FcnSyntax}

Retrieve the binary stream for a given artifact with the specified name and run id.

--> Returns a `(bytearray(byte))` byte array from BLOB

<div class="paramList" markdown="1">


run_id
{: .paramName}

(str) the run id for the run
{: .paramDefnFirst}
        that the artifact belongs to
name
{: .paramName}

(str) the name of the artifact
{: .paramDefnFirst}
</div>




### download_artifact  {#download_artifact}

```
manager.download_artifact(name, local_path, run_id=None)
```
{: .FcnSyntax}

Download the artifact at the given run id (active default) + name to the local path

<div class="paramList" markdown="1">

name
{: .paramName}

(str) artifact name to load (with respect to the run)

{: .paramDefnFirst}

local_path
{: .paramName}

(str) local path to download the model to
{: .paramDefnFirst}

run_id
{: .paramName}

(str) the run id to download the artifact from; this defaults to the active run.
{: .paramDefnFirst}
</div>




### load_spark_model  {#load_spark_model}

```
manager.load_spark_model(run_id=None, name='model')
```
{: .FcnSyntax}

Download a model from S3 and load it into Spark

<div class="paramList" markdown="1">

run_id
{: .paramName}

the id of the run to get a model from; the run must have an associated model with it named spark_model.
{: .paramDefnFirst}




### login_director  {#login_director}

```
manager.login_director(username, password)
```
{: .FcnSyntax}

Login to MLmanager Director so we can submit jobs

<div class="paramList" markdown="1">

username
{: .paramName}

(str) database username
{: .paramDefnFirst}

password
{: .paramName}

(str) database password
{: .paramDefnFirst}
</div>




### deploy_aws  {#deploy_aws}

```
manager.deploy_aws(app_name,
               region='us-east-2', instance_type='ml.m5.xlarge',
               run_id=None, instance_count=1, deployment_mode='replace')
{: .FcnSyntax}

Queue Job to deploy a run to sagemaker with the given run id (found in MLFlow UI or through search API).

run_id
{: .paramName}

the id of the run to deploy. Will default to the current run id
{: .paramDefnFirst}

app_name
{: .paramName}

the name of the app in sagemaker once deployed
{: .paramDefnFirst}

region
{: .paramName}

the sagemaker region to deploy to (us-east-2, us-west-1, us-west-2, eu-central-1 supported)

{: .paramDefnFirst}

instance_type
{: .paramName}

the EC2 Sagemaker instance type to deploy on (ml.m4.xlarge supported)
{: .paramDefnFirst}

instance_count
{: .paramName}

the number of instances to load balance predictions on
{: .paramDefnFirst}

deployment_mode
{: .paramName}

the method to deploy; create=application will fail if an app with the name specified already exists; replace=application in sagemaker will be replaced with this one if app already exists; add=add the specified model to a prexisting application (not recommended)

{: .paramDefnFirst}
</div>



### toggle_service  {#toggle_service}

```
manager.toggle_service(service_name, action)
```
{: .FcnSyntax}

Run a modifier on a service

--> Returns (str) response text from POST request

<div class="paramList" markdown="1">

service_name
{: .paramName}

(str) the service to modify
{: .paramDefnFirst}

action
{: .paramName}

(str) the action to execute
{: .paramDefnFirst}
</div>




### enable_service  {#enable_service}

```
manager.enable_service(service_name)
```
{: .FcnSyntax}

Enable a given service

<div class="paramList" markdown="1">

service_name
{: .paramName}

(str) service to enable
{: .paramDefnFirst}
</div>




### disable_service  {#disable_service}

```
manager.disable_service(service_name)
```
{: .FcnSyntax}

Disable a given service

<div class="paramList" markdown="1">

service_name
{: .paramName}

(str) service to disable
{: .paramDefnFirst}
</div>


```
def deploy_azure(endpoint_name, resource_group, workspace, run_id=None, region='East US', cpu_cores=0.1, allocated_ram=0.5, model_name=None):
```
{: .fcnSyntax}

Deploy a given run to AzureML.

<div class="paramList" markdown="1">
endpoint_name
{: .paramName}

(str) the name of the endpoint in AzureML when deployed to Azure Container Services. Must be unique.

{: .paramDefnFirst}

resource_group
{: .paramName}

(str) Azure Resource Group for model. Automatically created if it doesn't exist.
{: .paramDefnFirst}

workspace
{: .paramName}

(str) the AzureML workspace to deploy the model under. This is created if it doesn't exist.
{: .paramDefnFirst}

run_id
{: .paramName}

(str) if specified, will deploy a previous run (must have an spark model logged). Otherwise, will default to the active run.
{: .paramDefnFirst}

region
{: .paramName}

(str) AzureML Region to deploy to: Can be East US, East US 2, Central US, West US 2, North Europe, West Europe or Japan East

{: .paramDefnFirst}

cpu_cores
{: .paramName}

(float) Number of CPU Cores to allocate to the instance. Can be fractional. Default=0.1
{: .paramDefnFirst}

allocated_ram
{: .paramName}

(float) amount of RAM, in GB, allocated to the container. Default=0.5

{: .paramDefnFirst}

model_name
{: .paramName}

(str) If specified, this will be the name of the model in AzureML. Otherwise, the model name will be randomly generated.
{: .paramDefnFirst}
