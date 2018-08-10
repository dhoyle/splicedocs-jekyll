# Hive to Splice Machine DDL Tool Usage
## Quick Start
### Set Properties
The default config file is in *hiveToSplice.properties*, please keep it in the same directory with *HiveToSpliceLoader-1.0.jar*. And also put *log4j.properties* in the same directory.

#### Properties Description

| Property Name              | Example Value | Description |
|:--------------------|:--------------|:------------|
| **HIVEJDBC** | jdbc:hive2://hostname:10000 | Hive JDBC connection string |
| **HIVEUSER** | hive | Hive user name |
| **HIVEPASSWORD** | hive | Hive password |
| **HIVESCHEMA** | test | Source schema in Hive for exporting data|
| **HIVETABLES** | * | Tables in source schema for exporting data. Support multiple tables exporting that separate tables name by comma ',' ex: t1,t2,t3. Star '*' means all tables in the schema |
| **SPLICEJDBC** | jdbc:splice://hostname:1527/splicedb | Splic eMachine JDBC connection string |
| **SPLICEUSER** | splice | Splice Machine user name |
| **SPLICEPASSWORD** | admin | Splice Machine password |
| **SPLICETARGETEXTERNALSCHEMA** | hivetmp | Target schema in Splice Machine for loading data as external tables|
| **SPLICETARGETINTERNALSCHEMA** | hive | Target schema in Splice Machine for loading data as internal tables|
| **MAXSTRINGLENGTH** | 512 | The STRING type in HIVE will convert to VARCHAR(MAXSTRINGLENGTH) in Splice Machine|
| **DDLOUTPUTFILEPREFIX** | splice | Output DDL files prefix |
| **ONLYGENERATEDDL** | false | Setting of whether execute DDLs on Splice Machine. "true" means only generate Splice Machine's DDL without executing them.|
| **IMPORTTOINTERNAL** | false | Setting of whether import Splice external tables to internal.|
### Run DDL Tool
Use the following command to run:
````
   java -jar HiveToSpliceDDLTool-1.0.jar
````
Or run  with specified config file:
````
    java -jar HiveToSpliceDDLTool-1.0.jar hivetosplice.properties
````
The Splice Machine's DDLs will be generated in *splice-createExternal.sql*, *splice-createTarget.sql*, *splice-dropTarget.sql*, *splice-dropExternal.sql* by default.


## Build Codes
Use maven to build the runnable jar file:
````
    mvn clean package
````
The jar file *HiveToSpliceDDLTool-1.0.jar* will be generated in ./target directory.

## Data Type Limitation
Can't use this tool to import Hive table having these data types:
* Array
* Maps
* Struct
* Uniontype
