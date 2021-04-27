---
title: Glossary of terms
summary: A brief glossary of terms included in the Splice Machine documentation
keywords: glossary
toc: false
product: all
sidebar: home_sidebar
permalink: notes_glossary.html
folder: Notes
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Glossary

<dl>

  <dt id="ACID">ACID</dt>
  <dd>The four properties of data transactions that guarantee transactions are processed reliably: Atomicity, Consistency, Isolation, Durability.</dd>

  <dt id="Accuracy">Accuracy</dt>
  <dd>A metric for evaluating model performance. </dd>

  <dt id="Apache_HBase">Apache HBase</dt>
  <dd>A column-oriented database management system that is part of the Apache Hadoop framework and runs on top of HDFS.</dd>

  <dt id="Apache_HCatalog">Apache HCatalog</dt>
  <dd>A table and storage management layer for Hadoop that enables users with different data processing tools to more easily read and write data on the grid.</dd>

  <dt id="Apache_Hadoop">Apache Hadoop</dt>
  <dd>An Apache open source software project that enables the distributed processing of large data sets across clusters of commodity servers. It is designed to scale up from a single server to thousands of machines, with a very high degree of fault tolerance.</dd>

  <dt id="Apache_Hive">Apache Hive</dt>
  <dd>Apache Hive is a data warehouse infrastructure built on top of Hadoop for providing data summarization, query, and analysis.</dd>

  <dt id="Apache_Spark">Apache Spark</dt>
  <dd>Apache Spark is an open-source cluster computing framework that uses in-memory primitives to reduce storage access and boost database performance. Spark allows user applications to load data into a cluster's memory and repeatedly query that data.</dd>

  <dt id="Auto_sharding">Auto-sharding</dt>
  <dd>A database that is automatically and transparently partitioned (sharded) across low cost commodity nodes, allowing scale-out of read and write queries, without requiring changes to the application.</dd>

  <dt id="BI">BI</dt>
  <dd>See <a href='#Business_Intelligence'>Business Intelligence (BI)</a></dd>

  <dt id="Business_Intelligence">Business Intelligence (BI)</dt>
  <dd>Software tools designed to retrieve, analyze, transform and report data previously stored in a data store or warehouse for business analysis.</dd>

  <dt id="CDH">CDH</dt>
  <dd>See <a href='#Cloudera_CDH'>Cloudera CDH</a></dd>

  <dt id="CRM">CRM</dt>
  <dd>See <a href='#Customer_Relationship_Management'>Customer Relationship Management (CRM)</a></dd>

  <dt id="CRUD">CRUD</dt>
  <dd>The four basic functions of persistent storage: Create, Read, Update, Delete. </dd>

  <dt id="Classification">Classification</dt>
  <dd>A machine learning task used to predict a category.</dd>

  <dt id="Cloud_Provider">Cloud Provider</dt>
  <dd>A cloud platform as a service provider, including Amazon Web Services (AWS), Google Cloud Platform (GCP), and Microsoft Azure.</dd>

  <dt id="Cloudera_CDH">Cloudera CDH</dt>
  <dd>Cloudera's software distribution containing Apache Hadoop and related projects, a popular Hadoop platform.</dd>

  <dt id="Cluster">Cluster</dt>
  <dd>A collection of nodes for running containerized applications in Kubernetes or OpenShift.</dd>

  <dt id="Column_Oriented_Data_Model">Column-Oriented Data Model</dt>
  <dd>A model for storing data in a database as sections of columns, rather than as rows of data. In a column-oriented database, all of the values in a column are serialized together.</dd>

  <dt id="Concurrency">Concurrency</dt>
  <dd>The ability for multiple users to access data at the same time.</dd>

  <dt id="Connection_String">Connection String</dt>
  <dd>A configuration string providing information needed to connect to a data source.</dd>

  <dt id="Cross_table,_cross_row_transactions">Cross-table, cross-row transactions</dt>
  <dd>A transaction (a group of SQL statements) that can modify multiple rows (cross-row) in multiple tables (across tables).</dd>

  <dt id="Customer_Relationship_Management">Customer Relationship Management (CRM)</dt>
  <dd>Data storage and analysis tools designed for data focused on customer identification data and business-to-customer interactions.</dd>

  <dt id="DAG">DAG</dt>
  <dd>See <a href='#Directed_Acyclic_Graph'>Directed Acyclic Graph (DAG)</a></dd>

  <dt id="Data_Lake">Data Lake</dt>
  <dd>A centralized repository used to store structured and unstructured data in a raw or unstructured state, typically used for large-scale data storage.</dd>

  <dt id="Data_Source">Data Source</dt>
  <dd>The origination source of data, including flat files, data tables, or streaming data.</dd>

  <dt id="Data_Warehouse">Data Warehouse</dt>
  <dd>A database used for reporting and data analytics. Data warehouses need to efficiently perform aggregation and analytic queries, also known as OLAP queries, such as complex joins, group bys, and window functions. In Splice Machine, data OLAP queries are executed by Spark.</dd>

  <dt id="Database">Database</dt>
  <dd>An organized collection of data.</dd>

  <dt id="Database_Statistics">Database Statistics</dt>
  <dd>A form of dynamic metadata that assists the query optimizer in making better decisions by tracking distribution of values in indexes and/or columns.</dd>

  <dt id="Dataframe">Dataframe</dt>
  <dd>A two-dimensional data structure used natively by Spark and numerous Python libraries, including Pandas.</dd>

  <dt id="Directed_Acyclic_Graph">Directed Acyclic Graph (DAG)</dt>
  <dd>A directed graph with no directed cycles, meaning that no path through the graph loops back to its starting point. DAGs are used for various computational purposes, including query optimization in some databases.</dd>

  <dt id="Docker">Docker</dt>
  <dd>A platform and service for defining, creating, and running application software containers.</dd>

  <dt id="ERP">ERP</dt>
  <dd>See <a href='#Enterprise_Resource_Planning'>Enterprise Resource Planning (ERP)</a></dd>

  <dt id="Enterprise_Resource_Planning">Enterprise Resource Planning (ERP)</dt>
  <dd>Business management software used to collect, store, manage and interpret data from many business activities.</dd>

  <dt id="Feature">Feature</dt>
  <dd>A single variable used in a machine learning model. Inside of the feature store, features are represented as columns inside of a feature set. </dd>

  <dt id="Feature_Engineering">Feature Engineering</dt>
  <dd>The process of transforming raw data inputs to create features for machine learning models.</dd>

  <dt id="Feature_Store">Feature Store</dt>
  <dd>A continuously updated central repository of features used for data science and machine learning. A Feature Store empowers users to search for features available to them, automatically build training sets, serve features to deployed models in milliseconds, and guarantee end-to-end data lineage.</dd>

  <dt id="Flat_File">Flat File</dt>
  <dd>Data stored in an unstructured file format, such as CSV, in which the entire file must be read and parsed to access the data in a structured manner.</dd>

  <dt id="Foreign_Key">Foreign Key</dt>
  <dd>A column or columns in one table that references a column (typically the primary key column) of another table. Foreign keys are used to enture referential integrity.</dd>

  <dt id="Full_JOIN_Support">Full JOIN Support</dt>
  <dd>A feature of database management systems indicating support for all five ANSI-standard JOIN operations: INNER JOIN, LEFT OUTER JOIN, RIGHT OUTER JOIN, FULL OUTER JOIN, and CROSS JOIN.</dd>

  <dt id="HBase">HBase</dt>
  <dd>See <a href='#Apache_HBase'>Apache HBase</a></dd>

  <dt id="HCatalog">HCatalog</dt>
  <dd>See <a href='#Apache_HCatalog'>Apache HCatalog</a></dd>

  <dt id="HDFS">HDFS</dt>
  <dd>See <a href='#Hadoop_Distributed_File_System'>Hadoop Distributed File System (HDFS)</a></dd>

  <dt id="HDP">HDP</dt>
  <dd>See <a href='#Hortonworks_Data_Platform'>Hortonworks Data Platform (HDP)</a></dd>

  <dt id="HTAP">HTAP</dt>
  <dd>See <a href='#Hybrid_(HTAP)_Database'>Hybrid (HTAP) Database</a></dd>

  <dt id="Hadoop">Hadoop</dt>
  <dd>See <a href='#Apache_Hadoop'>Apache Hadoop</a></dd>

  <dt id="Hadoop_Distributed_File_System">Hadoop Distributed File System (HDFS)</dt>
  <dd>A distributed file system that stores data on commodity hardware and is part of the Apache Hadoop framework. It links together the file systems on many local nodes to make them into one big file system.</dd>

  <dt id="Helm_Chart">Helm Chart</dt>
  <dd>Software, template files, and settings that that describe configuration for managing Kubernetes deployments.</dd>

  <dt id="Hive">Hive</dt>
  <dd>See <a href='#Apache_Hive'>Apache Hive</a></dd>

  <dt id="Hortonworks_Data_Platform">Hortonworks Data Platform (HDP)</dt>
  <dd>Includes Apache Hadoop and is used for storing, processing, and analyzing large volumes of data. The platform is designed to deal with data from many sources and formats.</dd>

  <dt id="Hybrid_(HTAP)_Database">Hybrid (HTAP) Database</dt>
  <dd>Most databases are optimized for either transactional (OLTP) statements such as a single row lookup or insert, or analytical (OLAP) statements such as a complex join or group by statements. Hybrid (HTAP) databases are optimized to do both types of operations. Splice Machine DB is a hybrid database powered by HBase and Spark that is fully ACID compliant and runs on any cloud or on-premises.</dd>

  <dt id="Inferencing">Inferencing</dt>
  <dd>Using a machine learning model to determine outcomes against live data.</dd>

  <dt id="Ingesting">Ingesting</dt>
  <dd>The process of bringing external data sources into a database or dataset.</dd>

  <dt id="JDBC">JDBC</dt>
  <dd>Java Database Connectivity. An API specification for connecting with databases using programs written in Java.</dd>

  <dt id="JSON">JSON</dt>
  <dd>An open standard format that uses human-readable text to transmit data objects consisting of attributevalue pairs. It is used primarily to transmit data between a server and web applications, as an alternative to XML.</dd>

  <dt id="JVM">JVM</dt>
  <dd>See <a href='#Java_Virtual_Machine'>Java Virtual Machine (JVM)</a></dd>

  <dt id="Java_Virtual_Machine">Java Virtual Machine (JVM)</dt>
  <dd>The code execution component of the Java platform.</dd>

  <dt id="Jupyter">Jupyter</dt>
  <dd>Software to create interactive documents containing live code, visualizations, documentation, and other elements.</dd>

  <dt id="Key_Value_Data_Model">Key-Value Data Model</dt>
  <dd>A data model in which data is represented in pairs: a descriptor, (name or key) and a value that is associated with that key. Also known as key-value pair, name-value pair, field-value pair, and attribute-value pair.</dd>

  <dt id="Kubernetes">Kubernetes</dt>
  <dd>An open-source package for deploying and managing applications at scale. Splice Machine’s Kubernetes ops center empowers it to be deployed anywhere in minutes, and easily managed by any devops engineer.</dd>

  <dt id="ML">ML</dt>
  <dd>See <a href='#Machine_Learning'>Machine Learning (ML)</a></dd>

  <dt id="MLFlow">MLFlow</dt>
  <dd>An open-source library for managing the lifecycle of machine learning models.</dd>

  <dt id="MLOps">MLOps</dt>
  <dd>A contraction of "Machine Learning Operations," similar in usage to DevOps: tools and processes designed to simplify and automate the training, deployment, and monitoring of machine learning models.</dd>

  <dt id="MVCC">MVCC</dt>
  <dd>See <a href='#Multiversion_Concurrency_Control'>Multiversion Concurrency Control (MVCC)</a></dd>

  <dt id="Machine_Learning">Machine Learning (ML)</dt>
  <dd>A branch of artificial intelligence (AI) focused on building inferencing models based on large data sources and that can improve the accuracy of models over time. </dd>

  <dt id="MapR">MapR</dt>
  <dd>A software package capable of running on both hardware and cloud computing services supporting a variety of data workloads from a single cluster, including Apache Hadoop and Apache Spark.</dd>

  <dt id="MapReduce">MapReduce</dt>
  <dd>A programming model and an associated implementation for processing and generating large data sets with a parallel, distributed algorithm on a cluster. </dd>

  <dt id="Model">Model</dt>
  <dd>A file comprised of model data and a prediction algorithm that has been trained to recognize certain types of patterns, that can reason over and make predictions about new data.</dd>

  <dt id="Model_Deployment">Model Deployment</dt>
  <dd>Applying a machine learning model to its intended use case. Model deployment can range from running a model dataset once a year to real-time predictions that have to be generated in milliseconds.</dd>

  <dt id="Multi_Partition_Transaction">Multi-Partition Transaction</dt>
  <dd>Database transactions performed on a table distributed as multiple partitions across multiple nodes in a cluster.</dd>

  <dt id="Multiversion_Concurrency_Control">Multiversion Concurrency Control (MVCC)</dt>
  <dd>A method used to control concurrent access to a database. Concurrency control is needed to bypass the potential problem of someone viewing (reading) a data value while another is writing to the same value.</dd>

  <dt id="MySQL">MySQL</dt>
  <dd>An open source RDBMS that uses SQL.</dd>

  <dt id="NewSQL">NewSQL</dt>
  <dd>A class of modern relational database management systems that seek to provide the same scalable performance of NoSQL systems for online transaction processing (OLTP) read-write workloads while still maintaining the ACID guarantees of a traditional database system.</dd>

  <dt id="NoSQL">NoSQL</dt>
  <dd>A database concept that provides a mechanism for storage and retrieval of data that is modeled in means other than the tabular relations used in relational databases.</dd>

  <dt id="Node">Node</dt>
  <dd>A unit of computing hardware in Kubernetes, representing of a single physical or virtual machine. Containers and Pods run in the context of a node within a cluster.</dd>

  <dt id="Notebook">Notebook</dt>
  <dd>A Jupyter document used for interactive, deployable code and visualizations.</dd>

  <dt id="ODBC">ODBC</dt>
  <dd>See <a href='#Open_Database_Connectivity'>Open Database Connectivity (ODBC)</a></dd>

  <dt id="OLAP">OLAP</dt>
  <dd>See <a href='#Online_Analytical_Processing'>Online Analytical Processing (OLAP)</a></dd>

  <dt id="OLTP">OLTP</dt>
  <dd>See <a href='#Online_Transaction_Processing'>Online Transaction Processing (OLTP)</a></dd>

  <dt id="Online_Analytical_Processing">Online Analytical Processing (OLAP)</dt>
  <dd>An approach to quickly answering multi-dimensional analytical queries in the Business Intelligence world. OLAP tools allow users to analyze multidimensional data interactive from multiple perspectives.</dd>

  <dt id="Online_Transaction_Processing">Online Transaction Processing (OLTP)</dt>
  <dd>A class of information processing systems that facilitate and manage transaction-oriented applications.</dd>

  <dt id="Open_Database_Connectivity">Open Database Connectivity (ODBC)</dt>
  <dd>An open standard API for accessing database management systems, designed to be independent of any specific database or operating system.</dd>

  <dt id="Pipeline">Pipeline</dt>
  <dd>A definition of data trasnsport and data workflows that define data sources, analysis and transformations, and destinations for data storage for further manipulation.</dd>

  <dt id="Pod">Pod</dt>
  <dd>A resource-sharing collection of containerized workloads in a Kubernetes deployment. Pods may contain multiple containers, and operate within the context of a node.</dd>

  <dt id="Point_In_Time_Correctness">Point-In-Time Correctness</dt>
  <dd>Building training sets on real-time data is complex and error-prone because features, predictions, and labels are often generated at different times. Splice Machine’s Feature Store builds training sets automatically with guaranteed point-in-time correctness.</dd>

  <dt id="Query_Optimizer">Query Optimizer</dt>
  <dd>A critical database management system component that analyzes SQL queries and determines efficient execution mechanisms, known as query plans. The optimizer typically generates several plans and then selects the most efficient plan to run the query.</dd>

  <dt id="RDBMS">RDBMS</dt>
  <dd>See <a href='#Relational_Database_Management_System'>Relational Database Management System (RDBMS)</a></dd>

  <dt id="REST">REST</dt>
  <dd>See <a href='#Representation_State_Transfer'>Representation State Transfer (REST)</a></dd>

  <dt id="Real_Time_Machine_Learning">Real-Time Machine Learning</dt>
  <dd>Predictions that are made at a moment’s notice. Real-time machine learning is traditionally powered by a REST endpoint, but many new applications are utilizing a database. Real-time machine learning required complex additional infrastructure, and companies that have done it successfully have built Feature Stores.</dd>

  <dt id="Referential_Integrity">Referential Integrity</dt>
  <dd>A property of data that requires every value of one column in a table to exist as a value of another column in a different (or the same) table. This term is generally used to describe the function of foreign keys.</dd>

  <dt id="Relational_Data_Model">Relational Data Model</dt>
  <dd>A design model for managing data and creating database schemas that typically expresses the data and relationships between data in the form of tables. </dd>

  <dt id="Relational_Database_Management_System">Relational Database Management System (RDBMS)</dt>
  <dd>Database management software for data structured in a relational table format.</dd>

  <dt id="Representation_State_Transfer">Representation State Transfer (REST)</dt>
  <dd>A simple, stateless, client-server protocol use for networked applications, which uses the HTTP requests to communicate among machines. RESTful applications use HTTP requests to post (create or update) data, to read data, and to delete data. Collectively, these are known as CRUD operations.</dd>

  <dt id="Rollback">Rollback</dt>
  <dd>An operation that returns the database to some previous state, typically used for recovering from database server crashes: by rolling back any transaction that was active at the time of the crash, the database is restored to a consistent state.</dd>

  <dt id="SQL">SQL</dt>
  <dd>See <a href='#Structured_Query_Language'>Structured Query Language (SQL)</a></dd>

  <dt id="Scale_Out">Scale Out</dt>
  <dd>A database architecture that doesnt rely on a single controller and scales by adding processing power coupled with additional storage.</dd>

  <dt id="Scale_Up">Scale Up</dt>
  <dd>An architecture that uses a fixed controller resource for all processing. Scaling capacity happens by adding processing power to the controller or (eventually) upgrading to a new (and expensive) controller.</dd>

  <dt id="Scoring">Scoring</dt>
  <dd>Using statistical tests to validate machine learning model outcomes.</dd>

  <dt id="Sharding">Sharding</dt>
  <dd>Splitting data among multiple machines while ensuring that the data is always accessed from the correct place. Also called horizontal partitioning.</dd>

  <dt id="Spark">Spark</dt>
  <dd>See <a href='#Apache_Spark'>Apache Spark</a></dd>

  <dt id="Streaming_Data">Streaming Data</dt>
  <dd>Data records that are generated and delivered continuously, possibly in real time, by a data source.</dd>

  <dt id="Structured_Query_Language">Structured Query Language (SQL)</dt>
  <dd>A standardized language for defining data to be retreieved from a data source.</dd>

  <dt id="Table">Table</dt>
  <dd>A structure for organizing data in rows and columns.</dd>

  <dt id="Time_Series">Time Series</dt>
  <dd>A sequence of data points, typically timestamped and indexed in time order.</dd>

  <dt id="Training">Training</dt>
  <dd>The process of running a machine learning algorithm against training data to learn from to create the machine learning model.</dd>

  <dt id="Transaction">Transaction</dt>
  <dd>A sequence of database operations performed as a single logical unit of work.</dd>

  <dt id="Transformation">Transformation</dt>
  <dd>The process of converting data from one format or structure into another format or structure</dd>

  <dt id="Trigger">Trigger</dt>
  <dd>A database trigger is code that is run automatically in response to specific events on specific tables or views in your database. Triggers are typically configured to maintain data integrity, such as ensuring that an updated value is in range.</dd>

  <dt id="Warehouse">Warehouse</dt>
  <dd>See <a href='#Data_Warehouse'>Data Warehouse</a></dd>

  <dt id="YARN">YARN</dt>
  <dd>An Apache Hadoop component used for job scheduling and resource management, assigning CPU, memory, and storage to applications running on a Hadoop cluster. YARN also enables application frameworks other than MapReduce (like Spark) to run on Hadoop.</dd>

  <dt id="ZooKeeper">ZooKeeper</dt>
  <dd>Part of the Apache Hadoop framework, ZooKeeper provides a centralized infrastructure and services that enable synchronization across a cluster. ZooKeeper maintains common objects needed in large cluster environments. Examples of these objects include configuration information, hierarchical naming space, and so on. Applications can leverage these services to coordinate distributed processing across large clusters.</dd>

</dl>


</div>
</section>

