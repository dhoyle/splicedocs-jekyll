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

Kubernetes Ops Center enables you to deploy the Splice Machine database in a Kubernetes environment. You can deploy Kubernetes Ops Center both on-premises and in the cloud, and on multiple cloud environments – AWS, Azure, and GCP – to prevent cloud vendor lock-in.

Kubernetes Ops Center is designed to meet a diverse range of infrastructure requirements: cloud, on-premises, or hybrid deployments. Kubernetes Ops Center makes it easy to provision, manage, and operate as many Splice Machine database instances as you need, where you need them, with each instance uniquely configured to meet your requirements.  

If you are not familiar with Kubernetes (often abbreviated as K8s), it is an open-source, portable, extensible platform for managing containerized workloads and services. It abstracts away the underlying computing resources, which allows you to deploy workloads to an entire cluster rather than a particular server.

### Kubernetes Features

* Storage orchestration
* Automated rollouts and rollbacks
* Automated bin packing
* Self-healing
* Secret and configuration management

### Kubernetes Advantages

* Customers are protected against vendor logic.
* Dynamic Scaling – scale up and scale down.
* Fault-tolerance – auto-healing capabilities when failure of the underlying hardware occurs.
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

#### Node
A node is a server, either a virtual or a physical machine, that contains the services necessary to run pods.  Nodes can be grouped into node pools that run on the same instance type/size and have the same configuration. A node pool can have one or more nodes in its pool. Pods can be deployed to specific node pools using node selectors.

Node affinity/anti-affinity allows you to constrain which nodes a pod can run on based on the node labels. Pod affinity/anti-affinity lets you specify rules about how pods should be placed relative to one another. Splice Machine uses affinity/anti-affinity rules for high availability, as well as to ensure some pods are co-located.

#### Namespaces
Namespaces allow you to group objects together so that you can filter and control them as a unit, as well as provide a scope for Kubernetes resources. In Splice Machine, we use a namespace for each database.

#### Operators
Operators are software extensions to Kubernetes that make use of custom resources to manage applications and their components. Splice Machine has two operators that are defined as a part of the Kubernetes OpsCenter.

### Related Information

