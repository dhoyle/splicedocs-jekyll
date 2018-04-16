---
title: Release Notes for This Release of Splice Machine
summary: Release notes for this release of Splice Machine.
keywords: release notes, on-premise
toc: false
product: all
sidebar:  releasenotes_sidebar
permalink: releasenotes_intro.html
folder: ReleaseNotes
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
{% include splicevars.html %}
{% assign site.pdf_runninghead = "Release Notes" %}

# Release Notes for Splice Machine

Welcome to the {{site.build_version}} Release of Splice Machine, originally released  {{site.release_date}}. Our release notes are presented in these topics:

<table>
    <col width="40%" />
    <col />
    <thead>
        <tr>
            <th>Topic</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><a href="releasenotes_dbintro.html">Splice Machine Database Release Notes</a></td>
            <td><p>Release notes for the Splice Machine database, which is the basis for both our <em>Database-as-Service</em> and <em>On-Premise Database</em> products. These release notes are presented in these topics:</p>
                <ul>
                    <li><a href="releasenotes_newfeatures.html">New Features and Changes</a></li>
                    <li><a href="releasenotes_improvements.html">Improvements</a></li>
                    <li><a href="releasenotes_bugfixes.html">Issues Fixed</a></li>
                    <li><a href="releasenotes_workarounds.html">Limitations and Workarounds</a></li>
                </ul>
                <p>Each note category contains the base release notes, and links to incremental (patch) update notes.</p>
            </td>
        </tr>
        <tr>
            <td><a href="releasenotes_dbaas.html">Splice Machine Database-as-Service Product</a></td>
            <td>Release notes specific to changes in our database-as-a-service product.</td>
        </tr>
        <tr>
            <td><a href="releasenotes_onprem.html">Splice Machine On-Premise Database Product</a></td>
            <td>Release notes specific to changes in our on-premise database product.</td>
        </tr>
    </tbody>
</table>

Splice Machine Release 2.6 was an interim release in September, 2017, which coincided with the initial Release of our Database-as-a-Service product. All changes in v2.6 have been incorporated into the 2.7 Release of the Splice Machine database.
{: .noteIcon}

The product is available to build from open source (see <https://github.com/splicemachine/spliceengine>), as well as prebuilt packages for use on a cluster or cloud.

</div>
</section>
