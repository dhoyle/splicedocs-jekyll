---
summary: Tips for Fine-Tuning Your Splice Machine Installation Parameters.
title: Fine-Tuning Installation Parameters
keywords: installation, parameters
toc: false
product: onprem
sidebar:  onprem_sidebar
permalink: onprem_install_finetune.html
folder: OnPrem/InstallingSpliceMachine
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Configuring Splice Machine Authentication

{% include splice_snippets/onpremonlytopic.md %}
This topic describes possible modifications to  Splice Machine configuration parameters
that may improve your database experience, depending on your situation:

    SPLICE-1942:    Set minimum parallelism
    SPLICE-1952     Cluster fails to update parcel list
    SPLICE-1954     splice.region.toload.pertask option


* [Setting Minimum Parallelism for Spark Shuffles](#SparkShuffles)
* [Problems with Cluster Failing to Update Parcel List](#ParcelUpdate)
* [XXX](#Option2)

## Setting Minimum Parallelism for Spark Shuffles {#SparkShuffles}

Blah

## Fixing a Parcel Update Problem on CDH {#ParcelUpdate}

If your cluster fails to update the parcel list when checking for new parcels, remove the problematic “https://archive.cloudera.com/sqoop-connectors/parcels/latest/” from configuration. Cloudera put some toxic content there which breaks CM.

## Option 3 {#Option3}

splice.region.toLoad.perTask

bulk_import_hile system procedure generates HFiles and leverage HBase bulk loading capability to load HFiles to HBase. It launches one task to load a region, and each task completes quickly. For a table with thousands of regions, too many tasks will be launched.
Consider load more than one regions for each task, and make the number of regions to load for each task a tunable parameter

</div>
</section>
