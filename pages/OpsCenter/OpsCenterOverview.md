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

Kubernetes Ops Center enables you to deploy the Splice Machine database in a Kubernetes environment. You can deploy Kubernetes Ops Center both on-premises and in the cloud, and on multiple cloud environments -- AWS, Azure, and GCP -- to prevent cloud vendor lock-in.

Kubernetes Ops Center is designed to meet a diverse range of infrastructure requirements: cloud, on-premises, or hybrid deployments. Kubernetes Ops Center makes it easy to provision, manage, and operate as many Splice Machine database instances as you need, where you need them, with each instance uniquely configured to meet your requirements.  

If you are not familiar with Kubernetes (often abbreviated as K8s), it is an open-source, portable, extensible platform for managing containerized workloads and services. It abstracts away the underlying computing resources, which allows you to deploy workloads to an entire cluster instead of a particular server.

### Kubernetes Features

* Storage orchestration
* Automated rollouts and rollbacks
* Automated bin packing
* Self-healing
* Secret and configuration management

### Kubernetes Advantages

* Customers are protected against vendor logic.
* Dynamic Scaling - scale up and scale down.
* Fault-tolerance - auto-healing capabilities when failure of the underlying hardware occurs.
* Cloud providers allow for a diverse set of server types.
* Simplified deployment process increases developer and administrator productivity.
* Administrators and developers use the same tools regardless of the platform.


## Kubernetes Concepts and Terminology   {#k8sconcepts}

#### Container
A container is a binary executable that contains all of the software, dependencies, and configuration needed to run an application. Containers can run standalone, do not have virtualization overhead, and are smaller than VM images because they only contain the files they need. They are typically created using Dockerfiles and maintained in a container registry.

#### Pod
In Kubernetes a pod runs one or more containers on the same host. It is the smallest deployable unit of computing that you can create and manage in Kubernetes. In most instances, a pod runs only one container. When you create a pod, you define the resources required to run the container(s), such as CPU and memory.

Pods are rarely if ever created directly. They are normally created and managed by a controller. A controller defines a desired state and then compares the desired state against the current state of the Kubernetes cluster. The three most common controllers used by Splice Machine are Deployments, Statefulsets and Daemon Sets.

#### Deployment
A Deployment is a set of multiple, identical Pods with no unique identifier. A deployment automatically replaces any instances that fail or become unresponsive. Deployments are typically used for stateless applications.

#### Statefulset
Statefulsets are similar to deployments, but they have unique persistent identities and stable host names, and are used for stateful applications.

#### DaemonSet
DaemonSets are similar deployments, but they adhere to one-pod-per-node across the entire cluster, or a subset of cluster nodes.  As nodes are added to a cluster, the DaemonSets automatically add pods to the new nodes.

A node is a server, either virtual or physical machine, that contains the services necessary  to run pods.  Nodes can be grouped into node pools that run on the same instance type / size and have the same configuration.  A node pool can have one or more nodes in its pool.  Pods can be deployed to specific node pools using node selectors.

Node affinity/anti-affinity allows you to constrain which nodes a pod can run on based on the nodes’ labels.  Pod affinity/anti-affinity allows you to specify rules about how pods should be placed relative to one another.  Splice Machine uses affinity/anti-affinity rules for both High Availability as well as to ensure some pods are co-located.

Namespaces allow you to group objects together so that you can filter and control them as a unit as well as provide a scope for Kubernetes resources.  In Splice Machine, we use a namespace for each database.

Operators are software extensions to Kubernetes that make use of custom resources to manage applications and their components. Splice Machine has two operators that are defined as a part of the Kubernetes OpsCenter.

### Related Information



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
