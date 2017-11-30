---
title: Introduction
summary: A list of the topics in this documentation that apply only to our database-as-a-service; these topics do not apply to our on-premise product product.
keywords: home, welcome, dbaas, Service, paas
sidebar:  dbaas_sidebar
toc: false
product: all
permalink: dbaas_intro.html
folder: DBaaS
---
{% include splicevars.html %} <section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Welcome to the Splice Machine Database Service!

Welcome to Splice Machine, the database platform for adaptive
applications that manage operational processes. This site contains
documentation for our <span class="ConsoleLink">Managed Database Service
in the Cloud</span>, which includes Release {{ site.build_version }} of the Splice Machine Database.

## Getting Started With our Database Service

Getting started with our database is as simple as can be; just follow
these steps, and you can be up and running in less than an hour:

<table class="noBorder">
                <col />
                <col width="350px" />
                <col />
				<col />
                <tbody>
                    <tr>
                        <td class="DbaasIntroNum">➊</td>
                        <td class="DbaasIntroStep"><a href="dbaas_cm_login.html">LOG INTO SPLICE MACHINE</a></td>
						<td class="DbaasIntroArrow">→</td>
                        <td class="DbaasIntroDesc">Log in directly, or use your Google or Amazon ID.</td>
                    </tr>
					<tr>
                        <td class="DbaasIntroNum">➋</td>
                        <td class="DbaasIntroStep"><a href="dbaas_cm_initialstartup.html">CREATE DATABASE CLUSTER</a></td>
						<td class="DbaasIntroArrow">→</td>
                        <td class="DbaasIntroDesc">Adjust 4 sliders for your processing and storage needs; your database cluster is ready within 15 minutes.</td>
                    </tr>
                    <tr>
                        <td class="DbaasIntroNum">➌</td>
                        <td class="DbaasIntroStep"><a href="dbaas_zep_simple.html">LOAD YOUR DATA</a></td>
						<td class="DbaasIntroArrow">→</td>
                        <td class="DbaasIntroDesc">Copy data to S3, then perform a fast import. Time required varies with dataset size. Our <a href="dbaas_zep_simple.html">Zeppelin Simple Example</a> provides a quick example.</td>
                    </tr>
                    <tr>
                        <td class="DbaasIntroNum">➍</td>
                        <td class="DbaasIntroStep"><a href="dbaas_zep_getstarted.html">QUERY AND UPDATE YOUR DATABASE</a></td>
						<td class="DbaasIntroArrow">→</td>
                        <td class="DbaasIntroDesc">Use Zeppelin notebooks to quickly update, query, and display results graphically, without coding.</td>
                    </tr>
                </tbody>
            </table>
## Next Steps

Easy next steps you can take to become more proficient with your new
database system:

* Our [About the Splice Machine Database Service](dbaas_about.html)
  topic introduces this edition of Splice Machine and links to main
  documentation pages related to the service.
* Spend some time learning more about [creating and using Zeppelin
  notebooks](dbaas_zep_getstarted.html), which you can use to prepare
  and run SQL DDL and DML, stored procedures, Java, Scala, and Python
  and Spark-SQL programs with Splice Machine data, all without writing
  code.
* Spend a few minutes with our [Cloud Manager
  Interface](dbaas_cm_intro.html), which you can use to modify your
  cluster configuration, administer your account, set up events, and
  review database usage.
* Check this documentation web for best practices, usage tips, developer
  guides, and reference material

</div>
</section>
