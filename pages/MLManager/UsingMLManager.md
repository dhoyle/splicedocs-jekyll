---
title: Using the Splice ML Manager
summary: Overview of using the ML Manager
keywords: data science, machine learning
toc: false
product: all
sidebar: home_sidebar
permalink: mlmanager_using.html
folder: MLManager
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Using the Splice ML Manager

This topic shows you how to use the Splice Machine *ML Manager*, a machine learning framework that combines the power of Splice Machine with the power of Jupyter notebooks, Apache MLflow, and Amazon Sagemaker to create a full-cycle platform for developing and maintaining your smart applications.

{% include splice_snippets/dbaasonlytopic.md %}

This topic is organized into these sections:

* [*ML Manager Workflow*](#workflow) provides a quick overview of what the *ML Manager* does and how it interfaces with MLflow and SageMaker to provide a complete Machine Learning production environment.
* [*Running an Experiment*](#runExperiment) walks you through creating an ML experiment for detecting credit card fraud and shows you how to train, run, and compare two different learning models.
* [*Deploying Your Model to AWS SageMaker*](#deploywithsagemaker) walks you through deploying your model on AWS.
* [*Retraining the Model with New Data*](#UpdateData) shows you how to retrain your model with new data and update your deployment.

The [*ML Manager Introduction*](mlmanager_intro.html) topic in this chapter provides an overview of the ML Manager, and the [*ML Manager API*](mlmanager_api.html) topic provides reference information for its API.

## *ML Manager* WorkFlow  {#workflow}

Here's what the basic flow of processes involved in developing, tuning, and deploying your ML projects looks like with *ML Manager* and our cloud-based Database-as-Service product:

<img class='indentedTightSpacing' src='images/DSFlow3.png'>

The basic workflow is:
<div class="opsStepsList" markdown="1">
1. Work with MLlib and other machine learning libraries in a Jupyter notebook to directly interact with Spark and your Splice Machine database.
2. Use MLflow within your notebook to create *experiments* and *runs*, and to track variables, parameters, and other information about your runs.
3. Use the MLflow Tracking UI to monitor information about your experiments and runs.
4. Iterate on your experiments until you develop the learning model that you want to deploy, using the tracking UI to compare your runs.
5. Use the Splice ML Jobs Tracker to deploy your model to AWS SageMaker, by simply filling in a few form fields and clicking a button.
6. Write Apps that use SageMaker's RESTful API to interface with your deployed model.
7. As new data arrives, you can return to Step 1 and repeat the process.
</div>


### About MLflow

MLflow is an open source platform for managing the end-to-end machine learning lifecycle; with MLflow and Splice ML Manager, you can:

* Track your model training sessions, which are called *runs*.
* Group a collection of runs under an *experiment*, which allows you to visualize and compare a set of runs, and to download run artifacts for analysis by other tools.
* View your experiments in the *MLflow Tracking UI*, which you access by pointing your browser at port `5001`.

### About Storing Models and Pipelines

You can save your pipeline and model to S3 using the `save` method of MLlib `Pipeline` or MLlib `model` objects. Assuming that you've created a pipeline and built a model, you can save them as follows:

```
%spark.pyspark
model.save('s3a://splice-demo/fraudDemoPipelineModel')
```
{: .Example}

or

```
%spark.pyspark
pipeline.save('s3a://splice-demo/fraudDemoPipeline')
```
{: .Example}


If you are developing or have developed a model that you expect to deploy in the future, you should save the model to MLflow. Assuming that you've previously created an instance of `MLManager` named `manager` and have created a MLlib model named `model`, you can save the model to MLflow with this statement:
{: .spaceAbove}

```
%spark.pyspark
manager.log_spark_model(model)
```
{: .Example}

The code in the [*Running an Experiment*](#runExperiment) section below contains examples of saving models to S3 and to MLflow.
{: .spaceAbove}

### About SageMaker

Amazon Sagemaker allows you to easily deploy the machine learning models that you develop with the *Splice ML Manager* on Amazon AWS. The only requirement is that you have an *ECR* repository set up on AWS; ECR is Amazon's fully-managed Docker contrainer registry that simplifies deploying Docker images and is integrated with Amazon's Elastic Container Service (ECS).

When you tell our *ML Manager* to deploy a model to SageMaker, *ML Manager* creates a Docker image and uploads it to your ECR repository. You can specify which AWS instance types you want to deploy on, and how many instances you want to deploy. We send the deployment request to SageMaker, which creates an endpoint, launches your ML compute instances, and the deploys your model to them.

You can also use the same process to deploy an updated version of your model.

## Running an Experiment  {#runExperiment}

This section walks you through creating and running an experiment with ML Manager, in these steps:

* [Preparing Your Experiment](#prepareExperiment)
* [The First Run](#runFirst)
* [Trying a Different Model](#trydifferentmodel)

The Splice ML Manager, along with MLflow, allows you to group a set of *runs* into an *experiment*. Each run can use different values and parameters, all of which can be easily tracked and evaluated with help from the MLflow user interface.

### Preparing Your Experiment  {#prepareExperiment}
In this section, we'll prepare our first experiment, in these steps:

1. [Connect to your database](#connecttodb)
2. [Load the data into your database](#loadtodb)
3. [Try visualizing the data in Zeppelin](#tryvis)
4. [Create your `MLManager` instance](#createmlmgr)
5. [Create a new experiment](##createexperiment)
6. [Load the database table directly into a Spark DataFrame](#loadintodf)
7. [View your Experiment in the MLflow UI](#viewexpinui)

#### 1. Connect to your database  {#connecttodb}

First, let's establish a connection to your database using Python via our Native Spark Datasource. We will use the SpliceMLContext to establish our direct connection-- it allows us to do inserts, selects, upserts, updates and many more functions without serialization

```
%spark.pyspark
from splicemachine.spark.context import SpliceMLContext
splice = SpliceMLContext(spark)
```
{: .Example}

#### 2. Load the Data into your database  {#loadtodb}

Next, we create the table in our Splice Machine database for our fraud data:
```
%splicemachine
set schema cc_fraud;

drop table if exists cc_fraud_data;

create table cc_fraud.cc_fraud_data (
    time_offset integer,
    v1 double,
    v2 double,
    v3 double,
    v4 double,
    v5 double,
    v6 double,
    v7 double,
    v8 double,
    v9 double,
    v10 double,
    v11 double,
    v12 double,
    v13 double,
    v14 double,
    v15 double,
    v16 double,
    v17 double,
    v18 double,
    v19 double,
    v20 double,
    v21 double,
    v22 double,
    v23 double,
    v24 double,
    v25 double,
    v26 double,
    v27 double,
    v28 double,
    amount decimal(10,2),
    class_result int
);
```
{: .Example}

And then we import the data from S3 into the table:
{: .spaceAbove}

```
call SYSCS_UTIL.IMPORT_DATA (
     'cc_fraud',
     'cc_fraud_data',
     null,
     's3a://splice-demo/kaggle-fraud-data/creditcard.csv',
     ',',
     null,
     null,
     null,
     null,
     100000,
     's3a://splice-demo/kaggle-fraud-data/bad',
     null,
     null);
```
{: .Example}


#### 3. Try visualizing your data in the Notebook:  {#tryVis}

You can query the data and use one of the many visualizations built into Zeppelin to display your results. For example, you might run the following query to find the imbalance of fraud data, and display it as a pie chart:

```
%splicemachine
select class_result, count(*) from cc_fraud.cc_fraud_data group by class_result;
```
{: .Example}

<img src="images/MLpie1.png" style="max-width:150px; margin-left:50px; display:block">

#### 4. Create your MLManager Instance  {#createmlmgr}

To use ML Manager, you need to first create a class instance:
```
%spark.pyspark
from splicemachine.ml.management import MLManager
manager = MLManager()
```
{: .Example}

#### 5. Create an Experiment  {#createexperiment}

Now we'll create an MLflow experiment named `fraud_demo`:

```
%spark.pyspark
manager.create_experiment('fraud-demo')
manager.set_active_experiment('fraud-demo')
```
{: .Example}

#### 6. Load our data into a DataFrame  {#loadintodf}

And then we'll pull the data from our database table directly into a Spark DataFrame:

```
df = splice.df("SELECT * FROM cc_fraud.cc_fraud_data")
df = df.withColumnRenamed('CLASS_RESULT', 'label')
z.show(df)
```
{: .Example}

#### 7. View your Experiment in the MLflow UI  {#viewexpinui}
You can now view your new experiment in the MLflow Tracking UI, at port `5001`:

<img class='indentedTightSpacing' src='https://s3.amazonaws.com/splice-demo/mlflow_UI_fraud.png'>


### Running Your First Experiment  {#runfirst}

Now that we're set up, let's create a run named `Ben` and run our experiment, using the logging functionality of `MLManager` to record and track the attributes of our run.

We'll use these steps to run our experiment:
1. [Create a run](#createrun)
2. [Run the experiment](#runexperiment)
3. [Create a Pipeline](#createpipeline)
4. [Train and Run the Model](#trainandrun)
5. [View Run Information](#viewruninfo)
6. [Make Sure Model is Generalizable to Unbalanced Data](#modelgeneralizable)
7. [Save the Model](#savemodel)

#### 1. Create a run  {#createrun}

We use a method of our `MLManager` object to create a new run:
```
manager.create_new_run(user_id=‘Ben’)
```
{: .Example}

#### 2. Run the experiment  {#runexperiment}

We'll start our first MLflow run; since our data contains
a limited number of fraudulent examples, we decide to expand that number for training purposes. To achieve this, we oversample fraudulent transactions and undersample non-fraudulent ones:

```
%spark.pyspark
#start our first MLflow run
manager.create_new_run(user_id='Ben')

#oversample fraud data 2X
fraud_data = df.filter('label=1')
print('fraud data has {} rows'.format(fraud_data.count()))
fraud_data = fraud_data.unionAll(fraud_data)
print('fraud data has {} rows'.format(fraud_data.count()))
#log oversample rate
manager.log_param('oversample','2X')

#undersample non-fraud data 1:1
non_fraud_df = df.filter('label=0')
ratio = float(fraud_data.count())/float(df.count())
sampled_non_fraud = non_fraud_df.sample(withReplacement=False,fraction=ratio)
final_df = fraud_data.unionAll(sampled_non_fraud)
#log undersample ratio
manager.log_param('undersample', '1:1')
z.show(final_df)
```
{: .Example}

#### 3. Create a Pipeline  {#createpipeline}
Now we can create a Pipeline to normalize our continuous features. We'll use the `StandardScaler`, which standardizes features by scaling to unit variance and/or removing the mean using, column summary statistics on the samples in the training set.

And we'll create our feature vector with the `VectorAssembler` transformer, which combines a given list of columns into a single vector column

```
%spark.pyspark
from pyspark.ml.feature import StandardScaler, VectorAssembler
from pyspark.ml import Pipeline,PipelineModel
feature_cols = df.columns
feature_cols.remove("label")
feature_cols.remove('TIME_OFFSET')
print("Features: " + str(feature_cols))

assembler = VectorAssembler(inputCols=feature_cols, outputCol='features')
scaler = StandardScaler(inputCol="features", outputCol='scaledFeatures')
stages = [assembler, scaler]
#log preprocessing steps
manager.log_param('preprocessing','Pipeline[VectorAssembler, StandardScaler]')
#log features that we will use
manager.log_param('features',str(feature_cols))
pipeline = Pipeline(stages=stages)
z.show(pipeline.fit(df).transform(df))
```
{: .Example}

#### 4. Train and Run the Model   {#trainandrun}

Now we can train and run this model using the `SpliceBinaryClassificationEvaluator`, again logging our parameters and metrics.

```
%spark.pyspark
from pyspark.ml.classification import MultilayerPerceptronClassifier
from splicemachine.ml.utilities import SpliceBinaryClassificationEvaluator
import time

evaluator = SpliceBinaryClassificationEvaluator(spark)
first = len(feature_cols)
hidden = first/2
output = 2
layers = [first,hidden,output]
nn = MultilayerPerceptronClassifier(maxIter=100, layers=layers, blockSize=64, seed=5724, featuresCol='scaledFeatures')
manager.log_param('classifier', 'neural network')
manager.log_param('maxIter', '100')
manager.log_param('layers', '[{first}, {hidden}, 2]'.format(first=first,hidden=hidden))
manager.log_param('blockSize', '64')

df = df.repartition(50)
train, test = df.randomSplit([0.8,0.2])
t0 = time.time()
stages.append(nn)
full_pipeline = Pipeline(stages=stages)
model = full_pipeline.fit(train)
time_taken = time.time() - t0
print("Model took: " + str(time_taken) + " seconds to train")
#make predictions
predictions = model.transform(test)

evaluator.input(predictions)
z.show(evaluator.get_results())

#log how long the model took
manager.log_metric('time',time_taken)
#log metrics for reference
vals = evaluator.get_results('dict')
for key in vals:
    manager.log_metric(key, vals[key])
```
{: .Example}

#### 5. View Run Information  {#viewruninfo}

You can now view the run in the MLflow user interface, at port `5001`:

<img src='https://s3.amazonaws.com/splice-demo/mlflow_ui_ben_run.png' class="indentedTightSpacing">


#### 6. Make Sure Model is Generalizable to Unbalanced Data  {#modelgeneralizable}
We have a model that looks fairly accurate; however, we trained this model on balanced data, so we need to verify that it can be generalized to work with unbalanced data:

```
%spark.pyspark
#pull in full dataset
new_df = splice.df('select * from cc_fraud.cc_fraud_data')
new_df = new_df.withColumnRenamed('CLASS_RESULT', 'label')

#transform and run model on new dataframe
new_predictions = model.transform(new_df)

new_eval = SpliceBinaryClassificationEvaluator(spark)
new_eval.input(new_predictions)
z.show(new_eval.get_results())
```
{: .Example}

#### 7. Save the Model  {#savemodel}

We want to be able to retrain our model when new data arrives, so we'll save the pipeline and model to an S3 bucket. And since we're planning to deploy this model, we'll also save it to MLflow:

```
%spark.pyspark
#save the pipeline and model to s3
model.save('s3a://splice-demo/fraudDemoPipelineModel')
#save model to MLflow for deployment
manager.log_spark_model(model)
```
{: .Example}

### Trying a Different Model  {#trydifferentmodel}

Now that we've saved our run, we can look at creating a different pipeline and comparing results; this time, we'll re-import the data and create a pipeline by oversampling ata a `1.5x` rate and using a `LogisticRegression` model, in these steps:

1. [Start a new run](#rerun)
2. [Scale and vectorize our features](#scalefeatures)
3. [Train and test the model](#trainandtest)
4. [Test on unbalanced Data](#testunbalanced)
5. [Compare results](#compareresults)
6. [Save the model](#savemodel2)

#### Start a new run {#rerun}

First, we'll create a new run and name it `Amy`:
```
manager.create_new_run(user_id=`Amy`)
```
{: .Example}


Next we'll reload the data from our database table into a Spark DataFrame, and then
 and undersample/oversample like we did previously:

```
%spark.pyspark
from pyspark.ml.classification import LogisticRegression
from pyspark.ml.feature import StandardScaler, VectorAssembler
from pyspark.ml import Pipeline,PipelineModel

#create new run
manager.create_new_run(user_id='Amy')
df = splice.df("SELECT * FROM cc_fraud.cc_fraud_data")
df = df.withColumnRenamed('CLASS_RESULT', 'label')


#oversample fraud data 1.5X
fraud_data = df.filter('label=1')
print('fraud data has {} rows'.format(fraud_data.count()))
#sample half the data
fraud_ratio = 0.5
half_fraud_data = fraud_data.sample(withReplacement=False,fraction=fraud_ratio)
#1.5X as many rows
fraud_data = fraud_data.unionAll(half_fraud_data)
print('fraud data has {} rows'.format(fraud_data.count()))
#log oversample rate
manager.log_param('oversample','1.5X')

#undersample non-fraud data 1:1
non_fraud_df = df.filter('label=0')

ratio = float(fraud_data.count())/float(df.count())
sampled_non_fraud = non_fraud_df.sample(withReplacement=False,fraction=ratio)

final_df = fraud_data.unionAll(sampled_non_fraud)
#log undersample ratio
manager.log_param('undersample', '1:1')
```
{: .Example}

#### 2. Scale and Vectorize our Features  {#scalefeatures}

We'll again use the `StandardScaler` and `VectorAssembler` components to normalize and vectorize our features:

```
%spark.pyspark
#feature engineering
feature_cols = df.columns
feature_cols.remove("label")
print("Features: " + str(feature_cols))

#feature vector and scale features
assembler = VectorAssembler(inputCols=feature_cols, outputCol='features')
scaler = StandardScaler(inputCol="features", outputCol='scaledFeatures')
stages = [assembler, scaler]
#log preprocessing steps
manager.log_param('preprocessing','Pipeline[VectorAssembler, StandardScaler]')
#log features that we will use
for feature,i in zip(feature_cols,range(len(feature_cols))):
    manager.log_param('feature {}'.format(i),feature)
```
{: .Example}


#### 3. Train and Test the Model  {#trainandtest}

Now we can train and test this model:

```
%spark.pyspark
#build and evaluate model
evaluator = SpliceBinaryClassificationEvaluator(spark)
lr = LogisticRegression(featuresCol='scaledFeatures')
manager.log_param('classifier', 'logistic regression')
stages.append(lr)

df = df.repartition(50)
train, test = df.randomSplit([0.8,0.2])
t0 = time.time()
full_pipeline = Pipeline(stages=stages)
model = full_pipeline.fit(train)
time_taken = time.time() - t0
print("Model took: " + str(time_taken) + " seconds to train")
#make predictions
predictions = model.transform(test)

evaluator.input(predictions)
z.show(evaluator.get_results())

#log how long the model took
manager.log_metric('time',time_taken)
#log metrics for reference
vals = evaluator.get_results('dict')
for key in vals:
    manager.log_metric(key, vals[key])
```
{: .Example}

#### 4. Test on Unbalanced Data  {#testunbalanced}

We also need to make sure that this model will generalize to work with unbalanced data:

```
%spark.pyspark
#pull in full dataset
new_df = splice.df('select * from cc_fraud.cc_fraud_data')
new_df = new_df.withColumnRenamed('CLASS_RESULT', 'label')

#transform and run model on new dataframe
new_predictions = model.transform(new_df)

new_eval = SpliceBinaryClassificationEvaluator(spark)
new_eval.input(new_predictions)
z.show(new_eval.get_results())
```
{: .Example}

#### 5. Compare Results  {#compareresults}
We can now visit the MLflow Tracking UI again to compare the results of this run with our previous one:

<img src='https://s3.amazonaws.com/splice-demo/mlflow_ui_both_runs.png' class="indentedTightSpacing">

Though this run was faster, its was not as accurate; the False Positive Rate (FPR) was too high to use for fraud prediction, so we'll move forward with our initial model.

#### 6. Save the run  {#savemodel2}
We'll save this run to S3 for future testing; however, since we won't be deploying it,  we don't need to log it to MLflow at this time.

```
%spark.pyspark
model.save('s3a://splice-demo/fraudDemoPipelineLogisticRegression')
```
{: .Example}

## Deploying the Model with SageMaker  {#deploywithsagemaker}

Once you've run an experiment run that looks good, you can interface with Amazon SageMaker to deploy your model on AWS, following these steps:

1. [Create an ECR Repository for your Experiment](#createEcr).
2. [Find your Experiment and Run IDs](#findIds)
3. [Deploy Your Model](#deploy)


### Step 1: Create an ECR Repository  {#createEcr}

Elastic Container Registry (*ECR*) is Amazon's managed AWS Docker registry service; it supports private Docker repositories with resource-based permissions using AWS IAM so that specific users or Amazon EC2 instances can access repositories and images.

When you tell the *Splice ML Manager* to deploy your model to SageMaker, *ML Manager* creates a Docker image, saves it to your ECR repo, and tells AWS to deploy it for you. You then have an endpoint on AWS with a RESTfull API that your apps can use to interact with your model.

To take advantage of this capability, you need to create a repository on ECR. See the [Amazon ECR documentation](https://docs.aws.amazon.com/AmazonECR/latest/userguide/get-set-up-for-amazon-ecr.html){: target="_blank"} for information about creating your repository.


### Step 2: Find your Experiment and Run IDs  {#findIds}
Before deploying your model, you need to have the IDs of the experiment and run that you want to deploy; you can find both of these in the *MLflow Tracking UI*. Follow these steps:

<div class="opsStepsList" markdown="1">
1. Navigate to port 5001 in your web browser to display the MLflow Tracking UI. For example: `https://myacct-machine.splicemachine.io:5001/#/`.

2. Select the experiment that you want to deploy. In this example, we've selected the experiment named `test_exp`:
   <img src="images/MlflowTrackingUI1.png" class="indentedTightSpacing" class="indentedTightSpacing">

3. Record the Experiment ID displayed for the experiment; in the above example, we're viewing Experiment ID `1`.

4. Select the ID of the run that you want to deploy; here we've selected the topmost (most recent) run of Experiment `1`. When you click this Run ID, you'll see its details displayed:
   <img src="images/MlflowTrackingUI2.png" class="indentedTightSpacing">

5. Copy the `Run ID` value to your clipboard.
</div>

### Step 3: Deploy Your Model  {#deploy}
Once you know your Experiment and Run ID values, you can use the Splice ML Jobs Tracker to deploy your model. Follow these steps:

<div class="opsStepsList" markdown="1">
1. Navigate to port 5003 in your web browser to display the *ML Manager* Jobs Tracker. For example:<br />
`https://myacct-machine.splicemachine.io:5003/#/`
2. Click the <span class="ConsoleLink">deploy</span> link at the top of the screen to display the deploy form:
   <img src="images/MlJobDeploy1.png" class="indentedTightSpacing">
3. Fill in the form fields:
   <table>
       <col />
       <col />
       <thead>
           <tr>
               <th>Field</th>
               <th>Value</th>
           </tr>
       </thead>
       <tbody>
           <tr>
               <td><em>Run UUID</em></td>
               <td>The Run ID that you copied to your clipboard from the MLflow Tracking UI.</td>
           </tr>
           <tr>
               <td><em>Experiment ID</em></td>
               <td>The ID of the experiment that you recorded from the MLflow Tracking UI. </td>
           </tr>
           <tr>
               <td><em>SageMaker App Name When Deployed</em></td>
               <td>The name you want to use for your deployed App.</td>
           </tr>
           <tr>
               <td><em>AWS Region</em></td>
               <td>The AWS regions in which you want the app deployed. Select one of the values from the drop-down list.</td>
           </tr>
           <tr>
               <td><em>Deployment Mode</em>.</td>
               <td><p>Select one of the values from the drop-down list:</p>
                    <table class="noBorder" style="margin-left:0; margin-top:0;">
                        <col />
                        <col />
                        <tbody>
                            <tr>
                                <td><em>Create</em></td>
                                <td>Create a new deployment.</td>
                            </tr>
                            <tr>
                                <td><em>Replace</em></td>
                                <td>Replace an existing deployment.</td>
                            </tr>
                            <tr>
                                <td><em>Add</em></td>
                                <td>??????????????????????????</td>
                            </tr>
                        </tbody>
                    </table>
                </td>
           </tr>
           <tr>
               <td><em>Instance Count</em></td>
               <td>The number of instances that you want deployed.</td>
           </tr>
           <tr>
               <td><em>SageMaker Instance Type</em></td>
               <td>The AWS instance type that you want to use for your deployment. Select one of the values from the drop-down list.</td>
           </tr>
       </tbody>
   </table>

   Here's an example of a completed deployment form:
   <img src="images/MlJobDeploy2.png" class="indentedTightSpacing">

4. Click the <span class="ConsoleLink">Submit</span> button to deploy your model.
</div>

## Retraining the Model with New Data {#UpdateData}

Whenever additional labeled data arrives, we can pull either or both of our models from S3 and run the new data through it, allowing us to easily enhance accuracy over time.

```
%spark.pyspark
#load the fraud data from splicemachine
new_data = splice.df('select * from cc_fraud.cc_fraud_data2')
#load NN model from s3
mod = PipelineModel.load('s3a://splice-demo/fraudDemoPipelineModel')
new_data = new_data.withColumnRenamed('CLASS_RESULT', 'label')

print('running model...')
preds = mod.transform(new_data)
eval = SpliceBinaryClassificationEvaluator(spark)
eval.input(preds)
z.show(eval.get_results())
```
{: .Example}

### Redeploying the Model

To redeploy your model after retraining, you can use the same steps you used when originally deploying it, as described in [Deploy Your Model](#deploy), above. Simply select *Replace* as your deployment mode, and your model will be redeployed.

</div>
</section>
