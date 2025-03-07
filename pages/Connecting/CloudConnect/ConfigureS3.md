---
title: Configuring an S3 Bucket to Use with Splice Machine
summary: Walks you configuring an AWS S3 bucket for use with Splice Machine.
keywords: S3, configuring, IAM, bucket,
toc: false
product: all
sidebar: home_sidebar
permalink: developers_cloudconnect_configures3.html
folder: Connecting/CloudConnect
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Configuring an S3 Bucket for Splice Machine Access

Splice Machine can access S3 buckets, making it easy for you to store
and manage your data on AWS. To do so, you need to configure your
AWS controls to allow that access. This topic walks you through the
required steps.

You must have administrative access to AWS to configure your S3 buckets
for Splice Machine.
{: .noteNote}

You can also enable anonymous S3 read access on Cloudera, which is convenient for when you want a file to be publicly accessible.

Use the following steps to configure access to your S3 buckets for Splice Machine:

* [Configuring Secure S3 Bucket Access](#configure)
* [Configuring Anonymous S3 Read Access on Cloudera](#configanon)
* [Accessing S3 Buckets](#accessing)

## Configuring Secure S3 Bucket Access  {#configure}

Use the following steps to:

* Create an IAM policy for an S3 bucket.
* Create an IAM user.
* Generate an access credential for that user.
* Attach the security policy to that user.

<div class="opsStepsList" markdown="1">
1.  Log in to the AWS Database Console
    {: .topLevel}

    You must have administrative access to configure S3 bucket access.
    {: .indentLevel1}

2.  Select <span class="ConsoleLink">Services</span> at the top of the
    dashboard
    {: .topLevel}

    ![](images/AWSServices.png){: .nestedTightSpacing}

3.  Access the IAM (Identify and Access Management) service:
    {: .topLevel}

    Select <span class="ConsoleLink">IAM</span> in the <span
    class="ConsoleLink">Security, Identity &amp; Compliance</span>
    section:
    {: .indentLevel1}

    ![](images/S3SelectIAM_820x1005.png){: .nestedTightSpacing
    style="width: 820;height: 1005;"}
    {: .indentLevel1}

4.  Create a new policy:
    {: .topLevel}

    1.  Select <span class="ConsoleLink">Policies</span> from the
        IAM screen, then select <span class="ConsoleLink">Create
        Policy:</span>

        ![](images/AWSIAMPolicies.png){: .nestedTightSpacing}

    2.  Select <span class="ConsoleLink">Create Your Own Policy</span>
        to enter your own policy:

        ![](images/AWSIAMCreatePolicy.png){: .nestedTightSpacing}

    3.  In the <span class="ConsoleLink">Review Policy</span> section,
        which should be pre-selected, specify a name for this policy (we
        call it <span class="CodeItalicFont">splice_access</span>):

        ![](images/AWSIAMNamePolicy.png){: .nestedTightSpacing}

    4.  Paste the following JSON object specification into the <span
        class="ConsoleLink">Policy Document</span> field and then modify
        the highlighted values to specify your bucket name and folder
        path.

        <div class="preWrapperWide" markdown="1">
            {
                "Version": "2012-10-17",
                "Statement": [
                    {
                        "Effect": "Allow",
                        "Action": [
                          "s3:PutObject",
                          "s3:GetObject",
                          "s3:GetObjectVersion",
                          "s3:DeleteObject",
                          "s3:DeleteObjectVersion"
                        ],
                        "Resource": "arn:aws:s3:::<bucket_name>/<prefix>/*"
                    },
                    {
                        "Effect": "Allow",
                        "Action": "s3:ListBucket",
                        "Resource": "arn:aws:s3:::<bucket_name>",
                        "Condition": {
                            "StringLike": {
                                "s3:prefix": [
                                    "<prefix>/*"
                                ]
                            }
                        }
                    },
                    {
                        "Effect": "Allow",
                        "Action": "s3:GetAccelerateConfiguration",
                        "Resource": "arn:aws:s3:::<bucket_name>"
                    }
                ]
            }
        {: .Plain}

        </div>

    5.  Click <span class="ConsoleLink">Validate Policy</span> to verify
        that your policy settings are valid.

        ![](images/AWSIAMDoCreate.png){: .nestedTightSpacing}

    6.  Click <span class="ConsoleLink">Create Policy</span> to create
        and save the policy.
    {: .LowerAlphaPlainFont}

5.  Add Splice Machine as a user:
    {: .topLevel}

    After you create the policy:
    {: .indentLevel1}

    1.  Select <span class="ConsoleLink">Users</span> from the left-hand
        navigation pane.

    2.  Click <span class="ConsoleLink">Add User</span>.

    3.  Enter a <span class="ConsoleLink">User name</span> (we've used
        *SpliceMachine*) and select <span
        class="ConsoleLink">Programmatic access</span> as the access
        type:

        ![](images/AWSIAMAddUser1.png){: .nestedTightSpacing}

    4.  Click <span class="ConsoleLink">Attach existing policies
        directly</span>.

    5.  Select the policy you just created and click <span
        class="ConsoleLink">Next</span>:

        ![](images/AWSIAMAddUser3.png){: .nestedTightSpacing}

    6.  Review your settings, then click <span
        class="ConsoleLink">Create User</span>.
    {: .LowerAlphaPlainFont}

6.  Save your access credentials
    {: .topLevel}

    You **must** save your Access key ID and secret access key;
    you will be unable to recover the secret access key.
    {: .indentLevel1}

    ![](images/AWSIAMAddUser4.png){: .nestedTightSpacing}
    {: .indentLevel1}

    <span class="important">Splice Machine strongly recommends</span>
    that you click the <span class="ConsoleLink">Download .csv</span>
    button and save your credentials in a file for future reference.
    Once you close this screen, you'll be unable to display your secret
    access key.
    {: .notePlain}
{: .boldFont}
</div>

## Configuring Anonymous S3 Read Access on Cloudera  {#configanon}

If you're using the Cloudera platform, you can configure anonymous `read` access to S3 by modifying your `core-site.xml` file. This allows you to read and write public S3 files in Splice Machine. Follow these steps:

<div class="opsStepsList" markdown="1">
1.  Navigate to <span class="ConsoleLink">cluster->hdfs->configuration</span>.
    {: .topLevel}

2.  Add the following property to the <span class="ConsoleLink">Cluster-wide Advanced Configuration Snippet (Safety Valve) for core-site.xml</span>:
    {: .topLevel}

    *Name:*
    : `fs.s3a.aws.credentials.provider`
    {: .noSpaceAbove}

    *Value:*
    : `org.apache.hadoop.fs.s3a.SimpleAWSCredentialsProvider,com.amazonaws.auth.EnvironmentVariableCredentialsProvider,org.apache.hadoop.fs.s3a.AnonymousAWSCredentialsProvider`

    *Description:*
    : `Allow anonymous S3 read`
</div>

<div class="noteNote" markdown="1">
After adding this property, you can also access the public S3 buckets using this HDFS command:

```
hadoop fs -ls s3a://bucket/path/to/file.csv
```
{: .ShellCommand}
</div>

## Accessing S3 Buckets {#accessing}

After you have created S3 access keys, you can specify the S3 keys in the `core-site.xml` file
on your cluster, and then specify the `s3a` URL, just as you can when accessing a public S3 bucket. For example:

<div class="preWrapperWide" markdown="1">
    call SYSCS_UTIL.IMPORT_DATA ('TPCH', 'REGION', null, 's3a://splice-benchmark-data/flat/TPCH/100/region', '|', null, null, null, null, 0, '/BAD', true, null);
{: .Example}

</div>
To add your access and secret access keys to the `core-site.xml` file,
define the `fs.s3a.access.key` and `fs.s3a.secret.key`
properties in that file:

<div class="preWrapperWide" markdown="1">
    <property>
       <name>fs.s3a.access.key</name>
       <value>access key</value>
    </property>
    <property>
       <name>fs.s3a.secret.key</name>
       <value>secret key</value>
    </property>
{: .Example}

</div>

</div>
</section>
