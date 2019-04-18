---
title: Splice Machine ML Manager Introduction
summary: Machine Learning Manager
keywords: data science, machine learning
toc: false
product: all
sidebar: home_sidebar
permalink: mlmanager_intro.html
folder: MLManager
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
{% assign site.pdf_runninghead = "Machine Learning Manager" %}
# Splice Machine ML Manager

The Splice ML Manager is an integrated machine learning (ML) platform that minimizes data movement and enables enterprises to deliver better decisions faster by continuously training the models on the most updated available data. With Splice ML Manager, data science teams are able to produce a higher number of more predictive models, facilitated by the ability to:

* Experiment frequently using diverse parameters to compare model effectiveness
* Leverage updated operational data to concurrently train the model
* Minimize the movement of data by running the models on your cluster's Spark executors
* Compress the time from model deployment to action

Splice ML Manager provides end-to-end life-cycle management for your ML models, thereby streamlining and accelerating the design and deployment of intelligent applications using real-time data. ML Manager through its tight integration with Splice data platform results in reduced data movement that empowers data scientists to conduct a higher number of experiments to derive better feature vectors with more signal and compare algorithms with varied parameters to build better models in a limited amount of time.

## Overview

The *Splice ML Manager* facilitates machine learning development within Zeppelin notebooks.  Here are some of its key features:

* *ML Manager* runs directly on Apache Spark, allowing you to complete massive jobs in parallel.
* Our native `PySpliceContext` lets you directly access the data in your database and very efficiently convert it to/from a Spark DataFrame with no serialization/deserialization required.
* MLflow is integrated directly into your Splice Machine cluster, to facilitate tracking of your entire Machine Learning workflow.
* After you have found the best model for your task, you can easily deploy it live to AWS SageMaker to make predictions in real time.
* As new data flows in, updating your model is a simple matter of returning to your Notebook, creating new runs, and redeploying by tapping a button.

The Splice ML Manager leverages Apache MLflow and Amazon Sagemaker, and like MLflow, is organized around the concepts of *runs*:

A run is the execution of some data science code; each run can record different types of information, including:

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

For more information about logging information in the ML Manager, see the [ML Manager API](mlmanager_api.html) topic.

ML Manager organizes runs into *experiments*; each experiment groups runs together for a specific task; for example, you might experiment with using  different machine learning models in different runs, to compare results.

## Using ML Manager
The other topics in this section will help you to start using ML Manager:

* [Using the ML Manager](mlmanager_using.html) provides an overview of how you can use MLManager to develop, tune, and deploy your Machine Learning projects.
* [The ML Manager API](mlmanager_api.html) describes the application programming interface you can use in your code to interact with Splice ML Manager.


</div>
</section>
