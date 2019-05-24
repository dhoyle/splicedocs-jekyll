---
title: Using the Spark Web UI
summary: How to access the Spark Web UI
keywords: Spark
toc: false
product: all
sidebar: home_sidebar
permalink: developers_tuning_sparkui.html
folder: DeveloperTopics/TuningAndDebugging
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Accessing the Spark Web UI in Your Cluster

This topic shows you how to access the Spark UI on your cluster, in these sections:

* [Accessing the Spark UI on Cloudera](#cloudera)
* [Accessing the Spark UI on HortonWorks Ambari](#ambari)
* [Accessing the Spark UI on MapR](#mapr)

## Accessing the Spark UI on Cloudera  {#cloudera}

Follow these steps to access the Spark UI from Cloudera Manager:

<div class="opsStepsList" markdown="1">
1. From the Cloudera home page, tap the <span class="ConsoleLink">YARN</span> link:
   {: .topLevel}

   <img src="images/sparkui1Cloudera.png" class="indentedSmall" />

2. Select the <span class="ConsoleLink">Web UI</span> drop-down, and tap the <span class="ConsoleLink">ResourceManager Web UI</span> link:
   {: .topLevel}

   <img src="images/sparkui2Cloudera.png" class="indentedSmall" />

3. Select a running Splice Machine application with <span class="ConsoleLink">Tracking UI</span> type <span class="ConsoleLink">ApplicationMaster</span>:
   {: .topLevel}

   <img src="images/sparkui3.png" class="indentedFull" />

4. Tap the <span class="ConsoleLink">ApplicationMaster</span> link to reveal the Spark UI for that application:
   {: .topLevel}

   <img src="images/sparkui4.png" class="indentedFull" />
</div>

## Accessing the Spark UI on HortonWorks Ambari  {#ambari}

Follow these steps to access the Spark UI from Ambari:

<div class="opsStepsList" markdown="1">
1. From the Ambari home page, tap the <span class="ConsoleLink">YARN</span> link:
   {: .topLevel}

   <img src="images/sparkui1Ambari.png" class="indentedSmall" style="max-height:225px" />

2. Select the <span class="ConsoleLink">Quick Links</span> drop-down, and tap the <span class="ConsoleLink">ResourceManagerUI</span> link:
   {: .topLevel}

   <img src="images/sparkui2Ambari.png" class="indentedSmall" />

3. Select a running Splice Machine application with <span class="ConsoleLink">Tracking UI</span> type <span class="ConsoleLink">ApplicationMaster</span>:
   {: .topLevel}

   <img src="images/sparkui3.png" class="indentedFull" />

4. Tap the <span class="ConsoleLink">ApplicationMaster</span> link to reveal the Spark UI for that application:
   {: .topLevel}

   <img src="images/sparkui4.png" class="indentedFull" />
</div>

## Accessing the Spark UI on MapR  {#mapr}

Follow these steps to access the Spark UI from Mapr:

<div class="opsStepsList" markdown="1">
1. From the MapR home page, tap the <span class="ConsoleLink">resourcemanager</span> link:
   {: .topLevel}

   <img src="images/sparkui1Mapr.png" class="indentedSmall" />

2. Tap the <span class="ConsoleLink">Services</span> link:
   {: .topLevel}

   <img src="images/sparkui2Mapr.png" class="indentedMedium" />

3. Scroll down to the <span class="ConsoleLink">YARN</span> section, and tap the <span class="ConsoleLink">Resource Manager</span> link:
   {: .topLevel}

   <img src="images/sparkui3Mapr.png" class="indentedMedium" />

4. Select a running Splice Machine application with <span class="ConsoleLink">Tracking UI</span> type <span class="ConsoleLink">ApplicationMaster</span>:
   {: .topLevel}

   <img src="images/sparkui3.png" class="indentedFull" />

5. Tap the <span class="ConsoleLink">ApplicationMaster</span> link to reveal the Spark UI for that application:
   {: .topLevel}

   <img src="images/sparkui4.png" class="indentedFull" />
</div>



</div>
</section>
