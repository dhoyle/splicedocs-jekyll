---
title: "Importing Data:  Error Handling"
summary: Describes how to use logging and how to handle errors during data ingestion.
keywords: import, ingest, input parameters, compression, encoding, separator
toc: false
product: all
sidebar: tutorials_sidebar
permalink: tutorials_ingest_importerrors.html
folder: Tutorials/Ingest
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Importing Data: Logging and Error Handling

This topic provides

##


### Tip #6: Change the Bad Directory for Each Table / Group   {#Tip6}

If you are importing a large amount of data and have divided the files
you are importing into groups, then it's a good idea to change the
location of the bad record directory for each group; this will make
debugging bad records a lot easier for you.

You can change the value of the `badRecordDirectory` to include your
group name; for example, we typically use a strategy like the following:

<table style="width: 100%;">
                <col />
                <col />
                <thead>
                    <tr>
                        <th>Group Files Location</th>
                        <th><span class="CodeBoldFont">badRecordDirectory</span> Parameter Value</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><code>/data/mytable1/group1</code></td>
                        <td><code>/BAD/mytable1/group1</code></td>
                    </tr>
                    <tr>
                        <td><code>/data/mytable1/group2</code></td>
                        <td><code>/BAD/mytable1/group2</code></td>
                    </tr>
                    <tr>
                        <td><code>/data/mytable1/group3</code></td>
                        <td><code>/BAD/mytable1/group3</code></td>
                    </tr>
                </tbody>
            </table>
You'll then be able to more easily discover where the problem record is
located.
