---
title: Splice Machine Kubernetes Ops Center Overview
summary: An overview of the Splice Machine Kubernetes Ops Center.
keywords: Kubernetes Ops Center, Ops Center, service overview, overview of service, availability, support, service support, service terms, license
sidebar: home_sidebar
toc: false
product: all
permalink: opscenter_overview.html
folder: OpsCenter
---
{% include splicevars.html %} <section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Splice Machine Kubernetes Ops Center Overview

Protect against cloud vendor lock-in with a unified deployment across AWS, Azure, GCP, and on-premises K8s clusters.

Simplify management of a stateful, distributed data platform on Kubernetes with the Splice Machine Kubernetes Operator.

the easiest way to provision, manage, and operate a collection of Splice Machine scale-out SQL databases and machine learning platforms.

Kubernetes Ops Center enables you to deploy the Splice Machine database in a Kubernetes environment. You can deploy Kubernetes Ops Center on multiple Cloud environments -- AWS, Azure, and GCP -- and avoid Cloud vendor lock-in. You can also deploy Kubernetes Ops Center on-premises.

Kubernetes Ops Center is designed to meet a diverse range of infrastucture requirements: Cloud, on-prem, or hybrid deployments, and provision, manage, and operate a collection of Splice Machine scale-out SQL databases and machine learning platforms.

 The installation methods that we provide to our customers are the same ones used internally.  We designed our architecture mindful of our customers’ diverse infrastructure needs, knowing that not all of our customers can move their workloads to the cloud.  

When used this way, Kubernetes becomes an environment that you can store one (or many) Splice Machine database instances into.  And, you can have multiple Kubernetes environments, each configured uniquely to your needs.  

If you are not familiar with Kubernetes (often abbreviated as K8s), it is an open-source, portable, extensible platform for managing containerized workloads and services.   It abstracts away the underlying computing resources, allowing users to deploy workloads to the entire cluster instead of a particular server.  It provides you with:

Service discovery and load balancing
Storage orchestration
Automated rollouts and rollbacks
Automated bin packing
Self-healing
Secret and configuration management

Some of the advantages of using Kubernetes are:

Customers protected against vendor logic
Dynamic Scaling - scale up and scale down
Fault Tolerance - failure of the underlying hardware, auto-healing capabilities
Cloud providers allow for a diverse set of server types
Increases developer and admin productivity by having a simplified deployment process
Admin and developers use the same tools regardless of the platform..


## Kubernetes Concepts and Terminology   {#k8sconcepts}

Splice Machine's target Service availability commitment is 99.9% per
calendar month, excluding scheduled downtime. You can expect the
following:

* Splice Machine will deliver product updates with minimal, scheduled
  downtime.
* Splice Machine can recover your database from a stored backup after
  receiving your request to do so.
* Splice Machine can resize your cluster with minimal downtime.

## Deployment Options   {#deploymentoptions}

Splice Machine provides two support options, as shown in the following
table:

<table>
                <col />
                <col />
                <col />
                <col />
                <col />
                <thead>
                    <tr>
                        <th>Support Type</th>
                        <th>Pricing</th>
                        <th>Support Feature</th>
                        <th>Description</th>
                        <th>Details</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <th rowspan="3">Standard Support</th>
                        <td rowspan="3">Free</td>
                        <td>Coverage Hours</td>
                        <td>Monday-Friday<br />9am-6pm Pacific time</td>
                        <td>(subject to local holidays)</td>
                    </tr>
                    <tr>
                        <td>System Impaired</td>
                        <td>Significant issues with speed, quality, or funtionality of Service.</td>
                        <td>&lt; 12 business hours</td>
                    </tr>
                    <tr>
                        <td>Other Issues</td>
                        <td>General queries and guidance requests</td>
                        <td>&lt; 24 business hours</td>
                    </tr>
                    <tr>
                        <th rowspan="5">Business Support</th>
                        <td rowspan="5"><p>As per contract</p><p>Includes SLA</p></td>
                        <td>Coverage Hours</td>
                        <td>24 hours a day, 7 days a week, 365 days a year</td>
                        <td> </td>
                    </tr>
                    <tr>
                        <td>Production System Down</td>
                        <td>Complete loss of Service on Production cluster.</td>
                        <td>&lt; 1 hour</td>
                    </tr>
                    <tr>
                        <td>Production System Impaired</td>
                        <td>Significant issues with speed, quality, or funtionality of Service on Production cluster.</td>
                        <td>&lt; 4 hours</td>
                    </tr>
                    <tr>
                        <td>Production System Down</td>
                        <td>Significant issues with speed, quality, or funtionality of Service on non-production cluster.</td>
                        <td>&lt; 12 hours</td>
                    </tr>
                    <tr>
                        <td>Other Issues</td>
                        <td>General queries and guidance requests</td>
                        <td>&lt; 24 business hours</td>
                    </tr>
                </tbody>
            </table>
### Service Level Agreement (SLA)

Our *business support agreement* includes a *Service Level Agreement
(SLA)* that specifies our commitment to a target Service availability of
99.9% per calendar year, excluding scheduled downtimes.

## Service Terms   {#serviceterms}

Subscription fees are payable monthly in advance on the 1st of the
month, pro-rated for any partial months. We'll charge your credit card
or withdraw payment by ACH on the first of each month, until your
service is cancelled. See your license agreement for more details.

</div>
</section>
