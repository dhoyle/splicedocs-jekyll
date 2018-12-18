---
title: Splice Machine Training Instructions
summary: How to Get Started With our Training Classes
keywords: training, docker
toc: false
product: all
sidebar: home_sidebar
permalink: training_instructions.html
folder: /Training
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

# Splice Machine Training Instructions
Splice Machine now offers self-paced training to help you learn how to use our products. These classes are packaged in a set of Zeppelin Notebooks that you can run on your computer, using Docker.

The Docker image contains everything you need to learn about using Splice Machine, including a standalone version of our software that works on any Mac, PC, or Linux computer that can run Docker.

<p class="noteIcon" markdown="1">Empowering our clients with the training to get the most out of Splice Machine is one of the services we offer to our current and future customers. For more information, see the *Services* page on <a href="https://www.splicemachine.com/services/" target="_blank">splicemachine.com.</a></p>

## Requirements
Your computer must meet the following minimum requirements:
* Docker-compatible (MacOS, Windows, or Linux)
* 8 GB or more RAM
* 10 GB or more available disk space
* Web browser available

## Running the Training Classes
To use any of our training classes, please follow these steps:

1. [Set Up Docker](#docker)
2. [Run the Splice Machine Docker Image](#runimage)
3. [Run Splice Machine Training](#runtraining)

### Step 1: Set Up Docker  {#docker}
You should start by setting up Docker on your computer.
<p class="noteNote">You must run version 18.06 or later of Docker to use our Training classes.</p>

1.  Download and install Docker. Please click the link in the table below to review Docker requirements and follow the installation steps specific to your operating system:

    * For MacOS, see <a href="https://docs.docker.com/docker-for-mac/install/" target="_blank">Install Docker on Mac</a>.<br />
    * For Linux, see <a href="https://docs.docker.com/install/linux/ubuntu/" target="_blank">Install Docker on Linux</a>.<br />
    * For Windows, see <a href="https://docs.docker.com/docker-for-windows/install/" target="_blank">Install Docker on Windows</a>.
    <div class="noteIcon">
        <p>Windows users should pay special attention to the hardware and software configuration requirements; contact your system administrator if you're uncertain about your machine meeting those requirements.</p>
        <p>We also <strong>strongly recommend</strong> that Windows users pull and load the <code>hello-world</code> image, as described on <a href="https://docs.docker.com/docker-for-windows/#test-your-installation" target="_blank">the Docker<em> test your installation</em> page.</p>
    </div>

2. Once Docker is running, open the *Advanced* tab in Docker's Preferences. Configure these values, as shown in the image below:
   * 12 GB RAM
   * 3 CPUs
   * 1 GB Swap

   <img class="zepfithalfwidth" src="images/dockerprefs.png">

   Click *Apply & Restart* to apply these changes to Docker.

If Docker fails to initialize after changing its preferences:
1. Restart your computer and retry.
2. If that fails, reduce the Docker memory requirement to 10GB and try again.

### Step 2: Run the Splice Machine Docker Image  {#runimage}
Now you're ready to run the Splice Machine training Docker image.
<p class="noteIcon">Do not move this to a background job! It must run in the foreground.</p>

Follow these steps to run the image:

1. Enter the following command in a terminal window:

    `docker run -ti  --sysctl net.ipv6.conf.all.disable_ipv6=1  --name spliceserver  --hostname localhost -p 1527:1527 -p 4040:4040 -p 7078:7078  -p 8080:8080 -p 8090:8090 -p 8091:8091 -p 4041:4041 -p 8081:8081 -p 8082:8082  splicemachine/standalone:1.1.12`
    {: .AppCommand}

    You'll know the image is loaded when you see the Docker prompt:
    {: .spaceAbove}

    `[root@localhost opt] #`
    {: .AppCommand}

    Note that the first time you run image, Docker will download and unpack it; since this is a large image (more than 4GB), this takes some time.
    {: .spaceAbove}

2. Now run our *start-all.sh* script to start the Splice Machine database, Spark, and Zeppelin:

    `[root@localhost opt] # ./start-all.sh`
    {: .AppCommand}

    <p class="noteIcon">Do not move this to a background job! It must run in the foreground.</p>

   Our classes are ready for you (after a couple minutes) when you see these final WARNING messages:
   {: .spaceAbove}
    ```
    WARNING: The (sub)resource method createNote in org.apache.zeppelin.rest.NotebookRestApi contains empty path annotation.

	WARNING: The (sub)resource method getNoteList in org.apache.zeppelin.rest.NotebookRestApi contains empty path annotation.
    ```
    {: .smallCode}


### Step 3: Run Splice Machine Training  {#runtraining}

Once the image is fully started, follow these steps:

1. Navigate to [http://localhost:8090](http://localhost:8090) in your web browser. You'll see a green dot in the upper-right corner of the window to indicate that Zeppelin has initialized correctly.
2. Click *Splice Machine Training* to open our training folder.
3. If this is your first time here, click *Courses Introduction* to see overviews of Splice Machine, Zeppelin, and our training classes.
4. Click one of the training class folders (e.g. *For Data Scientists*), and then proceed through the notebooks in the class in sequence.

<p class="noteIcon">The notebooks within a single class must be run in sequential order, because content in later notebooks may depend on paragraphs in earlier notebooks having already run. For the same reason, please <strong>execute</strong> every paragraph that displays <em>READY</em> <img class="zepinline" src="images/zepPlayIcon.png" alt="Zeppelin Notebook Play button"> by clicking the <img class="zepinline" src="images/zepPlayIcon.png" alt="Zeppelin Notebook Play button"> button.</p>



## When You’re Done...
When you're done with using our training classes:
* Enter `CTRL-C` in the terminal window where the image is running.
* Then, type `exit` to exit the Docker image.

You can then remove the Docker image, using this command:
```
    docker rm spliceserver
```

## Precautions/Troubleshooting
This section contains a few notes about using our training image.

### Restarting
Please note that closing or sleeping your laptop after running `./start-all.sh` will disrupt the database; you may see messages like this in the terminal window:
```
    timestamp source has been closed
```

When this happens, you must stop and restart the Docker container:
{: .spaceAbove}

* Enter `CTRL-C` in the terminal window where the image is running to stop the current process.
* Run these two scripts in succession:
  ```
  ./stop-all.sh
  ./start-all.sh
  ```

### Run in the Foreground!
A reminder: Please __do not run Zeppelin in background mode__; this interferes with Spark jobs running in notebooks.

## What's Coming
We'll be enhancing our notebooks and expanding our training classes in the near.

Stay tuned for these:

* Examples of submitting your apps with `spark-submit`
* Deeper dives into importing data and data ingestion best practices
* Instructions for creating stored procedures that run in the Docker container
* Examples using R
* Additional Machine Learning examples

* *and much more ...*


<div style="margin=auto; width=100%; text-align:center">
<h2>Thanks again for learning more about Splice Machine!</h2>
</div>


</div>
</section>
