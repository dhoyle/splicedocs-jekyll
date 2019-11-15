---
summary: A list of the topics in this documentation that apply only to our on-premise product; these topics do not apply to our database-as-a-service product.
title: Splice Machine On-Premise Database
keywords:
toc: false
product: all
sidebar: home_sidebar
permalink: onprem_intro.html
folder: OnPrem
---
{% include splicevars.html %} <section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
{% assign site.guide_heading = "On-Premise Database Product" %}
# Welcome to the Splice Machine On-Premise Database!

Welcome to Splice Machine, the database platform for adaptive
applications that manage operational processes. This site contains
documentation for our <span class="ConsoleLink">On-Premise
Database</span>.

If you're not yet familiar with our lineup of products, please visit the
[Getting Started Page]({{splvar_location_GetStartedLink}}){:
target="_blank"} in our web site to learn more about them.
{: .noteIcon}

Splice Machine delivers an open-source data platform that incorporates
the proven scalability of HBase and the in-memory performance of Apache
Spark. The cost-based optimizer uses advanced statistics to choose the
best compute engine, storage engine, index access, join order and join
algorithm for each task. In this way, Splice Machine can concurrently
process transactional and analytical workloads at scale.

You can deploy the Splice Machine *On-Premise Database* on a standalone
computer or on your own cluster that is managed by Cloudera, MapR, or
Hortonworks. We offer Enterprise, Cluster Community, and Standalone
Community editions. You can also access the open source code for our
community editions on GitHub.

## Getting Started

To get started, read about our products on our web site and decide which
edition is the right one for you, then download a version or contact our
sales team to start using Splice Machine:

* Learn more about our [*Enterprise
  Edition*]({{splvar_location_EnterpriseInfoLink}}){: target="_blank"}
  features and advantages. To purchase this edition, please [contact
  Splice Machine Sales][1] today.
* [Download our free]({{splvar_location_StandaloneLink}}){:
  target="_blank"} *Cluster Community* edition to install on your own
  cluster.
* [Download our free]({{splvar_location_StandaloneLink}}){:
  target="_blank"} *Standalone Community* edition to run on your MacOS,
  Linux, or CentOS computer.

## Using our Documentation

Please visit our [Getting Started with Splice Machine Documentation](gettingstarted_usingdocs.html) topic for
a quick introduction to navigating and using the components of our
documentation system.


### Version Information

{% if site.build_type == "doc" %}
This web contains the current customer documentation for __version {{site.version_display}}__ of Splice Machine.

If you're using an earlier version, you can find the documentation in these locations:

{% if site.build_version == "2.8" or site.build_version == "3.0" %}
* [Splice Machine Version 2.7 Documentation](https://doc.splicemachine.com/2.7/index.html){: target="_blank"}
{% endif %}
* [Splice Machine Version 2.5 Documentation](https://doc.splicemachine.com/2.5/index.html){: target="_blank"}

{% elsif site.build_type == "docstest" %}
This web contains the current internal documentation for <strong>version {{site.build_version}}</strong> of Splice Machine.

If you're using an earlier version, you can find the documentation in these locations:

{% if site.build_version == "2.8" or site.build_version == "3.0" %}
* [Splice Machine Version 2.7 Documentation](https://doc.splicemachine.com/2.7/index.html){: target="_blank"}
{% endif %}
* [Splice Machine Version 2.5 Documentation](https://doc.splicemachine.com/2.5/index.html){: target="_blank"}

{% else %}
This web contains the current internal documentation for <strong>version {{site.build_version}}</strong> of Splice Machine.

<p class="noteIcon">This <em>Internal Development Version</em> of our documentation <strong>DOES NOT</strong> include Search. You must use the top-menu and sidebar navigation to find topics.</p>
{% endif %}

</div>
</section>



[1]: https://www.splicemachine.com/company/contact-us/
