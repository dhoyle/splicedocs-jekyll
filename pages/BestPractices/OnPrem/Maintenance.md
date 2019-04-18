---
title: Splice Machine Best Practices - Software Updates
summary: Best practices for importing data
keywords: importing
toc: false
product: all
sidebar: home_sidebar
permalink: bestpractices_onprem_maintenance.html
folder: BestPractices
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Best Practices for Maintaining Your Splice Machine Software


This section contains best practice and troubleshooting information related to maintaining your Splice Machine *On-Premise Database* product software, in these topics:

* [Managing Your Disk Space](#DiskSpace)


## Managing Your Disk Space {#DiskSpace}

Make sure to keep an eye on disk space. Yarn automatically refuses to start applications, including the Splice Spark and OlapMaster applications, when the *disk threshold* is crossed. That threshold is set to 90% by default; Splice Machine **strongly recommends against** raising the threshold, because disks slow down as a function of their fullness, due to fragmentation; this could lead to your database ceasing to function.

</div>
</section>
