---
title: Uploading data to an AWS S3 bucket for import into Splice Machine
summary: Walks you creating an AWS S3 bucket and uploading your data to that bucket.
keywords: upload data, aws, s3, bucket, import
toc: false
product: all
sidebar: tutorials_sidebar
permalink: tutorials_ingest_uploadtos3.html
folder: Tutorials/Ingest
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Uploading Your Data to an S3 Bucket

You can easily load data into your Splice Machine database from an
Amazon Web Services (AWS) S3 bucket. This tutorial walks you through
creating an S3 bucket (if you need to) and uploading your data to that
bucket for subsequent use with Splice Machine.

For more information about S3 buckets, see the [AWS documentation][1]{:
target="_blank"}.
{: .noteNote}

After completing the configuration steps described here, you'll be able
to load data into Splice Machine from an S3 bucket.

## Create and Upload Data to an AWS S3 Bucket

Follow these steps to first create a new bucket (if necessary) and
upload data to a folder in an AWS S3 bucket:

<div class="opsStepsList" markdown="1">
1.  Log in to the AWS Database Console
    {: .topLevel}
    
    Your permissions must allow for you to create an S3 bucket.
    {: .indentLevel1}

2.  Select <span class="ConsoleLink">Services</span> at the top of the
    dashboard
    {: .topLevel}
    
    ![](images/AWSServices.png){: .nestedTightSpacing}

3.  Select <span class="ConsoleLink">S3</span> in the <span
    class="ConsoleLink">Storage</span> section:
    {: .topLevel}
    
    ![](images/AWSSelectS3.png "Select the S3 service option"){:
    .nestedTightSpacing}
    {: .indentLevel1}

4.  Create a new bucket
    {: .topLevel}
    
    1.  Select <span class="ConsoleLink">Create Bucket</span>from the
        S3screen
        
        ![](images/AWSCreateBucket1.png "Select the Create Bucket
        button"){: .nestedTightSpacing}
    
    2.  Provide a name and select a region for your bucket
        
        The name you select must be unique; AWS will notify you if you
        attempt to use an already-used name. For optimal performance,
        choose a region that is close to the physical location of your
        data; for example:
        
        ![](images/AWSCreateBucket2.png "Selecting a name and region for
        an S3 bucket"){: .nestedTightSpacing}
    
    3.  Click the <span class="ConsoleLink">Next</span> button to
        advance to the property settings for your new bucket:
        
        ![](images/AWSBucketProps1.png "Setting properties for a new
        bucket"){: .nestedTightSpacing}
        
        You can click one of the <span class="ConsoleLink">Learn
        more</span> buttons to view or modify details.
    
    4.  Click the <span class="ConsoleLink">Next</span> button to
        advance to view or modify permissions settings for your new
        bucket:
        
        ![](images/AWSBucketPerms1.png "Setting permissions for a new S3
        bucket"){: .nestedTightSpacing}
    
    5.  Click <span class="ConsoleLink">Next</span> to review your
        settings for the new bucket, and then click the <span
        class="ConsoleLink">Create bucket</span> button to create your
        new S3 bucket. You'll then land on your S3 Management screen.
    {: .LowerAlphaPlainFont}

5.  Upload data to your bucket
    {: .topLevel}
    
    After you create the bucket:
    {: .indentLevel1}
    
    1.  Select <span class="ConsoleLink">Create folder</span>, enter a
        name for the new folder, and click the <span
        class="ConsoleLink">Save</span> button.
        
        ![](images/AWSCreateFolder.png "Create a folder in an AWS S3
        bucket"){: .nestedTightSpacing}
    
    2.  Click the <span class="ConsoleLink">Upload</span> button to
        select file(s) to upload to your new bucket folder. You can then
        drag files into the upload screen, or click <span
        class="ConsoleLink">Add Files</span> and navigate to the files
        you want to upload to your folder.
        
        ![](images/AWSUploadFiles.png "Selecting files to upload to an
        S3 bucket folder"){: .nestedTightSpacing}
    
    3.  You can then optionally set permissions and properties for the
        files you are uploading. Once you're done, click the Upload
        button, and AWS will copy the files into the folder in your S3
        bucket.
    {: .LowerAlphaPlainFont}

6.  Make sure Splice Machine can access your bucket:
    {: .topLevel}
    
    Review the IAM configuration options in our [Configuring an S3
    Bucket for Splice Machine Access](tutorials_ingest_configures3.html)
    tutorial to allow Splice Machine to import your data.
    {: .indentLevel1}
{: .boldFont}

</div>
</div>
</section>



[1]: http://docs.aws.amazon.com/AmazonS3/latest/dev/UsingBucket.html
