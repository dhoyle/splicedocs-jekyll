# Docker Standalone

This is a docker image that will run standalone Splice Machine and Zeppelin.  When the docker image starts it starts
the zeppelin server only.  You need to connect to the container to start splice machine.  This reason it was created
this was is because the intent of this docker image is primarily for training purposes and we want users to know
how to start and stop splice machine in standalone and also give them the option of starting sqlshell.

## To Run the docker image
    docker run -ti --hostname localhost -p 8080:8080 -p 1527:1527 -p 4040:4040 -p 8088:8088 splicemachine/standalone:latest

## To Start Training
When you run the start-splice.sh command it will take a little bit for it to start.  You will see a few lines like the following:

```
Waiting. Ncat: Cannot assign requested address.
. Ncat: Cannot assign requested address.
. Ncat: Cannot assign requested address.
```

    cd splice-training
    ./start-splice.sh
    ./start-zeppelin.sh
    ./sqlshell.sh


## URLs
* Spark User Interface: http://localhost:4040
* Yarn User Interface: http://localhost:8080/cluster
* Zeppelin User Interface: http://localhost:8088

## Get the docker container id
Get the container id using the 'docker ps' command
    docker ps

The output will look like the following
```
CONTAINER ID        IMAGE                             COMMAND             CREATED             STATUS              PORTS                                                                                                         NAMES
0a2faf8ba3d5        splicemachine/standalone:latest   "/bin/bash"         2 minutes ago       Up 2 minutes        0.0.0.0:1527->1527/tcp, 0.0.0.0:4040->4040/tcp, 0.0.0.0:8080->8080/tcp, 0.0.0.0:60010->60010/tcp, 60030/tcp   competent_hypatia
```

## Stop the docker container
Next run the command (replacing <CONTAINER_ID> with the container id from the docker ps command above):

    docker stop <CONTAINER_ID>


## To Remove the docker image after you are done

    docker rmi splicemachine/standalone:latest


## To Cleanup stopped containers
    docker rm $(docker ps -aq)
