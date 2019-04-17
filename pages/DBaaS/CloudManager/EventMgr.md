---
summary: Overview of the Cloud Manager Event Manager
title: Cloud Manager Event Manager
keywords: dbaas, paas, cloud manager, events, notifications
sidebar:  getstarted_sidebar
toc: false
product: dbaas
permalink: dbaas_cm_eventsmgr.html
folder: DBaaS/CloudManager
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Managing Your Event Notifications

This topic describes the Splice Machine Events Manager, which allows you
to examine notification messages sent to your cluster.

{% include splice_snippets/dbaasonlytopic.md %}

Here's a screenshot of a partially populated <span
class="ConsoleLink">Events Manager screen:</span>

![](images/EventsMgr1.png){: .indentedTightSpacing}

You can initiate these actions in the Events Manager:

* Display messages for one specific cluster, or all of your clusters; in
  the screenshot above, events are displayed for the cluster named
  *GaryDocs2*.
* Filter which messages are displayed; enter filter criteria, then click
  the <span class="CalloutFont">Filter</span> button. You can filter on:

  * A start date.
  * An end date.
  * A keyword or exact phrase.

  You can filter on a start date or end date on its own, or combine them
  together to specify a date range. You can also combine a date or
  date-range filter with a keyword filter to find only events that meet
  the combined criteria.

* You can click the <span class="CalloutFont">Clear Filter</span> button
  to clear any filters and display all of your notification messages.
* Click the <span class="CalloutFont">&lt;</span> (Prev), <span
  class="CalloutFont">&gt;</span> (Next), <span
  class="CalloutFont">&lt;&lt;</span> (First), or <span
  class="CalloutFont">&gt;&gt;</span> (Last) buttons to move through
  multiple screenfuls of messages.
* Click the arrow to the right of a message to display the full or
  shortened version of the message.

</div>
</section>
