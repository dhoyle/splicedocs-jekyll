---
title: Getting Ready for Splice Machine on Your AWS Account
summary: What You Need to Run Splice Machine on Your AWS Account
keywords: AWS, dbaas
toc: false
product: all
sidebar: getstarted_sidebar
permalink: dbaas_dedicatedhdfs.html
folder: /DBaaS
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Running Splice Machine with Your AWS Account

Splice Machine needs your AWS Administrator to provide us with certain details so that we can configure our software to run on your AWS account. Specifically, we need you to:

* [Configure a User with Proper Permissions](#user)
* [Provide a Key Pair](#keypair)
* [Provide Amazon Resource Name for SSL Certificate](#sslarn)
* [Provide AWS Account Id](#awsacct)
* [Provide Infrastructure Environment Details](#infradetails)
* [Provide Application Environment Details](#appdetails)


## Configure a User with Proper Permissions {#user}
You will need a user that has programmatic access to AWS, configured with the following policy:

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "autoscaling:*",
                "ec2:*",
                "elasticloadbalancing:*",
                "es:*",
                "iam:AddRoleToInstanceProfile",
                "iam:AttachRolePolicy",
                "iam:CreateInstanceProfile",
                "iam:CreatePolicy",
                "iam:CreateRole",
                "iam:CreateServiceLinkedRole",
                "iam:DeleteRole",
                "iam:DetachRolePolicy",
                "iam:GetInstanceProfile",
                "iam:GetPolicy",
                "iam:GetPolicyVersion",
                "iam:GetRole",
                "iam:GetUserPolicy",
                "iam:ListAttachedRolePolicies",
                "iam:ListInstanceProfilesForRole",
                "iam:ListPolicyVersions",
                "iam:ListPolicyVersions",
                "iam:PassRole",
                "rds:*",
                "route53:*",
                "s3:*",
                "tag:*"
            ],
            "Resource": "*"
        }
    ]
}
```

## Provide a Key Pair {#keypair}
You need to provide Splice Machine with a key pair (`.pem` file) for setting up the environment; if you don't already have a key pair, you can follow these steps to create one:

1. Log into the AWS Console
2. Navigate to  *EC2*
3. Select <span class="ConsoleLink">Key Pair</span> in the left-side navigation
4. Select <span class="ConsoleLink">Create Key Pair</span>
5. Enter a name for the <span class="ConsoleLink">Key Pair</span>
6. Click <span class="ConsoleLine">Create</sp> to create and download the `.pem` file
7. Open a terminal window on your computer.
8. Change the permissions of the `.pem` file as follows:
   <div class="preWrapper"><pre class="ShellCommand">
   chmod 600 <span class="HighlightedCode">path/to/file/FILENAME</span>.pem</pre>
   </div>
9. Move the `.pem` file to the command location with this command:
   <div class="preWrapper"><pre class="ShellCommand">
   cp <span class="HighlightedCode">path/to/file/FILENAME</span>.pem ~/.ssh/</pre>
   </div>
10. Finally, add the `.pem` file to `ssh-add` with this command:
    <div class="preWrapper"><pre class="ShellCommand">
    ssh-add ~/.ssh/<span class="HighlightedCode">FILENAME</span>.pem</pre>
    </div>

## Provide Amazon Resource Name for SSL Certificate {#sslarn}
Splice Machine needs the Amazon Resource Name (*ARN*) for the SSL Certificate for your domain; this must be a wildcard certificate. You can follow these steps to create the certificate:

1. Log into the AWS Console.
2. Navigate to the *AWS Certificate Manager*.
3. Select <span class="ConsoleLink">Provision certificates</span>.
4. Select the radio button <span class="ConsoleLink">Request a public certificate</span>.
5. Click <span class="ConsoleLink">Request a Certificate</span>.
6. In the *Domain name* section, enter your domain as a wildcard by prefacing it with `'.'`. For example:
   <div class="preWrapper"><pre class="Plain">
   *.splicemachine-test.io*</pre>
   </div>
7. Click the <span class="ConsoleLink">Next</span> button.
8. Follow the instructions for validating the certificate through either DNS or Email.

## Provide AWS Account Id {#awsacct}
Please provide Splice Machine with your Amazon Account ID, which we need to share our AMIs.

## Provide Infrastructure Environment Details  {#infradetails}
To correctly set up the infrastructure environment, you'll need to provide Splice Machine with values for the properties in the following table.

<p class="noteIcon">You can print this page and use the <span class="spliceCheckbox">&#10080;</span> checkboxes in the next two tables to track whether you're ready with each required value.</p>

<table>
    <col width="5%" />
    <col width="15%" />
    <col width="40%" />
    <col width="30%" />
    <col width="10%" />
    <thead>
        <tr>
            <th>#</th>
            <th>Name</th>
            <th>Description</th>
            <th>Terraform Variable</th>
            <th>&nbsp;</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>1</td>
            <td class="BoldFont">AWS Region</td>
            <td><p>Provide one of the following values:</p>
                <ul>
                    <li class="CodeFont">us-east-1</li>
                    <li class="CodeFont">us-east-2</li>
                    <li class="CodeFont">us-west-1</li>
                    <li class="CodeFont">us-west-2</li>
                </ul>
                <p> The default value is <code>us-east-1</code>.</p>
            </td>
            <td class="CodeFont">aws_region</td>
            <td class="spliceCheckbox">&#10080;</td>

        </tr>
        <tr>
            <td>2</td>
            <td class="BoldFont">AWS SSL Certificates</td>
            <td>The load balancers use SSL certificates; please provide the Amazon Resource Name (<em>ARN</em>) for your certificate, which you can find in the <em>AWS Certificate Manager</em> section.</td>
            <td class="CodeFont">aws_ssl_certificate_splice</td>
            <td class="spliceCheckbox">&#10080;</td>

        </tr>
        <tr>
            <td>3</td>
            <td class="BoldFont">CIDR Block</td>
            <td>Specify a range of IPv4 addresses for the VPC, in the form of a Classless Inter-Domain Routing (CIDR) block; for example, <code>10.0.0.0/16</code>.</td>
            <td class="CodeFont">region_cidr_blocks</td>
            <td class="spliceCheckbox">&#10080;</td>

        </tr>
        <tr>
            <td>4</td>
            <td class="BoldFont">Key Name</td>
            <td>The key pair name used to ssh to the machines. This key can be found in the AWS <em>EC2 -> Network & Security -> Key Pairs</em> section.</td>
            <td class="CodeFont">key_name</td>
            <td class="spliceCheckbox">&#10080;</td>

        </tr>
        <tr>
            <td>5</td>
            <td class="BoldFont">Instance Types</td>
            <td><p>The type of ec2 instances to use for each server type. The default values are:</p>
                <table>
                    <tbody>
                        <tr><td class="CodeFont">HDD</td><td class="CodeFont">d2.xlarge</td></tr>
                        <tr><td class="CodeFont">MASTER</td><td class="CodeFont">m4.4xlarge</td></tr>
                        <tr><td class="CodeFont">PRIVATE_AGENT</td><td class="CodeFont">m4.4xlarge</td></tr>
                        <tr><td class="CodeFont">PUBLIC_AGENT</td><td class="CodeFont">m4.xlarge</td></tr>
                        <tr><td class="CodeFont">SPARK</td><td class="CodeFont">i3.4xlarge</td></tr>
                    </tbody>
                </table>
                <p></p>
            </td>
            <td class="CodeFont">instance_type</td>
            <td class="spliceCheckbox">&#10080;</td>

        </tr>
        <tr>
            <td>6</td>
            <td class="BoldFont">Instance Root Size</td>
            <td>The root size for the instance type. This defaults to <code>300</code> for all instance types.</td>
            <td class="CodeFont">instance_root_type</td>
            <td class="spliceCheckbox">&#10080;</td>

        </tr>
        <tr>
            <td>7</td>
            <td class="BoldFont">Instance Counts</td>
            <td><p>The defined quantity of each instance type that you cluster should have. Here are the default values:</p>
                <table>
                    <tbody>
                        <tr><td class="CodeFont">HDD</td><td class="CodeFont">4</td></tr>
                        <tr><td class="CodeFont">MASTER</td><td class="CodeFont">3</td></tr>
                        <tr><td class="CodeFont">PRIVATE_AGENT</td><td class="CodeFont">6</td></tr>
                        <tr><td class="CodeFont">PUBLIC_AGENT</td><td class="CodeFont">3</td></tr>
                        <tr><td class="CodeFont">SPARK</td><td class="CodeFont">4</td></tr>
                    </tbody>
                </table>
            </td>
            <td class="CodeFont">instance_counts_splice</td>
            <td class="spliceCheckbox">&#10080;</td>

        </tr>
        <tr>
            <td>8</td>
            <td class="BoldFont">Metadata Database Name</td>
            <td>The name of the postgres database that will store the metadata for the <em>Splice Machine Cloud Manager.</em></td>
            <td class="CodeFont">database_name</td>
            <td class="spliceCheckbox">&#10080;</td>

        </tr>
        <tr>
            <td>9</td>
            <td class="BoldFont">Metadata Database UserName</td>
            <td>The username of the postgres database that will store the metadata for the <em>Splice Machine Cloud Manager.</em></td>
            <td class="CodeFont">database_username</td>
            <td class="spliceCheckbox">&#10080;</td>

        </tr>
        <tr>
            <td>10</td>
            <td class="BoldFont">Metadata Database Password</td>
            <td>The password for the postgres database.</td>
            <td class="CodeFont">database_password</td>
            <td class="spliceCheckbox">&#10080;</td>

        </tr>
        <tr>
            <td>11</td>
            <td class="BoldFont">Elasticsearch Domain</td>
            <td>The domain for the elasticsearch instance</td>
            <td class="CodeFont">elasticsearch -> domain</td>
            <td class="spliceCheckbox">&#10080;</td>
        </tr>
        <tr>
            <td>12</td>
            <td class="BoldFont">Elasticsearch Instance Type</td>
            <td>The default instance type is: <code>m4.large.elasticsearch</code>.</td>
            <td class="CodeFont">elasticsearch -> instance_type</td>
            <td class="spliceCheckbox">&#10080;</td>
        </tr>
        <tr>
            <td>13</td>
            <td class="BoldFont">Elasticsearch Instance Count</td>
            <td>The number of instances to use for your cluster. The default is <code>4</code>.</td>
            <td class="CodeFont">elasticsearch -> instance_count</td>
            <td class="spliceCheckbox">&#10080;</td>
        </tr>
        <tr>
            <td>14</td>
            <td class="BoldFont">Elasticsearch EBS Volume Size</td>
            <td>The size of the EBS volume. The default value is <code>300</code>.</td>
            <td class="CodeFont">elasticsearch -> ebs_volume_size</td>
            <td class="spliceCheckbox">&#10080;</td>
        </tr>
        <tr>
            <td>15</td>
            <td class="BoldFont">Spark Temp Space disk size</td>
            <td>The size of the Spark temporary space, which defaults to <code>1000 GB</code>.</td>
            <td class="CodeFont">spark_tmp_disk_size</td>
            <td class="spliceCheckbox">&#10080;</td>
        </tr>
        <tr>
            <td>16</td>
            <td class="BoldFont">VPC CIDR Block</td>
            <td>The <code>cidr_block</code> to use when creating the IP addresses for the instances.</td>
            <td class="CodeFont">vpc-splice -> cidr_block</td>
            <td class="spliceCheckbox">&#10080;</td>
        </tr>
        <tr>
            <td>17</td>
            <td class="BoldFont">Cluster Tags</td>
            <td>Please provide values for these <code>tags-splice-></code> tags, which are used to identify the cluster resources.</td>
            <td class="CodeFont">tags-splice->cluster_name<br />
                                 tags-splice->department_name<br />
                                 tags-splice->resource_owner<br />
                                 tags-splice->resource_purpose
            </td>
            <td class="spliceCheckbox">&#10080;</td>
        </tr>
        <tr>
            <td>18</td>
            <td class="BoldFont">Whitelist IP Addresses</td>
            <td>List the IP Addresses to add; access to dcos admin components will be limited to these.</td>
            <td class="CodeFont">whitelist_ips</td>
            <td class="spliceCheckbox">&#10080;</td>
        </tr>
        <tr>
            <td>19</td>
            <td class="BoldFont">Zone</td>
            <td>Enter the domain name for the database instance URLs.</td>
            <td class="CodeFont">zone_name</td>
            <td class="spliceCheckbox">&#10080;</td>
        </tr>
        <tr>
            <td>20</td>
            <td class="BoldFont">Environment</td>
            <td>Enter a suffix that will be added to URLs for the environment; for example <code>dev</code>, <code>qa</code>, or <code>empty</code>. The default value is <code>empty</code>.</td>
            <td class="CodeFont">environment</td>
            <td class="spliceCheckbox">&#10080;</td>
        </tr>
    </tbody>
</table>

## Provide Application Environment Details  {#appdetails}
In order to set up the application environment you will need to provide the values shown in the following table.

<table>
    <col width="5%" />
    <col width="50% "/>
    <col width="35% "/>
    <col width="10% "/>
    <thead>
        <tr>
            <th>#</th>
            <th>Name / Description</th>
            <th>Terraform Variable</th>
            <th>&nbsp;</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>1</td>
            <td class="BoldFont">Auth0 certificate</td>
            <td class="CodeFont">auth0_cert</td>
            <td class="spliceCheckbox">&#10080;</td>

        </tr>
        <tr>
            <td>2</td>
            <td class="BoldFont">Auth0 client ID</td>
            <td class="CodeFont">auth0_client_id</td>
            <td class="spliceCheckbox">&#10080;</td>

        </tr>
        <tr>
            <td>3</td>
            <td class="BoldFont">Auth0 domain</td>
            <td class="CodeFont">auth0_domain</td>
            <td class="spliceCheckbox">&#10080;</td>

        </tr>
        <tr>
            <td>4</td>
            <td class="BoldFont">Cluster Creation BCC Email Address</td>
            <td class="CodeFont">email_bcc</td>
            <td class="spliceCheckbox">&#10080;</td>

        </tr>
        <tr>
            <td>5</td>
            <td class="BoldFont">Google Analytics Tracking ID  (optional)</td>
            <td class="CodeFont">google_analytics_tracking_id</td>
            <td class="spliceCheckbox">&#10080;</td>

        </tr>
        <tr>
            <td>6</td>
            <td class="BoldFont">Email SMTP Properties</td>
            <td class="CodeFont">smtp->->host<br />
                                 smtp->->password<br />
                                 smtp->->port<br />
                                 smtp->->user
            </td>
            <td class="spliceCheckbox">&#10080;</td>

        </tr>
    </tbody>
</table>

</div>
</section>
