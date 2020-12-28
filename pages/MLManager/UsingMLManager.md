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

* [*Architecture*](#Architecture) 
* [*The ML-Workflow*](#The ML-Workflow)
* [*External Data Access*](#External Data Access)
* [*Notebooks*](#Notebooks)
* [*The Native Spark DataSource*](#The Native Spark DataSource)
* [*ML Manager*](#ML Manager)

The [*ML Manager Introduction*](mlmanager_intro.html) topic in this chapter provides an overview of the ML Manager, and the [*ML Manager API*](mlmanager_api.html) topic provides reference information for its API.

## Architecture  {#Architecture}

Under the hood, Splice Machine uses mlflow to manage experiments, runs, models, artifacts, data, and features in Machine Learning experiments. Splice Machine has extended MLFlow functionality to give users full access to the standard MLFlow API as well as custom Splice Machine features (such as feature store tracking and model deployment).

<img class='indentedTightSpacing' src='images/ML_Manager_Architecture.png'>

Splice Machine can handle the ingestion of both real-time and batch data simultaneously, which is discussed in depth here. All interactions can be tracked and monitored using the ```splicemachine.mlflow_support``` module for a full governance data science experience.
</div>


## The ML-Workflow {#The ML-Workflow}

The typical workflow within the Splice Machine platform is:
* Data Ingestion - This can be done either in batch or real-time, using built in support for Nifi, Kafka, Airflow, or Spark Streaming, or through any external tools with JDBC/ODBC support.
* Data exploration and analysis - This is typically done using custom Splice Machine Jupyter notebooks or through the native Hue interface.
* Data investigation and engineering - This again can be managed in Hue for a strong SQL IDE experience, or in Jupyter for users who need access to numerous programming languages simultaneously.
* Machine Learning modeling - At this point in the process, users are using Jupyter notebooks to build and track machine learning models.
* Model Deployment - Either via the Python APIs, or the available Director UI.
* Model Monitoring - Done via SQL, Grafana, Hue or any database visualization tool, as models are deployed and tracked as tables (described in depth below).

## External Data Access {#External Data Access}

Accessing your Splice Machine data from outside the Splice Machine platform is incredibly simple. In Java and Scala, standard JDBC connection instructions are available here. Below we will focus on Python. Under the hood, Splice Machine uses our custom SqlAlchemy driver and ODBC driver to connect to the database. You can connect via raw ODBC or via SqlAlchemy.

To connect via raw ODBC, you must be using Mac or Linux and have Python >= 3.5.
1. Install the necessary packages for your operating system:
   * Mac: iODBC (via brew)
   * Ubuntu: See the Ubuntu section here
   * Centos: See the Centos section here
2. Run ```pip install splicemachinesa```
3. Start a Python interpreter. We recommend IPython or Jupyter

Code Block:
```
from splicemachinesa.pyodbc import splice_connect
cnx = splice_connect(UID, PWD, URL)
cursor = cnx.cursor()
```

Where UID is your database user, PWD is your database password, and URL is the JDBC URL for the database you want to connect to.

You can retrieve your user and password at cloud.splicemachine.io by clicking on your database, and then clicking Retrieve DB Password

<img class='indentedTightSpacing' src='images/ml_manager_home_page.png'>
<img class='indentedTightSpacing' src='images/Retreive_password.png'>

You can access your JDBC URL by clicking on the “Connect” tab in the same dashboard and copying the inner URL. Copy the URL after ```jdbc:splice://``` and before ```:1527```. It will look something like: ```jdbc-<database_name>-<your_dns>```

<img class='indentedTightSpacing' src='images/JDBC_link.png'>

## Notebooks {#Notebooks}

### Accessing your Jupyter Notebooks

The recommended way to interact with your Splice Machine Database is via Hue and Jupyter notebooks. To access Hue, simply click on the SQL Client button in the Cloud Manager UI.

<img class='indentedTightSpacing' src='images/SQL_Client.png'>

This will bring you to the standard Hue SQL Client, where you can run SQL queries with table inspection, auto complete, and result visualizations.

The rest of this section will focus on Notebooks.

To access your Jupyter Notebooks, click on the Notebook button (next to SQL Client).

<img class='indentedTightSpacing' src='images/Notebooks.png'>

This will take you to the JupyterHub login screen. Log in with the credentials you accessed in [*the section above*](#External Data Access)  (using the “Retrieve DB Password” button).
This will bring you to your personal Jupyter Instance. From here, you can walk through the available notebooks in sections 1-7, teaching you how to:

* Create a new user and provide some basic permissions to the new user (section 1)
* Import data from S3, run simple SQL queries, take a look inside the Splice Machine database (Section 2)
* Dive deep into Splice Machine internals, monitor Spark jobs in the database, connect to the database using Scala and Python code, and create simple Applications (Section 3)
* Create custom stored procedures in the database (section 4)
* Run and evaluate benchmarks (section 5)
* Build simple Machine Learning Models (section 6)
* Use ML Manager, the Machine Learning workbench, to build end-to-end machine learning pipelines and deploy them into production using a brand new architecture created by Splice Machine (section 7)

### Using Jupyter Notebooks
Your Jupyter notebook comes pre-integrated with a number of custom enhancements, which we’ll cover in this section. The biggest enhancement is [*Beakerx*](http://beakerx.com/), an open source project that brings polyglot programming and enhanced graphing capabilities to the Jupyter environment. The SQL and Spark customizations have been pre-configured in Splice Machine to work immediately out of the box.

### Polyglot Programming 
Your Jupyter notebook comes with a number of programming languages to choose from. By clicking “New” you can see all of the available kernels.

<img class='indentedTightSpacing' src='images/Jupyter_options.png'>

Whichever Kernel (language) you choose will be the default language of the notebook, but you can switch languages within a given notebook by using the available magic commands. Let’s look at an example. 

<img class='indentedTightSpacing' src='images/py_hello_world.png'>

We can see on the top right that this is a Python3 Kernel, and we can run regular Python from inside the cells. If we want to run a particular cell in SQL, for example, we can do that by using the ```%%sql``` magic in the next cell.

<img class='indentedTightSpacing' src='images/SQL_magic.png'>

You will see that the Sql kernel started successfully, connected to the Splice Machine database, and authenticated with your username and password. Let’s create a Scala cell next and define a function.

```
%%scala

def addInt( a:Int, b:Int ) : Int = {
      var sum:Int = 0
      sum = a + b
      println("Adding in Scala is easy")
      return sum
}

addInt(5, 10)
```

You'll see: 
```Scala started successfully

Adding in Scala is easy
 
Out[1]: 15
```

To see a list of all available magic commands (line magic denoted by ```%``` and cell magic denoted by ```%%```) run ```%lsmagic``` in any cell. Each Kernel (magic) has its own available sub-magics to be used. For example, if you run, in your standard Python cell
```%lsmagic```

You will see one of the magics called ```%%timeit```. This will allow you to time the execution of a cell. Let’s try it.
```
%%timeit
import time
time.sleep(3)
print('Done!')
```

### Sharing Variables 

Beyond using multiple languages in each Notebook, you can also share variables between each cell, even if it’s through different languages. Let’s try it by selecting data from SQL, passing it to Python, modifying the data, and then printing it out in Java. With the table created above, let’s select some data:

```%%sql
select * into ${my_shared_var} from foo;
```

You’ll notice this time that there is no output from the SQL. This is because of the ```into``` syntax we are using. This stores the result of the query as a JSON object. Now we will display the variable as a Pandas dataframe and manipulate it.

```
from beakerx.object import beakerx

beakerx.pandas_display_table()
display(beakerx.get('my_shared_var'))
# Create a new, modified object
beakerx.my_json_var = beakerx.my_shared_var['B'].apply(lambda x: x * x).to_json()
```

Finally, we will return it in Java.

```
%%java

return NamespaceClient.getBeakerX().get("my_json_var");

```
To see everything that comes with your Beakerx setup, check out the [*Beakerx official documentation*](https://mybinder.org/v2/gh/twosigma/beakerx/1.2.0?filepath=StartHere.ipynb).

### Spark

To create a Spark Session in your Jupyter notebook, create a new notebook by clicking “New”, then the language that you’d like.

**Scala:**

<img class='indentedTightSpacing' src='images/Scala.png'>

```%%spark --start
SparkSession.builder
```

**Python:**

<img class='indentedTightSpacing' src='images/Python.png'>

```from pyspark.sql import SparkSession
spark = SparkSession.builder.getOrCreate()
```

You now have a fully scalable Spark Session running on your Kubernetes cluster (**not** locally), so as you want to ingest more data, you can grow your Spark Session to handle it. To monitor your Spark Jobs as they are running, you can use the ```get_spark_ui()``` provided by the Splice Machine Python API. 

Because this API is Python based, you can use the ```%%python``` magic available from the Scala notebook to view the UI. The function will automatically detect the running Spark Session if it was created in Python, but if you created it in Scala, you will need to provide the Spark port. Let’s try that now:

**Again, Python and Scala tabs.**

**Python:**
```
from splicemachine.notebook import get_spark_ui
get_spark_ui()
```

**Scala:**
```
beakerx.sparkPort = sc.uiWebUrl.get.split(":").last
```
Then, in the next cell
```
%%python
from beakerx.object import beakerx
from splicemachine.notebook import get_spark_ui

get_spark_ui(port=beakerx.sparkPort)
```
When working with Spark in Python, you can also access the UI (and other running statistics) through the drop down Spark monitor that appears automatically when you start a Spark task. From a Python cell (after creating a Spark Session), run:
```spark.sparkContext.parallelize(range(520)).collect()```

You will see this drop down.
<img class='indentedTightSpacing' src='images/spark_ui_dropdown.png'>

For Spark Jobs that create a lot of tasks (like machine learning algorithms), you can minimize this by clicking on the arrow in the top right of the drop down. To view a popout of the Spark UI, click the computer icon in the top right corner (next to the X).

To end your Spark Session and free up those resources, you can run (in either Scala or Python)
```spark.stop()```

### Customizing your Notebooks
Each Jupyter Notebook instance is custom to the user, so each user gets their own dedicated environment. This brings ultimate customization, allowing users to build or install open source plugins, python/conda packages, and even create new conda environments for work. Keep in mind that the Splice Machine Jupyter notebooks are already customized with a number of enhancements, so installing custom libraries/conda environments may cause certain functionality to act unexpectedly.

Let’s create a custom Conda environment and use it as a Kernel in the notebook. From the home screen in Jupyter, you can create a new terminal session by clicking “New -> terminal”
<img class='indentedTightSpacing' src='images/Terminal.png'>

From there, we can create a new conda environment. Let’s first check to see which version of Python we are running.
```Python --version```

Great, now we will create an environment with Python 3.8
```
conda create -y -n NewPyEnv python=3.8
source activate NewPyEnv
pip install ipykernel
python -m ipykernel install --user --name NewPyEnv --display-name "NewPyEnv"
```
You can now create a new notebook and click “NewPyEnv” from the dropdown to use your new environment. We can confirm that this environment is running Python3.8

<img class='indentedTightSpacing' src='images/sys_version.png'>

To learn more about managing environments, see the Conda [*documentation*](hhttps://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html).


### Native Spark DataSource 

The Native Spark Datasource is a component created by Splice Machine to give distributed, scalable data access to the Splice Database through Dataframe APIs. The Native Spark Datasource accesses data from the database without needing to serialize the data through JDBC or ODBC. The data is immediately distributed across the Spark Session and is lazily evaluated. This gives Data scientist, engineers and analysts a pure DataFrame interface to interact with data that won’t fit in memory.

<img class='indentedTightSpacing' src='images/NSDS.png'>

### Using the Native Spark DataSource 

To use the Native Spark Datasource, you must first have a running Spark Session. To learn more about Spark Sessions on Splice Machine, see [*spark*](#spark).

Once you have your Spark Session, run:

```
from splicemachine.spark import PySpliceContext
splice = PySpliceContext(spark)
```

You can now access your database tables using the PySpliceContext. To see the available functions and their definitions, run
```help(splice)```

Let’s create a simple table and then read in that data.

```
%%sql
drop table if exists foo;
create table foo (a int, b double);
insert into foo values(52, 142.14);
insert into foo values(535, 222.14);
insert into foo values(656, 77.164);
insert into foo values(1290, 10294.22);
insert into foo values(332, 12452.11);
select * from foo;
```

Now, in Python:
```
df = splice.df('select * from foo')
df.describe().show()
```
We can see some basic information about our Spark Dataframe. We now have a distributed Spark dataframe that can scale to millions and billions of rows.

### Basic Spark Dataframe Manipulations 

Spark dataframes are a bit different than Pandas, and utilize a more functional paradigm. Let’s look at some basic functions.
* Cast
* Sum
* Count
* Distinct
* withColumn and withColumnRenamed

To cast a column to another datatype, you can use the withColumn function.

Let’s cast our column 5 from an int to a string
```
df = df.withColumn('A', df['A'].cast('string'))
df.printSchema()
```
You can also use the official “Types” from spark by importing from pyspark.sql.types. The following code is identical:
```
from pyspark.sql.types import StringType
df = df.withColumn('A', df['A'].cast(StringType()))
df.printSchema()
```

To get the sum of a column, we can use the ```groupBy``` function to group the dataframe by each available column, ```sum``` to get the sum of each (numeric) column, and then ```collect``` to run the evaluation and show the results. Without the ```collect```, the Spark job will not start because Spark is lazy, and requires an action to begin calculations.
```
df.groupBy().sum().collect()
```

If the output you saw was only a sum for column B, that’s because we modified column A to be a String! We’ll need to make that an int again to get a sum.

```
df = df.withColumn('A', df['A'].cast('int'))
df.groupBy().sum().collect()

```
To get the number of rows in the dataframe, simply run
```
df.count()
```

And to get the number of distinct rows, run
```
df.distinct().count()
```

To rename a column, you can use
```
df = df.withColumnRenamed('A', 'newA')
df.show()
```

For a list of all available functions, see the Pyspark [*documentation*](https://spark.apache.org/docs/2.4.4/api/python/_modules/pyspark/sql/functions.html). To see all available functions from the Native Spark Datasources, see [*here*]([*documentation*](https://spark.apache.org/docs/2.4.4/api/python/_modules/pyspark/sql/).

### Koalas 

Many people may be more comfortable and familiar with the Pandas DataFrame API. It  it more Pythonic in nature and is simpler for many calculations. Koalas, an open source project, brings Pandas APIs to Spark dataframes. As you interact with your Koalas dataframe, Koalas translated those actions into Spark tasks under the hood.

To use Koalas on Splice Machine, simply run:
```
!pip install -q koalas
```

In the notebook. Then, before starting your Spark Session, run
```
import databricks.koalas as ks
```

**Note: You must import koalas before starting your Spark Session.**

Now that you have Koalas imported, and you start your Spark Session, you can import data.
```
df = splice.df('select * from foo').to_koalas()
df
```

You’ll see that the dataframe is displayed as a Pandas df. We can now use Pandas functions.
```df[df.B > 250]```

To see what Koalas is doing under the hood on any given function, you can add ```.spark.explain()``` to any dataframe manipulation you make.

```df[df.B > 250].spark.explain()```

To see everything Koalas can do, check out the [*documentation*](https://koalas.readthedocs.io/en/latest/getting_started/10min.html). 

### Getting Data into your Database

Now that we understand our environment a bit better, we can bring our own data into the system. There are a number of ways to get data into your Splice Machine Database. Here we’ll cover 3 basic ways.

### File Import 

On our Cloud Manager dashboard, there is a File Import tab to bring data directly from your machine into tables in your database. Simply click on the Data Import tab, and upload or drag and drop a file onto the screen. 

You can download [*documentation*](https://raw.githubusercontent.com/Ben-Epstein/Medium-Aritcles/master/sample.csv) sample dataset by right **click -> save as** and follow along. 

First, click on the Data Import tab.

<img class='indentedTightSpacing' src='images/data_import.png'>

Now, upload the sample.csv file provided above. You’ll see the following

<img class='indentedTightSpacing' src='images/create_new_table.png'>

We can now provide a table name, like ```sample_data_import```. The delimiter is correct as comma, and this dataset does have headers so we will leave that checked. The datatypes look correct, as do the column names, so we can accept and import.

When prompted for a username and password, you can access those via the “Retrieve DB Password” button at the top of the page. 

<img class='indentedTightSpacing' src='images/DB_password.png'>

That’s it! You now have a new table

<img class='indentedTightSpacing' src='images/create_new_table_2.png'>

You can export the SQL used to create the table or import a new file.

### Naive Spark DataSource 

For users who are comfortable with Python and Pandas, getting data into the database is extremely simple. If you can get your data into a dataframe, it can be put into the database. If you would like to learn more about the Native Spark Datasource, see [*here*](#Native Spark DataSource). Let’s use the same dataset as above. We will head to our Jupyter Notebooks, which you can see how to access [*here*](#Notebooks).
Once there, you can upload a new file.

<img class='indentedTightSpacing' src='images/jupyter_upload.png'>


Now we’ll create a new notebook. To import data into the database using Python, we’ll need to connect to the database using the Native Spark Datasource. See [*here*](#Native Spark DataSource) for detailed information about the Native Spark Datasource. We’ll create a Spark Session, then a PySpliceContext (Python Native Spark Datasource wrapper).

```
from pyspark.sql import SparkSession
spark = SparkSession.builder.getOrCreate()

from splicemachine.spark import PySpliceContext
splice = PySpliceContext(spark)
```

Great, now we can read in our data with any system we want. We’ll use Pandas for simplicity. From Pandas, we can easily get a Spark Dataframe ready for database table insertion.

```
import pandas as pd

pdf = pd.read_csv('sample.csv')
df = spark.createDataFrame(pdf)
```

Now we can both create a table and insert our dataframe.

```
splice.createTable(df, 'sample_table_python', to_upper=True, drop_table=True)
splice.insert(df, 'sample_table_python', to_upper=True)
```

We pass ```to_upper=True``` because the database is case sensitive by default and defaults columns to uppercase unless otherwise specified. So it is best practice to set columns to upper case when using the Native Spark Datasource to interact with database tables.

Now that we’ve created our table and inserted our data, we can read the data from SQL using our ```%%sql``` magic. To read more about Polyglot programming, see the section [*here*](#Polyglot programming). In the next cell, run:

```
%%sql
select * from sample_table_python;
```

This same paradigm can be used to read data from any source, as long as you can get it into a dataframe format. Reading from HDFS, S3, GCP, Azure Blob store, Github etc can all work exactly the same.

### SQL Import 

For SQL inclined users, Splice Machine has built a SQL API for ingesting from external sources. To use this API, your dataset must be in an external location, such as S3, HDFS, GS etc. To learn how to copy data to S3, see [*here*](#https://doc.splicemachine.com/developers_cloudconnect_uploadtos3.html).

To use the SQL API to import data, you must first have a table created.

Let’s create a table that matches the schema of the dataset we have been working with. 

```
%%sql
DROP TABLE IF EXISTS SAMPLE_SQL_IMPORT;
CREATE TABLE SAMPLE_SQL_IMPORT (
"TIME_OFFSET" BIGINT
,"V1" DOUBLE
,"V2" DOUBLE
,"V3" DOUBLE
,"V4" DOUBLE
,"V5" DOUBLE
,"V6" DOUBLE
,"V7" DOUBLE
,"V8" DOUBLE
,"V9" DOUBLE
,"V10" DOUBLE
,"V11" DOUBLE
,"V12" DOUBLE
,"V13" DOUBLE
,"V14" DOUBLE
,"V15" DOUBLE
,"V16" DOUBLE
,"V17" DOUBLE
,"V18" DOUBLE
,"V19" DOUBLE
,"V20" DOUBLE
,"V21" DOUBLE
,"V22" DOUBLE
,"V23" DOUBLE
,"V24" DOUBLE
,"V25" DOUBLE
,"V26" DOUBLE
,"V27" DOUBLE
,"V28" DOUBLE
,"AMOUNT" DOUBLE
,"CLASS" BIGINT
) ;
```

Now we can import the data using the built in SQL API. We will import the data from the S3 Location holding the sample dataset.

```
%%sql
call SYSCS_UTIL.IMPORT_DATA (
null,
'SAMPLE_SQL_IMPORT',
null,
's3a://splice-demo/kaggle-fraud-data/creditcard.csv',
',',
null,
null,
null,
null,
-1,
's3a://splice-demo/kaggle-fraud-data/bad',
null,
null);

SELECT TOP 250 * FROM SAMPLE_SQL_IMPORT;
```

## ML Manager {#ML Manager}

ML Manager is Splice Machine’s end-to-end data science workbench. With ML Manager, you can create and track models, analyze data and engineer new features, and deploy and monitor models in production.

ML Manager is based on a modified and enhanced MLFlow. To learn about MLFlow and its uses, see [*here*](https://mlflow.org/docs/1.8.0/quickstart.html). In Splice Machine, all Experiments, Runs, Artifacts and Models are stored inside the database, so everything associated with your machine learning models is kept in a secure, durable, ACID compliant data store.

The standard MLFlow API is exposed, with additional functions added for deployment and tracking. To see a list of the full API specifications, see [*here*](hhttps://pysplice.readthedocs.io/en/latest/splicemachine.mlflow_support.html). For interactive notebooks that walk you through using ML Manager, click on the “ML Notebook Walkthrough” link in the Quick Start tab of your [*Cloud Manager Dashboard*](https://cloud.splicemachine.io/register?utm_source=website&utm_medium=header&utm_campaign=sandbox).

<img class='indentedTightSpacing' src='images/Walkthrough.png'>

These notebooks will walk you end-to-end through ingesting data, creating machine learning models, and deploying them to production.

### Setting up MLFlow






