* [Kubernetes Documentation](https://kubernetes.io/docs/home/)
* [Interactive Kubernetes Tutorials](https://kubernetes.io/docs/tutorials/)


## Deployment Options   {#deploymentoptions}

<table>
    <col width="20%" />
    <col />
    <thead>
        <tr>
            <th>Deployment Option</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Splice Machine Kubernetes Ops Center Managed Service</td>
            <td>Full solution managed by Splice Machine on the customer’s cloud or in Splice Machine’s cloud environment. </td>
        </tr>
        <tr>
            <td>Splice Machine Kubernetes Ops Center</td>
            <td>Full solution provided to the customer to support and manage.</td>
        </tr>
        <tr>
            <td>Splice Machine Kubernetes Enterprise Edition</td>
            <td>Helm Charts or Rancher catalog to be integrated by the customer into their Kubernetes environment with enterprise features enabled.</td>
        </tr>
        <tr>
            <td>Splice Machine Kubernetes Community Edition</td>
            <td>Helm Charts or Rancher catalog to be integrated by the customer into their Kubernetes environment.</td>
        </tr>
    </tbody>
</table>

### Service Install

With the Kubernetes Ops Center, you get the scripts that Splice Machine uses to stand up a Kubernetes environment in each of the three major cloud providers: GCP, AWS, and Azure.  In addition, the Kubernetes Ops Center deploys two operators: one that manages multiple databases, and another that provides command-line API access for running common commands against a K8s cluster. In Kubernetes Ops Center, the creation, pausing, and resuming of the Splice Machine database are done through a user interface. Additionally, REST APIs exist internally to the Kubernetes cluster for some services such as pausing and resuming databases.

Depending upon the deployment option selected, you will have access to certain capabilities to manage your OpsCenter environment and databases deployed within K8s:

<table>
                <col />
                <col />
                <col />
                <col />
                <col />
                <thead>
                    <tr>
                        <th></th>
                        <th>Kubernetes Ops Center Managed Service</th>
                        <th>Kubernetes Ops Center</th>
                        <th>Helm Chart/Rancher Catalog (Enterprise)
</th>
                        <th>Helm Chart/Rancher Catalog (Community)</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <th>Splice K8s scripts</th>
                        <td align="center">X</td>
                        <td align="center">X</td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <th>SpliceDB Operators</th>
                        <td align="center">X</td>
                        <td align="center">X</td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <th>Helm Charts with ML Manager</th>
                        <td align="center">X</td>
                        <td align="center">X</td>
                        <td align="center">X</td>
                        <td align="center">X</td>
                    </tr>
                    <tr>
                        <th>Splice Database Enterprise Edition</th>
                        <td align="center">X</td>
                        <td align="center">X</td>
                        <td align="center">X</td>
                        <td></td>
                    </tr>
                    <tr>
                        <th>Management Tools (Elastic Stack, Prometheus, Grafana, etc.)</th>
                        <td align="center">X</td>
                        <td align="center">X</td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <th>Management UI</th>
                        <td align="center">X</td>
                        <td align="center">X</td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <th>MRunbooks, Best Practices</th>
                        <td align="center">X</td>
                        <td align="center">X</td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <th>Pagerduty, Slack Integration</th>
                        <td align="center">X</td>
                        <td align="center">X</td>
                        <td></td>
                        <td></td>
                    </tr>
                </tbody>
            </table>

### Database Management

All Kubernetes Ops Center and Helm Chart/Rancher Enterprise deployment options provide the Splice Machine database enterprise features. Note that the Community edition of the database does not support some features such as backup/restore and LDAP integration.

<table>
                <col />
                <col />
                <col />
                <col />
                <col />
                <thead>
                    <tr>
                        <th></th>
                        <th>Kubernetes Ops Center Managed Service</th>
                        <th>Kubernetes Ops Center</th>
                        <th>Helm Chart/Rancher Catalog (Enterprise)</th>
                        <th>Helm Chart/Rancher Catalog (Community)</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <th>Create/Drop Database</th>
                        <td align="center">X</td>
                        <td align="center">X</td>
                        <td align="center">X</td>
                        <td align="center">X</td>
                    </tr>
                    <tr>
                        <th>Pause/Resume Database</th>
                        <td align="center">X</td>
                        <td align="center">X</td>
                        <td align="center">X</td>
                        <td align="center">X</td>
                    </tr>
                    <tr>
                        <th>Resize/Reconfigure Database</th>
                        <td align="center">X</td>
                        <td align="center">X</td>
                        <td align="center">X</td>
                        <td align="center">X</td>
                    </tr>
                    <tr>
                        <th>LDAP Integration for DB User Login</th>
                        <td align="center">X</td>
                        <td align="center">X</td>
                        <td align="center">X</td>
                        <td></td>
                    </tr>
                    <tr>
                        <th>Scheduled Backups</th>
                        <td align="center">X</td>
                        <td align="center">X</td>
                        <td align="center">X</td>
                        <td></td>
                    </tr>
                    <tr>
                        <th>Backups on Demand</th>
                        <td align="center">X</td>
                        <td align="center">X</td>
                        <td align="center">X</td>
                        <td></td>
                    </tr>

                </tbody>
            </table>



### Basic Database Features

All deployment options include the following basic database features.  

<table>
                <col />
                <col />
                <col />
                <col />
                <col />
                <thead>
                    <tr>
                        <th></th>
                        <th>Kubernetes Ops Center Managed Service</th>
                        <th>Kubernetes Ops Center</th>
                        <th>Helm Chart/Rancher Catalog (Enterprise)
</th>
                        <th>Helm Chart/Rancher Catalog (Community)</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <th>Connect to DB</th>
                        <td align="center">X</td>
                        <td align="center">X</td>
                        <td align="center">X</td>
                        <td align="center">X</td>
                    </tr>
                    <tr>
                        <th>Run SQL</th>
                        <td align="center">X</td>
                        <td align="center">X</td>
                        <td align="center">X</td>
                        <td align="center">X</td>
                    </tr>
                    <tr>
                        <th>Import/Export Data</th>
                        <td align="center">X</td>
                        <td align="center">X</td>
                        <td align="center">X</td>
                        <td align="center">X</td>
                    </tr>
                    <tr>
                        <th>Jupyter Notebooks</th>
                        <td align="center">X</td>
                        <td align="center">X</td>
                        <td align="center">X</td>
                        <td align="center">X</td>
                    </tr>
                    <tr>
                        <th>ML Manager</th>
                        <td align="center">X</td>
                        <td align="center">X</td>
                        <td align="center">X</td>
                        <td align="center">X</td>
                    </tr>
                    <tr>
                        <th>User Management Privileges</th>
                        <td align="center">X</td>
                        <td align="center">X</td>
                        <td align="center">X</td>
                        <td align="center">X</td>
                    </tr>

                </tbody>
            </table>

### Monitoring

The Kubernetes Ops Center includes components of Elastic Stack for consolidating logs from pods, containers, and nodes. These logs are parsed, tagged, and augmented for easy search and analytic capabilities. Server metrics are captured and available for display on dashboards, as well as for automated alerting. Finally, the Kubernetes Ops Center provides two user interfaces – one user interface allows end users to have a more self-service process when it comes to managing their databases.   The other user interface provides an administrator’s view of all the databases created in the Kubernetes environment.   

<table>
                <col />
                <col />
                <col />
                <col />
                <col />
                <thead>
                    <tr>
                        <th></th>
                        <th>Kubernetes Ops Center Managed Service</th>
                        <th>Kubernetes Ops Center</th>
                        <th>Helm Chart/Rancher Catalog (Enterprise)
</th>
                        <th>Helm Chart/Rancher Catalog (Community)</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <th>Connect to DB</th>
                        <td align="center">X</td>
                        <td align="center">X</td>
                        <td align="center">X</td>
                        <td align="center">X</td>
                    </tr>
                    <tr>
                        <th>Run SQL</th>
                        <td align="center">X</td>
                        <td align="center">X</td>
                        <td align="center">X</td>
                        <td align="center">X</td>
                    </tr>
                    <tr>
                        <th>Import/Export Data</th>
                        <td align="center">X</td>
                        <td align="center">X</td>
                        <td align="center">X</td>
                        <td align="center">X</td>
                    </tr>
                    <tr>
                        <th>Jupyter Notebooks</th>
                        <td align="center">X</td>
                        <td align="center">X</td>
                        <td align="center">X</td>
                        <td align="center">X</td>
                    </tr>
                    <tr>
                        <th>ML Manager</th>
                        <td align="center">X</td>
                        <td align="center">X</td>
                        <td align="center">X</td>
                        <td align="center">X</td>
                    </tr>
                    <tr>
                        <th>User Management Privileges</th>
                        <td align="center">X</td>
                        <td align="center">X</td>
                        <td align="center">X</td>
                        <td align="center">X</td>
                    </tr>

                </tbody>
            </table>




</div>
</section>
