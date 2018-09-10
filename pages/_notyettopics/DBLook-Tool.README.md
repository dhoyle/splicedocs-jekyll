Download the file, extract it to a directory and then navigate to the directory where the script get-ddl.sh is. This is only tested this on a mac and linux. It doesn't work on Windows. It assumes that the java command is known.

You may use test.sql to create a test schema and a couple of tables to test.

You may also need to modify get-ddl.sh. For example, the following variables should be changed to match your environment:
HOST=
PORT=
USER=
PASS=


Here are some examples of how to use the tool.

Writing the DDL to a file
./get-ddl.sh -o ddl.sql

Writing the DDL to a file connecting to a database on server MYSERVER, with user SOMEUSER and password MYPASSWORD
/get-ddl.sh -o ddl.sql -h MYSERVER -u SOMEUSER -s MYPASSWORD

Write ddl to a file and only extract the SPLICE schema
./get-ddl.sh -o ddl.sql -z SPLICE

Write ddl to a file and only extract the table TABLE1 in schema SPLICE
./get-ddl.sh -o ddl.sql -z SPLICE -t "TABLE1"

Write ddl to a file and only extract the table TABLE1 and TABLE2 in schema SPLICE
./get-ddl.sh -o ddl.sql -z SPLICE -t "TABLE1 TABLE2"

Write ddl to a file and only extract the SPLICE schema with verbose output
./get-ddl.sh -o ddl.sql -z SPLICE -v

Add the ddl to the existing to output file
./get-ddl.sh -o ddl.sql -z SPLICE -a
