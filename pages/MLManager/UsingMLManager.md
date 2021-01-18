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
# Using the Splice Machine ML Manager

This topic shows you how to use the Splice Machine *ML Manager*, a machine learning framework that combines the power of Splice Machine with the power of Jupyter notebooks, Apache MLflow, and Amazon Sagemaker to create a full-cycle platform for developing and maintaining your smart applications.

This topic is organized into the following sections:

* [*Architecture*](#Architecture)
* [*The ML Workflow*](#The_ML_Workflow)
* [*External Data Access*](#External_Data_Access)
* [*Notebooks*](#Notebooks)
* [*The Native Spark DataSource*](#NSDS)
* [*ML Manager*](#ML_Manager)

The [ML Manager Introduction](mlmanager_intro.html) topic in this section provides an overview of the ML Manager, and the [ML Manager API](mlmanager_api.html) topic provides reference information for its API.

## Architecture  {#Architecture}

Splice Machine uses MLFlow to manage experiments, runs, models, artifacts, data, and features in Machine Learning experiments. Splice Machine has extended MLFlow functionality to give users full access to the standard MLFlow API, as well as custom Splice Machine features (such as Feature Store tracking and model deployment).

<img class='indentedTightSpacing' src='images/ML_Manager_Architecture.png'>

Splice Machine can manage the ingestion of both real-time and batch data simultaneously. All interactions can be tracked and monitored using the ```splicemachine.mlflow_support``` module to provide a full governance data science experience.



## The ML Workflow {#The_ML_Workflow}

The typical workflow in Splice Machine is as follows:
* Data Ingestion - This can be done either in batch or real-time, using built in support for Nifi, Kafka, Airflow, or Spark Streaming, or through any external tools with JDBC/ODBC support.
* Data exploration and analysis - This is typically done using custom Splice Machine Jupyter notebooks or through the native Hue interface.
* Data investigation and engineering - This can be managed in Hue for a strong SQL IDE experience, or in Jupyter for users who need simultaneous access to multiple programming languages.
* Machine Learning modeling - At this point in the workflow, users are using Jupyter notebooks to build and track machine learning models.
* Model Deployment - Models are deployed via the Python APIs or the Director UI.
* Model Monitoring - Monitoring is done via SQL, Grafana, Hue, or any database visualization tool, as models are deployed and tracked as tables (described in depth below).

## External Data Access {#External_Data_Access}

Accessing your Splice Machine data from outside the Splice Machine platform is extremely simple. In Java and Scala, standard JDBC connection instructions are available. Below we will focus on Python. Under the hood, Splice Machine uses its custom SqlAlchemy driver and ODBC driver to connect to the database. You can connect via raw ODBC or via SqlAlchemy.

To connect via raw ODBC, you must be using Mac or Linux and have Python version 3.5 or higher.
1. Install the necessary packages for your operating system:
   * Mac: iODBC (via brew)
   * Ubuntu: See the Ubuntu section here
   * Centos: See the Centos section here
2. Run ```pip install splicemachinesa```.
3. Start a Python interpreter. We recommend IPython or Jupyter.

For example:

```
from splicemachinesa.pyodbc import splice_connect
cnx = splice_connect(UID, PWD, URL)
cursor = cnx.cursor()
```

Where `UID` is your database user name, `PWD` is your database password, and `URL` is the JDBC URL for the database you want to connect to.

You can retrieve your user name and password at cloud.splicemachine.io by clicking on your database, and then clicking **Retrieve DB Password**.

<img class='indentedTightSpacing' src='images/ml_manager_home_page.png'>


<img class='indentedTightSpacing' src='images/Retreive_password.png'>

You can access your JDBC URL by clicking the **Connect** tab in the same dashboard and copying the inner URL. Copy the URL after ```jdbc:splice://``` and before ```:1527```. It will look something like: ```jdbc-<database_name>-<your_dns>```

<img class='indentedTightSpacing' src='images/JDBC_link.png'>

## Notebooks {#Notebooks}

### Accessing your Jupyter Notebooks

The recommended method for interacting with your Splice Machine Database is via Hue and Jupyter notebooks. To access Hue, click **SQL Client** in the Cloud Manager UI.

<img class='indentedTightSpacing' src='images/SQL_Client.png'>

This opens the standard Hue SQL Client, where you can run SQL queries with table inspection, auto complete, and result visualizations.

The remainder of this section will focus on Notebooks.

To access your Jupyter Notebooks, click **Notebook**.

<img class='indentedTightSpacing' src='images/Notebooks.png'>

The JupyterHub login screen appears. Log in with the credentials you accessed in [*the section above*](#External_Data_Access)  (using the “Retrieve DB Password” button).
This opens your personal Jupyter Instance. From here, you can walk through the available notebooks in sections 1-7, which teach you to:

1. Create a new user and assign some basic permissions to the new user.
2. Import data from S3, run simple SQL queries, and take a look inside the Splice Machine database.
3. Dive deep into Splice Machine internals, monitor Spark jobs in the database, connect to the database using Scala and Python code, and create simple Applications.
4. Create custom stored procedures in the database.
5. Run and evaluate benchmarks.
6. Build simple Machine Learning Models.
7. Use ML Manager, the Machine Learning workbench, to build end-to-end machine learning pipelines and deploy them into production using a new architecture created by Splice Machine.

### Using Jupyter Notebooks
The Splice Machine Jupyter notebook comes pre-integrated with a number of custom enhancements. The main enhancement is [*Beakerx*](http://beakerx.com/), an open source project that brings polyglot programming and enhanced graphing capabilities to the Jupyter environment. The SQL and Spark customizations have been pre-configured in Splice Machine to work out-of-the-box.

### Polyglot Programming {#polyglot_programming}
The Jupyter notebook includes a number of programming languages. Click **New** to view all of the available kernels.

<img class='indentedTightSpacing' src='images/Jupyter_options.png'>

The kernel (language) you choose will be the default language of the notebook, but you can switch languages within a given notebook using the available magic commands. Let’s look at an example.

<img class='indentedTightSpacing' src='images/py_hello_world.png'>

We can see on the top right that this is a Python3 kernel, and we can run regular Python from inside the cells. If we want to run a particular cell in SQL, for example, we can do that using the ```%%sql``` magic in the next cell.

<img class='indentedTightSpacing' src='images/SQL_magic.png'>

You will see that the SQL kernel started successfully, connected to the Splice Machine database, and authenticated with your user name and password. Next let’s create a Scala cell and define a function.

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

You will see:
```
Scala started successfully

Adding in Scala is easy

Out[1]: 15
```

To see a list of all available magic commands (line magic denoted by ```%``` and cell magic denoted by ```%%```) run ```%lsmagic``` in any cell. Each kernel (magic) has its own available sub-magics to be used. For example, if you run the following command in your standard Python cell:
```
%lsmagic
```

You will see one of the magics named ```%%timeit```. This will allow you to time the execution of a cell. Let’s try it.
```
%%timeit
import time
time.sleep(3)
print('Done!')
```

### Sharing Variables

Beyond using multiple languages in each Notebook, you can also share variables between each cell, even through different languages. Let’s try it by selecting data from SQL, passing it to Python, modifying the data, and then printing it out in Java. With the table created above, let’s select some data:

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
To see everything that comes with your Beakerx setup, see the [*Beakerx official documentation*](https://mybinder.org/v2/gh/twosigma/beakerx/1.2.0?filepath=StartHere.ipynb).

### Spark

To create a Spark Session in your Jupyter notebook, click **New** to create a new notebook, then select a language.

**Scala:**

<img class='indentedTightSpacing' src='images/Scala.png'>

```
%%spark --start
SparkSession.builder
```

**Python:**

<img class='indentedTightSpacing' src='images/Python.png'>

```
from pyspark.sql import SparkSession
spark = SparkSession.builder.getOrCreate()
```

You now have a fully scalable Spark Session running on your Kubernetes cluster (**not** locally), so as you want to ingest more data, you can grow your Spark session to handle it. To monitor your Spark Jobs as they are running, you can use the ```get_spark_ui()``` provided by the Splice Machine Python API.

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
```
spark.sparkContext.parallelize(range(520)).collect()
```

You will see this drop down.

<img class='indentedTightSpacing' src='images/spark_ui_dropdown.png'>

For Spark Jobs that create a lot of tasks (such as machine learning algorithms), you can minimize this by clicking the arrow at the top right of the drop down. To view a popout of the Spark UI, click the computer icon in the top right corner (next to the X).

To end your Spark Session and free up those resources, you can run (in either Scala or Python)
```
spark.stop()
```

### Customizing Notebooks

Each Jupyter Notebook instance is customized to the user, so each user gets their own dedicated environment. This allows users to build or install open source plugins, Python/Conda packages, and even create new Conda environments for work. Keep in mind that the Splice Machine Jupyter notebooks are already customized with a number of enhancements, so installing custom libraries or Conda environments may cause unexpected behavior.

Let’s create a custom Conda environment and use it as a kernel in the notebook. From the home screen in Jupyter, you can create a new terminal session by selecting **New > Terminal**.
<img class='indentedTightSpacing' src='images/Terminal.png'>

From there, we can create a new Conda environment. First let's check to see which version of Python we are running.
```
Python --version
```

Next we'll create an environment with Python 3.8:
```
conda create -y -n NewPyEnv python=3.8
source activate NewPyEnv
pip install ipykernel
python -m ipykernel install --user --name NewPyEnv --display-name "NewPyEnv"
```
You can now create a new notebook and click **NewPyEnv** from the dropdown to use your new environment. We can confirm that this environment is running Python3.8.

<img class='indentedTightSpacing' src='images/sys_version.png'>

To learn more about managing environments, see the [Conda documentation](hhttps://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html).


## Native Spark DataSource {#NSDS}

The Native Spark DataSource is a component created by Splice Machine to give distributed, scalable data access to the Splice database through Dataframe APIs. The Native Spark DataSource accesses data from the database without needing to serialize the data through JDBC or ODBC. The data is immediately distributed across the Spark Session and is lazily evaluated. This gives data scientists, engineers, and analysts a pure DataFrame interface they can use to interact with data that won’t fit in memory.

<img class='indentedTightSpacing' src='images/NSDS.png'>

### Using the Native Spark DataSource

To use the Native Spark DataSource, you must first have a running Spark Session. To learn more about Spark sessions on Splice Machine, see [*spark*](#spark).

Once you have your Spark session, run:

```
from splicemachine.spark import PySpliceContext
splice = PySpliceContext(spark)
```

You can now access your database tables using the PySpliceContext. To see the available functions and their definitions, run:
```
help(splice)
```

Let’s create a simple table and then read in that data:

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
We can see some basic information about our Spark dataframe. We now have a distributed Spark dataframe that can scale to millions and billions of rows.

### Basic Spark Dataframe Manipulations

Spark dataframes are a bit different than Pandas, and utilize a more functional paradigm. Let’s look at some basic functions:

* Cast
* Sum
* Count
* Distinct
* withColumn and withColumnRenamed

To cast a column to another datatype, you can use the withColumn function.

Let’s cast our column 5 from an int to a string:
```
df = df.withColumn('A', df['A'].cast('string'))
df.printSchema()
```
You can also use the official “Types” from Spark by importing from pyspark.sql.types. The following code is identical:
```
from pyspark.sql.types import StringType
df = df.withColumn('A', df['A'].cast(StringType()))
df.printSchema()
```

To get the sum of a column, we can use the ```groupBy``` function to group the dataframe by each available column, ```sum``` to get the sum of each (numeric) column, and then ```collect``` to run the evaluation and show the results. Without the ```collect```, the Spark job will not start because Spark is lazy, and requires an action to begin calculations.
```
df.groupBy().sum().collect()
```

If the output you saw was only a sum for column B, that’s because we modified column A to be a String. We’ll need to make that an int again to get a sum.

```
df = df.withColumn('A', df['A'].cast('int'))
df.groupBy().sum().collect()

```
To get the number of rows in the dataframe, run:
```
df.count()
```

And to get the number of distinct rows, run:
```
df.distinct().count()
```

To rename a column, you can use:
```
df = df.withColumnRenamed('A', 'newA')
df.show()
```

For a list of all available functions, see the [Pyspark documentation](https://spark.apache.org/docs/2.4.4/api/python/_modules/pyspark/sql/functions.html). To see all available functions from the Native Spark Datasources, see the [Spark documentation](https://spark.apache.org/docs/2.4.4/api/python/_modules/pyspark/sql/).

### Koalas

Many people may be more comfortable and familiar with the Pandas DataFrame API. It is more Python-like in nature and is simpler for many calculations. Koalas, an open source project, brings Pandas APIs to Spark dataframes. As you interact with your Koalas dataframe, Koalas translates those actions into Spark tasks.

To use Koalas on Splice Machine, run the following command in the notebook:
```
!pip install -q koalas
```

Next, before starting your Spark session, run:
```
import databricks.koalas as ks
```

**Note: You must import Koalas before starting your Spark Session.**

Now that you have Koalas imported and you have started your Spark Session, you can import data.
```
df = splice.df('select * from foo').to_koalas()
df
```

You’ll see that the dataframe is displayed as a Pandas df. We can now use Pandas functions.
```df[df.B > 250]```

To see what Koalas is doing under the hood on any given function, you can add ```.spark.explain()``` to any dataframe manipulation you make.

```
df[df.B > 250].spark.explain()
```

For more information about Koalas capabilities, see the [Koalas documentation](https://koalas.readthedocs.io/en/latest/getting_started/10min.html).

### Getting Data into your Database

Now that we understand our environment a bit better, we can bring our own data into the system. There are a number of ways to get data into your Splice Machine database. Here we’ll cover three basic ways to import data.

### File Import

You can use the Data Import tab on the Cloud Manager dashboard to import data from your local machine into your database tables. Click the Data Import tab, then upload or drag and drop a file onto the screen.

You can download the [sample dataset](https://raw.githubusercontent.com/Ben-Epstein/Medium-Aritcles/master/sample.csv) used in this example and follow along with the file import steps.

First, click the Data Import tab.

<img class='indentedTightSpacing' src='images/data_import.png'>

Next, upload the `sample.csv` file provided above. You’ll see the following:

<img class='indentedTightSpacing' src='images/create_new_table.png'>

We can now provide a table name, such as ```sample_data_import```. The delimiter is correct as comma, and this dataset has headers, so we will leave that checked. The datatypes look correct, as do the column names, so we can accept and import.

When prompted for a user name and password, you can access those by clicking **Retrieve DB Password** at the top of the page.

<img class='indentedTightSpacing' src='images/DB_password.png'>

That’s it! You now have a new table.

<img class='indentedTightSpacing' src='images/create_new_table_2.png'>

You can export the SQL used to create the table or import a new file.

### Native Spark DataSource

For users who are comfortable with Python and Pandas, getting data into the database is extremely simple. If you can get your data into a dataframe, it can be put into the database. If you would like to learn more about the Native Spark DataSource, see [NSDS](#NSDS). Let’s use the same dataset as above. We will navigate to [Jupyter Notebooks](#Notebooks), which we can use to upload a new file.

<img class='indentedTightSpacing' src='images/jupyter_upload.png'>


Now we’ll create a new notebook. To import data into the database using Python, we’ll need to connect to the database using the Native Spark DataSource. See [NSDS](#NSDS) for detailed information about the Native Spark DataSource. We’ll create a Spark session, then a PySpliceContext (Python Native Spark Datasource wrapper).

```
from pyspark.sql import SparkSession
spark = SparkSession.builder.getOrCreate()

from splicemachine.spark import PySpliceContext
splice = PySpliceContext(spark)
```

Now we can read in our data with any system. We’ll use Pandas for simplicity. From Pandas, we can easily get a Spark Dataframe ready for database table insertion.

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

We pass ```to_upper=True``` because the database is case sensitive by default and defaults columns to uppercase unless otherwise specified. So it is best practice to set columns to upper case when using the Native Spark DataSource to interact with database tables.

Now that we’ve created our table and inserted our data, we can read the data from SQL using our ```%%sql``` magic. To read more about Polyglot programming, see [Polyglot programming](#polyglot_programming). In the next cell, run:

```
%%sql
select * from sample_table_python;
```

This same paradigm can be used to read data from any source, as long as you can get it into a dataframe format. Reading from HDFS, S3, GCP, Azure Blob store, Github, etc. all work exactly the same.

### SQL Import

For SQL users, Splice Machine has built a SQL API for ingesting from external sources. To use this API, your dataset must be in an external location, such as S3, HDFS, GS etc. To learn how to copy data to S3, see <a href="developers_cloudconnect_uploadtos3.html">Uploading Your Data to an S3 Bucket</a>.

To use the SQL API to import data, you must first create a table.

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

## ML Manager {#ML_Manager}

ML Manager is Splice Machine’s end-to-end data science workbench. With ML Manager, you can create and track models, analyze data and engineer new features, and deploy and monitor models in production.

ML Manager is based on a modified and enhanced MLFlow. To learn about MLFlow and its uses, see the [MLFlow documenation](https://mlflow.org/docs/1.8.0/quickstart.html). In Splice Machine, all Experiments, Runs, Artifacts, and Models are stored inside the database, so everything associated with your machine learning models is kept in a secure, durable, ACID compliant data store.

The standard MLFlow API is exposed, with additional functions added for deployment and tracking. To see a list of the full API specifications, see the [Splice Machine API documentation](https://pysplice.readthedocs.io/en/latest/splicemachine.mlflow_support.html). For interactive notebooks that walk you through using ML Manager, click **ML Notebook Walkthrough** on the Quick Start tab of the [Cloud Manager dashboard](https://cloud.splicemachine.io/register?utm_source=website&utm_medium=header&utm_campaign=sandbox).

<img class='indentedTightSpacing' src='images/Walkthrough.png'>

These notebooks will walk you end-to-end through ingesting data, creating machine learning models, and deploying them to production.

### Setting up MLFlow {#Setting_up_MLFlow}

From inside your Splice Machine Jupyter notebook, there is minimal setup required to instantiate MLFlow. Run the following command:

```from splicemachine.mlflow_support import *```

This command automatically connects you to the running MLFlow server. If you want to save and deploy machine learning models, or store artifacts, you must connect MLFlow to the database using the Native Spark DataSource (NSDS). For more information about the NSDS, see [NSDS](#NSDS). The following code will connect and authenticate MLFlow to the database.

```
from splicemachine.mlflow_support import *
from pyspark.sql import SparkSession
from splicemachine.spark import PySpliceContext

spark = SparkSession.builder.getOrCreate()
splice = PySpliceContext(spark)
mlflow.register_splice_context(splice)
```

You can now start using MLFlow.

### Accessing the MLFlow UI

You can access the MLFlow UI from your Jupyter notebooks or your Cloud Manager dashboard.

From Jupyter, run:
```
from splicemachine.mlflow_support import get_mlflow_ui
get_mlflow_ui()
```

In Cloud Manager, click **ML Manager**.

<img class='indentedTightSpacing' src='images/ML_Manager_button.png'>

### Creating a Model {#Model_Creation}
Creating a tracking model is simple. Let's create a model to predict the Iris dataset, and track the parameters and metrics of the model. In the next section, we will [*deploy the model to production*](https://mlflow.org/docs/1.8.0/quickstart.html).


First we'll import the libraries needed to create our scikit-learn model.
```
from splicemachine.mlflow_support import *
from pyspark.sql import SparkSession
from splicemachine.spark import PySpliceContext


spark = SparkSession.builder.getOrCreate()
splice = PySpliceContext(spark)
mlflow.register_splice_context(splice)
```

And set our experiment to organize our work:

```
mlflow.set_experiment('iris_modeling')
```

We can see our experiment by running the following:

```
from splicemachine.notebook import get_mlflow_ui
exp_id = mlflow.client.get_experiment_by_name('iris_modeling').experiment_id
get_mlflow_ui(experiment_id=exp_id)
```

First we get our experiment’s experiment ID, then pass that into the function so the UI opens to our experiment. If nothing is passed, the UI will open to the Default experiment.

Now, the runs we create will be organized and stored under this experiment. Let’s create our training dataset.

```
from sklearn.datasets import load_iris
import pandas as pd
import numpy as np

iris = load_iris()
df = pd.DataFrame(data= np.c_[iris['data'], iris['target']],
columns= ['sepal_length', 'sepal_width','petal_length','petal_width','label'])
```

Next, we can create a simple model, and track it using the MLFlow API.

```
from sklearn.model_selection import train_test_split
from sklearn.ensemble import GradientBoostingClassifier
from sklearn.metrics import mean_squared_error
from splicemachine.mlflow_support.utilities import get_user

train, test = train_test_split(df, test_size=0.2)
with mlflow.start_run(run_name='SKlearn'):
    n_estimators = 10
    learning_rate = 1.0
    model = GradientBoostingClassifier(n_estimators=n_estimators, learning_rate=learning_rate)
    X_train,y_train = train[train.columns[:-1]], train[train.columns[-1]]
    y_train = y_train.map(lambda x: int(x)) # So the model outputs int format
    X_test,y_test = test[test.columns[:-1]], test[test.columns[-1]]

    with mlflow.timer('fit time', param=False):
        model.fit(X_train,y_train)
    mse = mean_squared_error(y_test, model.predict(X_test))
    print('MSE:', mse)

    # Log metrics and parameters
    mlflow.lm('MSE',mse)
    mlflow.lp('model', 'GBT')
    mlflow.lp('num trees', n_estimators)
    mlflow.lp('learning rate', learning_rate)

    run_id = mlflow.current_run_id()
    exp_id = mlflow.current_exp_id()
    # Save the model for deployment or later use
    mlflow.log_model(model, 'sklearn_model')

```
Line by line, what we’ve done here is:
1. Split our dataset into training and testing.
2. Tell MLFlow that we are starting a run. By using the with syntax, MLFlow will gracefully handle any exceptions, logging the run as a failure, and ending the run automatically.
3. Clean our X and Y sets for training and evaluation.
4. Tell MLFlow that we plan to time something, and give the timer a name. We tell MLFlow to log this time as a metric, not a parameter.
5. Train the model.
6. Calculate, print, and log the Mean Squared Error of the model.
7. Log parameters of the model, such as model type, number of tree estimators, learning, and rate.
8. Log the model itself with the name “sklearn_model”.

Next, we can view our run in the MLFlow UI by running:

```
get_mlflow_ui(experiment_id=exp_id)
```

If you want to see more details, you can click on the run itself, or run:

```
get_mlflow_ui(experiment_id=exp_id, run_id=run_id)
```

This will open the MLFlow UI to the Run Details page.

### Deploying ML Models {#Model_Deployment}

Deploying Machine Learning models in Splice Machine is simple. The recommended way to deploy models is via database deployment. You can also deploy models via Sagemaker or AzureML if you are running your cluster on the applicable cloud service provider. Lastly, you can deploy your Model as a pod on Kubernetes. This is an experimental feature.

You can deploy models via the Python API or the UI. To access the deployment UI, click **Job Tracker** on the Cloud Manager dashboard.

<img class='indentedTightSpacing' src='images/DB_password.png'>

You will be prompted for a user name and password, which you can access by clicking **Retrieve DB Password** on the dashboard.

Once in the UI, you can click **Initiate Jobs** to view the available deployment options. Click **Deploy Model to DATABASE** and provide the required parameters.


Next we'll deploy the model created in the previous section on [*model creation*](#Model_Creation).


Connect to MLFlow and the database:
```
from splicemachine.mlflow_support import *
from pyspark.sql import SparkSession
from splicemachine.spark import PySpliceContext

spark = SparkSession.builder.getOrCreate()
splice = PySpliceContext(spark)
mlflow.register_splice_context(splice)
```

Get the Run ID of the model we want to deploy.
```
exp_id = mlflow.get_experiment_by_name('iris_model')
run_id = mlflow.get_run_ids_by_name('SKlearn', experiment_id=exp_id)[0]
```

Deploy the Model:

```
splice.dropTableIfExists('sklearn_model')
schema = splice.getConnection().getSchema()
jid = mlflow.deploy_db(db_schema_name=schema, db_table_name='sklearn_model', run_id = run_id, primary_key={'FLOWER_ID': 'INT'}, create_model_table = True, df=df.drop(columns=['label']))
mlflow.watch_job(jid)
```

We are deploying our model with the following parameters:
* Schema name: Schema of the table deployed to.
* Table name: Table name of the deployment.
* Run ID: The run containing the model we want to deploy.
* Primary_key (at least one) primary key name and its data type.
* Create Model Table: Whether we want the function to create a new database table for the deployment. If this is set to False, the function assumes the provided schema and table name are of a table that already exists.
* Df: A dataframe reference to create the table from. Only required when create_model_table is True.


To see a list of all optional parameters, see the [*API*](https://pysplice.readthedocs.io/en/latest/splicemachine.mlflow_support.html#splicemachine.mlflow_support.mlflow_support._deploy_db).

We then watch the job logs, and our model is deployed in seconds. But what does this mean? There is no endpoint, no docker image, how is this working?

Under the hood, the function inspects the model and dataframe provided, and understands the inputs and outputs of the model. It then creates a new database table that contains the input structure of the model, and attaches a Trigger to the table, so whenever new rows are added to the table, the model automatically evaluates the new row and stores the prediction. For more information, see <ahref="https://doc.splicemachine.com/sqlref_statements_createtrigger.html">Create Trigger</a>.


You can see the SQL generated to create that table and trigger in the output of the cell above. To interact with the model, simply insert rows into the new table.

```
%%sql

insert into sklearn_model (sepal_length, sepal_width, petal_length, petal_width, flower_id) values(2.4, 1.6, 4.4, 0.5, 1);
select * from sklearn_model;
```

You will then see the output of the model, along with the input, the user who made the prediction, when it was made, and the ID of the model that was used for the inference.

You can validate that the model makes the same prediction in Python:

```
loaded_model = mlflow.load_model(run_id=run_id)
loaded_model.predict([[2.4,1.6,4.4,0.5]])
```

This deployment mechanism enables you to track model predictions in a simple and straightforward way, just by issuing standard SQL.

### Deploy From the UI

You can also deploy from outside of the notebook environment. If you noticed, we used a dataframe as one of the parameters in the deploy function. This cannot be provided from a UI. Another option when deploying a model to a new table is to pass a reference table. From the UI, we will pass the same parameters, except for the dataframe, where we will instead use an existing table.

First, we will create a reference table. We can use the Pandas dataframe we created in the [*Model Creation*](#Model_Creation) section to create the table.

```
splice.createTable(spark.createDataFrame(df.drop(columns=['label'])) ,'iris_reference_table')
```

If you don’t have access to that dataframe, you can create the table using SQL.

```
%%sql
CREATE TABLE IRIS_REFERENCE_TABLE (
sepal_length DOUBLE
,sepal_width DOUBLE
,petal_length DOUBLE
,petal_width DOUBLE
) ;
```


Now, in the Job Tracker, click **Initiate Jobs > Deploy Model to DATABASE**.

Get the Run ID of the model you want to deploy. You can get the Run ID by clicking the run in the the MLFlow UI.

<img class='indentedTightSpacing' src='images/ml_flow.png'>

Then, in the Tags section, copy the “Run ID”.

<img class='indentedTightSpacing' src='images/run_id.png'>

<img class='indentedTightSpacing' src='images/ui_deploy.png'>

Set:
* “Create new Table for Deployment” to Yes.
* Paste in the Run ID copied above.
* Set Primary Key to "FLOWER_ID" INT (quotes included).
* Set the Table name to sklearn_model_from_ui.
* Set the Schema name to the user name you used to log in to the Job Tracker.
* Set the reference schema to the user name you used to log in to the Job Tracker.
*Set the reference table to IRIS_REFERENCE_TABLE (which we created above).
* Click **Submit**.

You can then click the Job Tracker link, and then click **View Logs** to get live updates of the status of the model deployment.

<img class='indentedTightSpacing' src='images/job_tracker_ui.png'>

### Deploy a Model to an Existing Table

Deploying a model to an existing table is very similar to creating a new table, with two main differences.
1. The table that exists must have a primary key before deployment.
2. You likely need to define the model_cols parameter.
   * This parameter specifies which columns from the table will be evaluated in the model.

Let’s continue the example from [*Model Deployment*](#Model_Deployment) but with an existing table.

First, we’ll create a table:

```
%%sql
CREATE TABLE EXISTING_IRIS_TABLE (
sepal_length DOUBLE
,sepal_width DOUBLE
,petal_length DOUBLE
,petal_width DOUBLE
,flower_id INT PRIMARY KEY
) ;
```

As you can see, we’ve added a new column, “flower_id” to the table and set it as the primary key. This satisfies the first requirement. The second is that we must specify the necessary columns for the model. We need to do this because without specification, the function will use all available columns for the model (which includes our new flower_id column), and the model will fail because it’s expecting four values but received five.

Let’s do this both from the API and the UI.

**API:**

```
schema = splice.getConnection().getSchema() # Or just replace with your schema of choice
jid = mlflow.deploy_db(schema,'EXISTING_IRIS_TABLE', <YOUR_RUN_ID>, create_model_table=False, model_cols = ['sepal_length','sepal_width','petal_length','petal_width'])
mlflow.watch_job(jid)
```

**UI:**

<img class='indentedTightSpacing' src='images/deploy_ui.png'>

This time we’ve set:
* Create new Table to False.
* Table name to EXISTING_IRIS_TABLE.
* Schema name to our Schema of choice (Your user name will work).
* Model columns to our desired columns.

### Deploy a Model to Kubernetes

In Splice Machine you can also natively deploy a model to Kubernetes. There are a large number of parameters you can set, from autoscaling to cpu_utilization to gunicorn workers, but by default you just need to provide the run id.

Let’s take the model that we just deployed to a table in the database. If we want to deploy that model to a Kubernetes pod that we can hit with a REST endpoint, we simply call:

```
jid = mlflow.deploy_kubernetes(<run_id>)
mlflow.watch_job(jid)
```

And then wait for the pod to become ready. If this is the first model you have deployed as a Kubernetes pod, this can take a few minutes, but subsequent deployments will be faster. The ```watch_job``` will wait until the pod is ready for connections (ready to make predictions), or until it fails, and will provide the logs for either scenario.

Once the pod is ready, you can interact with it through a ```curl``` from the command line or using ```requests```.

Let’s use Python to make a prediction. We’ve deployed the iris model, so it takes four values as input. We can use a Pandas dataframe to structure the request.

```
import requests
import pandas as pd
df = pd.DataFrame(data= [[1,2,3,4],[5,33,2.5,11]],
                     columns= ['sepal_length', 'sepal_width','petal_length','petal_width','label'])

r = requests.post(f‘http://model-{run_id}/invocations’, headers={'Content-Type': 'application/json', 'format':'pandas-split'}, data=df.to_json(orient='split'))
r.to_json()
```

You will now see your predictions! You can pass in data in other formats as well, and you can see those in the [*MLflow documentation*](https://www.mlflow.org/docs/latest/models.html#id38).

Drawbacks of deploying models to Kubernetes as pods include:
* You don’t get the ACID compliance and level of scalability as when deploying the model to the database.
* You don’t have a SQL table memorializing all of your predictions.
* You lose the API-less nature of model interaction (you now need to use the API).

The benefits of Kubernetes model deployment is that you can build fully customized, [*pyfunc*](https://www.mlflow.org/docs/latest/python_api/mlflow.pyfunc.html) models and deploy those as Kubernetes pods. This means that if you are using non-natively supported libraries, or want to implement a custom prediction function, you can do that and simply specify dependencies. Let’s look at a few examples.

### Deploying a fully custom model

Let’s look at an example of a completely custom model. This won’t even use an ML library; in fact it won’t even be a Machine Learning model. It is simply some logic that we package and deploy to Kubernetes.

We will build a “model” that [*adds N*](https://www.mlflow.org/docs/latest/models.html#example-creating-a-custom-add-n-model) to any input and returns it. **Before starting this section, be sure to set up MLflow properly using the [*Setting up MLflow*](#Setting_up_MLFlow) section.**

```
from mlflow.pyfunc import PythonModel

# Define the model class
class AddN(PythonModel):

    def __init__(self, n):
        self.n = n

    def predict(self, context, model_input):
        return model_input.apply(lambda column: column + self.n)


with mlflow.start_run(run_name='addN model') as run:
    # Construct and save the model
    model_path = "add_n_model"
    add5_model = AddN(n=5)
    # Log model to Splice MLflow
    mlflow.log_model(add5_model, model_lib='pyfunc')

# Load the model in 'python_function' format
loaded_model = mlflow.load_model(run.info.run_uuid, as_pyfunc=True)

# Evaluate the model
import pandas as pd
model_input = pd.DataFrame([range(10)])
model_output = loaded_model.predict(model_input)
assert model_output.equals(pd.DataFrame([range(5, 15)]))

# Deploy model
jid = mlflow.deploy_kubernetes(run.info.run_uuid)
mlflow.watch_job(jid)
```

As you can see, it was relatively simple to build a model that adds 5 to any input. No model library, no ML, just some business logic. This could be extended to do anything you’d like, and you can pass in a custom conda.yaml file to specify external dependencies.

Once we build the model, we deploy it to Kubernetes and watch the job so we wait until the model is ready for requests. Once it is ready, we can interact with it using the requests library.

```
import pandas as pd
import requests
df = pd.DataFrame([range(5, 15)])
r = requests.post(f'http://model-{run.info.run_uuid}/invocations', headers={'Content-Type': 'application/json', 'format':'pandas-split'}, data=df.to_json(orient='split'))
display(pd.DataFrame(r.json()))
```
And you’ll see the same result!

### Debugging K8s pod deployment
Sometimes it can be difficult to set up your environment perfectly for remote pod (Kubernetes) deployment.

A simple way to debug your pod is to deploy it locally to your Jupyter pod. In this model, you can access the pod via ```localhost``` and view all of the logs on your Jupyter environment.

To run the model locally, the first step is to save your model locally to disk. You can do this via the [save_model](https://www.mlflow.org/docs/latest/python_api/mlflow.pyfunc.html#mlflow.pyfunc.save_model) function. MLFlow has a save_model function for every supported library, as well as pyfunc (linked above) which can support arbitrary models with custom dependencies.

Alternatively, if you have already logged you model to Splice Machine’s MLflow, you can download that model directly (as it is stored as a zipped save_model directory), and unzip it on the disk. You can download your model by running
```
mlflow.download_artifact(name=model_name, local_path=path/to/download.zip, run_id=<run_id>)

!unzip path/to/download.zip -d path/to/downloaded_model_folder
```
You now have your saved model as a folder on disk. Now, in your terminal you can run:
```
mlflow models -m /pat/to/downloaded_model_folder
```

</div>
</section>
