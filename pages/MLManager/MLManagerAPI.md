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
# The Splice Machine ML Manager API

This topic


* Track your model training sessions, which are called *runs*. Each run is some code that can record the following information:

  <table>
    <col width="15%" />
    <col width="45%"/>
    <col width="40%" />
    <thead>
        <tr>
            <th>Information Type</th>
            <th>Purpose</th>
            <th>Examples</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="ItalicFont">Metrics</td>
            <td>Map string values such as <code>F1</code> to double-precision numbers such as <code>0.85</code>.</td>
            <td>Model output metrics, such as: *F1 score, AUC, Precision, Recall, R^2*.</td>
        </tr>
        <tr>
            <td class="ItalicFont">Parameters</td>
            <td>Map strings such as <code>classifier</code> to strings such as <code>DecisionTree</code>. </td>
            <td>Model parameters, such as Num Trees, Preprocessing Steps, Regularization.</td>
        </tr>
        <tr>
            <td class="ItalicFont">Models</td>
            <td>So that you can subsequently deploy them to SageMaker.</td>
            <td>Fitted pipelines or models.</td>
        </tr>
        <tr>
            <td class="ItalicFont">Tags</td>
            <td>These map strings such as <code>deployable</code> to strings such as <code>true</code>.</td>
            <td>Specific pieces of information associated with a run, such as the project, version, and deployable status.</td>
        </tr>
    </tbody>
  </table>



manager.log_spark_model(model)
    Saves a MLlib model named `model` to MLflow for future deployment

manager.create_experiment('fraud-demo')
    mlflow.create_experiment() creates a new experiment and returns its ID. Runs can be launched under the experiment by passing the experiment ID to mlflow.start_run.


manager.set_active_experiment('fraud-demo')
    mlflow.set_experiment() sets an experiment as active. If the experiment does not exist, creates a new experiment. If you do not specify an experiment in mlflow.start_run(), new runs are launched under this experiment.


manager.create_new_run(user_id=‘Ben’)
    mlflow.start_run() returns the currently active run (if one exists), or starts a new run and returns a mlflow.ActiveRun object usable as a context manager for the current run. You do not need to call start_run explicitly: calling one of the logging functions with no active run will automatically start a new one.


manager.log_param('oversample','2X')
    mlflow.log_param() logs a key-value parameter in the currently active run. The keys and values are both strings.


manager.log_metric('time',time_taken)
    mlflow.log_param() logs a key-value parameter in the currently active run. The keys and values are both strings.


</div>
</section>
