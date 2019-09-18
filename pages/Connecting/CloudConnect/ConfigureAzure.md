---
title: "Using Azure WASB, ADLS, and ADLS2 with Splice Machine"
summary: Walks you configuring Azure storage for use with Splice Machine.
keywords: WASB, ADLS, ADLS2, configuring, storage
toc: false
product: all
sidebar: home_sidebar
permalink: developers_cloudconnect_configureazure.html
folder: Connecting/CloudConnect
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Using Azure WASB, ADLS, and ADLS2 with Splice Machine

This topic walks you through the steps required to configure Azure Blob (WASB), Azure Data Lake Storage (ADLS), and Azure Data Lake Storage Gen 2 (ADLS2) with Splice Machine.

This topic contains these sections:

* [Configuring WASB and ADLS Storage Access](#wasb)
* [Configuring ADLS2 Storage Access](#adls2)

## Configuring WASB and ADLS Storage Access  {#wasb}

This section shows you how to configure WASB and ADLS storage for Splice Machine Access, in these subsections:

* [Configuring and Uploading Your Data](#configadls)
* [Copying Data Between WASB and ADLS](#copyadls)
* [Importing Your Data from Azure WASB or ADLS Storage](#importadls)

### Configuring and Uploading Your Data  {#configadls}

<div class="opsStepsList" markdown="1">
1.  Log in to the Azure portal.
    {: .topLevel}

    If needed, first create an Azure account. Then log in to the portal at <a href="https://portal.azure.com" target="_blank">https://portal.azure.com</a>.

2.  Create a resource group:
    {: .topLevel}

    Follow the instructions on this page to create a resource group: <a href="https://docs.microsoft.com/en-us/azure/azure-resource-manager/manage-resource-groups-portal" target="_blank">https://docs.microsoft.com/en-us/azure/azure-resource-manager/manage-resource-groups-portal</a>.

    For example, create the `myResourceGroup` resource group.

3.  Create a Data Lake Storage Gen1 account:
    {: .topLevel}

    Follow the instructions on this page: <a href="https://docs.microsoft.com/en-us/azure/data-lake-store/data-lake-store-get-started-portal" target="_blank">https://docs.microsoft.com/en-us/azure/data-lake-store/data-lake-store-get-started-portal</a>.

    For example:

    ```
    name: myDataLake
    resource group: myResourceGroup
    ```
    {: .Example}

4.  Upload your data file:
    {: .topLevel}

    In the Azure *Data Explorer*, create a new folder, and then upload your file (for example, `myData`) to that folder.

5.  Create credentials:
    {: .topLevel}

    Create Credentials, as described in this page: <a href="https://docs.microsoft.com/en-us/azure/data-lake-store/data-lake-store-service-to-service-authenticate-using-active-directory#create-an-active-directory-application" target="_blank">https://docs.microsoft.com/en-us/azure/data-lake-store/data-lake-store-service-to-service-authenticate-using-active-directory#create-an-active-directory-application</a>.

    ```
    Register an AD application: myApp
    Assign the application to a role: Owner
    Copy IDs:
        Tenant ID: <tenantID>
        Client ID: <clientID>
    Create a new application secret
        myApp secret: <clientSecret>
    ```
    {: .Example}

6.  Assign the Azure AD application to the Azure Data Lake Storage Gen1 account file.
    {: .topLevel }

7.  Get the OAuth 2.0 token endpoint:
    {: .topLevel }

    For example: `https://login.microsoftonline.com/<tenantID>/oauth2/token`

8.  Access ADLS from your cluster:
    {: .topLevel}

    To access your ADLS storage from Cloudera, follow the instructions in this page: <a href="https://www.cloudera.com/documentation/enterprise/5-12-x/topics/admin_adls_config.html" target="_blank">https://www.cloudera.com/documentation/enterprise/5-12-x/topics/admin_adls_config.html</a>. For example:

    ```
    hadoop fs -Ddfs.adls.oauth2.access.token.provider.type=ClientCredential \
       -Ddfs.adls.oauth2.client.id=<clientID> \
       -Ddfs.adls.oauth2.credential="<clientSecret>" \
       -Ddfs.adls.oauth2.refresh.url=https://login.microsoftonline.com/<tenantID>/oauth2/token \
       -ls adl://<datalakeName>.azuredatalakestore.net/<containerName>
    ```
    {: .Example}

9.  Create a WASB storage account:
    {: .topLevel}

    Follow the instructions on this page: <a href="https://docs.microsoft.com/en-us/azure/storage/common/storage-quickstart-create-account" target="_blank">https://docs.microsoft.com/en-us/azure/storage/common/storage-quickstart-create-account</a>.

    ```
    Resource group: <resourceGroup>
    Storage account name: <storageAccount>
    Get access key: <accessKey>
    Create container: <containerName>
    ```
    {: .Example}
</div>


### Copying Data Between WASB and ADLS  {#copyadls}

To copy data, follow the instructions in this page: <a href="https://docs.microsoft.com/en-us/azure/data-lake-store/data-lake-store-copy-data-wasb-distcp" target="_blank">https://docs.microsoft.com/en-us/azure/data-lake-store/data-lake-store-copy-data-wasb-distcp</a>. For example:

```
hadoop fs -Ddfs.adls.oauth2.access.token.provider.type=ClientCredential \
   -Ddfs.adls.oauth2.client.id=<clientID> \
   -Ddfs.adls.oauth2.credential="<clientSecret>" \
   -Ddfs.adls.oauth2.refresh.url=https://login.microsoftonline.com/<tenantID>/oauth2/token \
   -Dfs.azure.account.key.<storageAccount>.blob.core.windows.net="<accessKey>" \
   -cp adl://<datalakeName>.azuredatalakestore.net/<containerName>/* wasbs://<containerName>@<storageAccount>.blob.core.windows.net/
CHANGE TO:    -cp adl://<datalakeName>.azuredatalakestore.net/<containerName>/* wasbs://<containerName>@<storageAccount>.blob.core.windows.net/

hadoop fs -Dfs.azure.account.key.<storageAccount>.blob.core.windows.net="<accessKey>" \
   -ls wasbs://<containerName>@<storageAccount>.blob.core.windows.net/
CHANGE TO: hadoop fs -Dfs.azure.account.key.<storageAccount>.blob.core.windows.net="<accessKey>" \
   -ls wasbs://<containerName>@<storageAccount>.blob.core.windows.net/

```
{: .Example}

### Importing Your Data from Azure WASB or ADLS Storage  {#importadls}

If you're using Cloudera, to import your data into Splice Machine, you need to add property values to this file:

```
HDFS->Configuration->Cluster-wide Advanced Configuration Snippet (Safety Valve) for core-site.xml
```
{: .Plain}

Add the following values:

<table>
    <col />
    <col />
    <thead>
        <tr>
            <th>Name</th>
            <th>Value</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont">dfs.adls.oauth2.access.token.provider.type</td>
            <td class="CodeFont">ClientCredential</td>
        </tr>
        <tr>
            <td class="CodeFont">dfs.adls.oauth2.client.id</td>
            <td class="CodeFont">&lt;clientID&gt;</td>
        </tr>
        <tr>
            <td class="CodeFont">dfs.adls.oauth2.credential</td>
            <td class="CodeFont">&lt;clientSecret&gt;</td>
        </tr>
        <tr>
            <td class="CodeFont">dfs.adls.oauth2.refresh.url</td>
            <td class="CodeFont">https://login.microsoftonline.com/&lt;tenantID&gt;/oauth2/token</td>
        </tr>
        <tr>
            <td class="CodeFont">fs.azure.account.key.&lt;storageAccount&gt;.blob.core.windows.net</td>
            <td class="CodeFont">&lt;accessKey&gt;</td>
        </tr>
    </tbody>
</table>

Then, you can import data with statements like the following:

```
splice> call SYSCS_UTIL.IMPORT_DATA('mySchema', 'myTable1', null, 'wasbs://<containerName>@<storageAccount>.blob.core.windows.net/myTbl.tbl', '|', null, null, null, null, 0, '/BAD', true, null);
```
{: .Example}

```
splice> call SYSCS_UTIL.IMPORT_DATA('mySchema', 'myTable2', null, 'adl://<datalakeName>.azuredatalakestore.net/<containerName>/myTbl.tbl', '|', null, null, null, null, 0, '/BAD', true, null);
```
{: .Example}


## Configuring ADLS2 Storage Access  {#adls2}

You'll find an introduction to ADLS2 here: <a href="https://docs.microsoft.com/en-us/azure/storage/blobs/data-lake-storage-introduction" target="_blank">https://docs.microsoft.com/en-us/azure/storage/blobs/data-lake-storage-introduction</a>.

You can currently use ADLS2 with:

* Hadoop 3.2+
* Cloudera 6.1+
* Hortonworks 3.1.x+

The remainder of this section you how to configure ADLS2 storage for Splice Machine Access, in these subsections:

* [Configuring ADLS2 for Splice Machine](#configureadls2)
* [Copying Your Data from WASB to ADLS2](#copyadls2)
* [Importing Your Data from Azure ADLS2](#importadls2)

### Configuring ADLS2 for Splice Machine  {#configureadls2}

<div class="opsStepsList" markdown="1">
1.  Log in to the Azure portal:
    {: .topLevel}

    If needed, first create an Azure account. Then log in to the portal at <a href="https://portal.azure.com" target="_blank">https://portal.azure.com</a>.

2.  Create a resource group:
    {: .topLevel}

    Follow the instructions on this page to create a resource group: <a href="https://docs.microsoft.com/en-us/azure/azure-resource-manager/manage-resource-groups-portal" target="_blank">https://docs.microsoft.com/en-us/azure/azure-resource-manager/manage-resource-groups-portal</a>.

    For example, create the `myResourceGroup` resource group.

3.  Create an ADLS2 storage account:
    {: .topLevel}

    Follow the instructions on this page: <a href="https://docs.microsoft.com/en-us/azure/storage/blobs/data-lake-storage-quickstart-create-account" target="_blank">https://docs.microsoft.com/en-us/azure/storage/blobs/data-lake-storage-quickstart-create-account</a>.

    For example:

    ```
    Name: myadls2
    Resource group: myResourceGroup
    Location: West US 2
    Account kind: StorageV2
    ```
    {: .Example}

4.  Manage the storage account:
    {: .topLevel}

    * Add a file system; for example `myData`.
    * Get access key: `<accessKeyADLS2>`

{: .boldFont}
</div>

### Copying Your Data from WASB to ADLS2  {#copyadls2}

For Cloudera, follow the instructions in this page: <a href="https://www.cloudera.com/documentation/enterprise/latest/topics/admin_adls2_config.html" target="_blank">https://www.cloudera.com/documentation/enterprise/latest/topics/admin_adls2_config.html</a>. For example:

```
hadoop fs \
-Dfs.azure.account.key.olegadls2.dfs.core.windows.net="<accessKeyADLS2>" \
-Dfs.azure.account.key.olegwasb.blob.core.windows.net="<accessKeyWASB>" \
-cp wasbs://tpch1@olegwasb.blob.core.windows.net/* abfs://tpch1@olegadls2.dfs.core.windows.net/
```
{: .Example}

### Importing Your Data from Azure ADLS2  {#importadls2}

If you're using Cloudera, to import your data into Splice Machine, you add property values to this file:

```
HDFS->Configuration->Cluster-wide Advanced Configuration Snippet (Safety Valve) for core-site.xml
```
{: .Plain}

Add this value:

<table>
    <col />
    <col />
    <thead>
        <tr>
            <th>Name</th>
            <th>Value</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="CodeFont">fs.azure.account.key.myadls2.dfs.core.windows.net</td>
            <td class="CodeFont">&lt;accessKeyADLS2&gt;</td>
        </tr>
    </tbody>
</table>

You can then import data with a statement like the following:

```
splice> call SYSCS_UTIL.IMPORT_DATA('SPLICE', 'CUSTOMER', null, 'abfs://<containerName>@myadls2.dfs.core.windows.net/myTable.tbl', '|', null, null, null, null, 0, '/BAD', true, null);
```
{: .Example}

</div>
</section>
