---
title: Using the Splice Machine Machine Learning Manager
summary: Overview of using the ML Manager
keywords: data science, machine learning
toc: false
product: all
sidebar: mlmanager_sidebar
permalink: mlmanager_using.html
folder: MLManager
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Using the Machine Learning Manager (*MLManager*)

This topic introduces you to the Splice Machine *MLManager*, a machine learning framework that combines the power of Splice Machine with the power of Apache Zeppelin notebooks and Amazon Sagemaker to create a full-cycle platform for developing and maintaining your smart applications. This topic is organized into these sections:

* [*About MLManager*](#aboutMLManager)
* [*Preparing Your Experiment*](#prepareExperiment)
* [*Running Your First Experiment*](#runfirst)
* [*Trying a Different Model*](#trydifferentmodel)
* [*Updating the Model with New Data*](#UpdateData)

## About MLManager {#aboutMLManager}

The MLManager facilitates machine learning development within Zeppelin notebooks.  Here are some of its key features:

* MLManager runs directly on Apache Spark, allowing you to complete massive jobs in parallel.
* Our native PySpliceContext lets you directly access the data in your database and very efficiently convert it to to a Spark DataFrame, with no serialization/deserialization required.
* MLflow is integrated directly into all Splice Machine clusters, to facilitate tracking of your entire Machine Learning workflow.
* After you have found the best model for your task, you can easily deploy it live to AWS SageMaker or AzureML to make predictions in real time.

Here's what the basic flow of processes involved in developing, tuning, and deploying your ML projects looks like with the *MLManager*:

<img class='indentedTightSpacing' src='https://s3.amazonaws.com/splice-demo/ML+full+circle.png'>


### About MLflow

MLflow is an open source platform for managing the end-to-end machine learning lifecycle; with MLflow, you can:

* Track your model training sessions, which are called *runs*. Each run is some code that can record the following information:

  <table>
    <col />
    <col />
    <thead>
        <tr>
            <th>XXX</th>
            <th>XXX</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="ItalicFont">Metrics</td>
            <td><p>Model output metrics, such as F1 score, AUC, Precision, Recall, R^2. </p>
                <p>These map string values such as "F1" to double-precision numbers (e.g. 0.85).</p>
            </td>
        </tr>
        <tr>
            <td class="ItalicFont">Parameters</td>
            <td><p>Model parameters, such as Num Trees, Preprocessing Steps, Regularization.</p>
                <p>These map strings such as "classifier" to strings (e.g. "DecisionTree").</p>
            </td>
        </tr>
        <tr>
            <td class="ItalicFont">Models</td>
            <td><p>Fitted pipelines or models.</p>
                <p>You can log models to later deploy them to SageMaker.</p>
            </td>
        </tr>
        <tr>
            <td class="ItalicFont">Tags</td>
            <td><p>Specific pieces of information associated with a run, such as the project, version, and deployable status.</p>
                <p>These map strings such as "deployable" to strings (e.g. "true").</p>
            </td>
        </tr>
    </tbody>
  </table>


* Group a collection of runs under and *experiment*, which allow you to visualize and compare a set of runs, and to download run artifacts for analysis by other tools.

  Note that each run belongs to an experiment.

In Splice Machine, you use the `MLManager` class to manipulate experiments. You can view your experiments in the MLflow Tracking UI, which you access by pointing your browser at port `5001`.


### About Storing Models and Runs

### About SageMaker


## Preparing Your Experiment  {#prepareExperiment}

In this section, we'll prepare our first experiment, in these steps:

1. Connect to your database
2. Load the data into your database
3. Visualize the data in Zeppelin
4. Set up our `MLManager` instance
5. Use the Splice Machine Native Spark DataSource to transfer the data into a Spark Dataframe (without serialization).

### 1. Connect to your database

First, let's establish a connection to your database using Python via our Native Spark Datasource. We will use the SpliceMLContext to establish our direct connection-- it allows us to do inserts, selects, upserts, updates and many more functions without serialization

```
%spark.pyspark
from splicemachine.spark.context import SpliceMLContext
splice = SpliceMLContext(spark)
```
{: .Example}

### 2. Load the Data into your database

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


### 3. Visualize your data in the Notebook:

For example:
   * Huge data imbalance (fraud)
     ```
     %splicemachine
     select class_result, count(*) from cc_fraud.cc_fraud_data group by class_result
     ```

   * xx
     ```
     %splicemachine
     select class_result, avg(amount) as average from cc_fraud.cc_fraud_data
     group by class_result
     ```

### 4. Create your MLManager Instance

```
%spark.pyspark
from splicemachine.ml.management import MLManager
manager = MLManager()
```
{: .Example}

### 5. Create an Experiment and Get the Data into a Spark DataFrame

We'll import our data using SpliceMLContext. We'll also create an MLflow Experiment named `fraud_demo`:

```
%spark.pyspark
#create our MLflow experiment
manager.create_experiment('fraud-demo')
manager.set_active_experiment('fraud-demo')
df = splice.df("SELECT * FROM cc_fraud.cc_fraud_data")
df = df.withColumnRenamed('CLASS_RESULT', 'label')
z.show(df)
```
{: .Example}

### 6. View your Experiment in the MLflow UI

<img class='log' src='https://s3.amazonaws.com/splice-demo/mlflow_UI_fraud.png' width='60%' style='z-index:5'>


## Running Your First Experiment  {#runfirst}

Now that we're set up, let's create a run named `Ben` and run our experiment:

Note that we use the logging functionality of `MLManager` to record and track the attributes of our run.
{: .noteImportant}


### 1. Create a run
```
manager.create_new_run(user_id=‘Ben’)
```
{: .Example}

### 2. View the experiment:

You can point your browser to port `5001` to view the (currently empty) experiment.

### 3. Run the experiment

We only have a small number of fraud examples, so we'll expand our data by oversampling our fraudulent transactions and undersampling non-fraudulent transactions. Here's the code:

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

### 4. Create a Pipeline
Now we can create a Pipeline to normalize our continuous features. We'll use the `StandardScaler`, which standardizes features by scaling to unit variance and/or removing the mean using column summary statistics on the samples in the training set.

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

### 5. Train and Run the Model

Now we can train and run this model using the `SpliceBinaryClassificationEvaluator`. Note that we continue to use the logging feature to record our parameters and metrics.

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

### 6. View Run Information

You can now point your browser at the MLflow user interface, at port `5001`, to view the run:

<center><img class='log' src='https://s3.amazonaws.com/splice-demo/mlflow_ui_ben_run.png' width='60%' style='z-index:5'></center>


### 7. Make Sure Model is Generalizable to Unbalanced Data
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

### 8. Save the Model

We want to be able to retrain our model when new data arrives, so we'll save the pipeline and model to an S3 bucket. And since we're planning to deploy this model, we'll also save it to MLflow:

```
%spark.pyspark
#save the pipeline and model to s3
model.save('s3a://splice-demo/fraudDemoPipelineModel')
#save model to MLflow for deployment
manager.log_spark_model(model)
```
{: .Example}

## Trying a Different Model  {#trydifferentmodel}

Now that we've saved our run, we can look at creating a different pipeline and comparing results; this time, we'll re-import the data and create a pipeline by oversampling ata a `1.5x` rate and using a `LogisticRegression` model.

### 1. Import the data and undersample/oversample like we did previously:

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

### 2. Scale and Vectorize our Features

And again, we use the `StandardScaler` and `VectorAssembler` to normalize and vectorize our features:

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


### 3. Train and Test the Model

Now we train and test this model:

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

### Test on Unbalanced Data

And make sure that this model will generalize to work with unbalanced data:

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

### Compare Results
Though this run was faster, its accuracy was inferior: the False Positive Rate (FPR) is too high to use for fraud prediction.

<center><img class='log' src='https://s3.amazonaws.com/splice-demo/mlflow_ui_both_runs.png' width='60%' style='z-index:5'></center>

We'll save this run to S3 for future testing; however, since we won't be deploying it,  we don't need to log it to MLflow at this time.

```
%spark.pyspark
model.save('s3a://splice-demo/fraudDemoPipelineLogisticRegression')
```
{: .Example}


## Updating the Model with New Data  {#UpdateData}

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

</div>
</section>
