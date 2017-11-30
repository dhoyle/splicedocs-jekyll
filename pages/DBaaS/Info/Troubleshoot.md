---
summary: Troubleshooting Your Splice Machine Database
title: Troubleshooting and Best Practices
keywords: troubleshooting, best practices
toc: false
product: dbaas
sidebar:  dbaas_sidebar
permalink: dbaas_info_troubleshoot.html
folder: DBaaS/Info
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
{% include splicevars.html %}
# Splice Machine Troubleshooting Tips

This topic provides troubleshooting guidance for these issues that you may encounter with your Splice Machine database:

* [Restarting Splice Machine after an HMaster Failure](*HMasterRestart)

## Restarting Splice Machine After HMaster Failure {#HMasterRestart}

If you run Splice Machine without redundant HMasters, and you lose your HMaster, follow these steps to restart Splice Machine:

1. Restart the HMaster node
2. Restart every HRegion Server node

</div>
</section>
