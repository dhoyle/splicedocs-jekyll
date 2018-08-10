---
title: Features of the Splice Machine Database Console
summary: Summarizes the user interface features of the Splice Machine Database Console.
keywords: console, console features, ui, dbaas, paas, db
toc: false
product: all
sidebar:  tutorials_sidebar
permalink: tutorials_dbconsole_features.html
folder: DeveloperTutorials/DBConsole
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Features of the Splice Machine Database Console

This section summarizes the use of major features of the Database
Console interface, including:

* [Drilling Down](#Drilling)
* [Switching Views](#Switchin)
* [Hovering](#Hovering)
* [Refreshing the View](#Refreshi)
* [Zooming the Timeline View](#Zooming)

## Drilling Down   {#Drilling}

In general, you can click anything that displays in blue (<span
class="ConsoleLink">like this</span>) to drill down into a more detailed
view. For example, clicking <span class="ConsoleLink">Explain</span> in
the following description from the completed jobs table will drill down
into the job details for *Job 113*:

![Drilling down in the Spark UI by clicking blue
text](images/SparkUIDrillDown.png){: .indentedTightSpacing}

You can continue to drill down from there to reveal increasing levels of
detail.
{: .noSpaceAbove}

## Switching Views   {#Switchin}

You can quickly switch to a different view by clicking a tab in the tab
bar at the top of the console screen. The <span
class="AppCommand">Jobs</span> tab is selected in this screen shot:

![Splice Database Console view tabs](images/SparkUITabs.png){:
.indentedTightSpacing}

### Hovering   {#Hovering}

You can hover the cursor over interface element links, like the <span
class="ConsoleLink">Event Timeline</span> drop-down in the following
image, to display a screen tip for the item:

![Hovering over the console links to view screen
tips](images/SparkUIHover.png){: .indentedTightSpacing}

Similarly, you can hover over the ? to display the definition for a
term, like the definition of a job:

![Hovering over a question mark in the console UI to see the definition
of a term](images/SparkUIHover2.png){: .indentedTightSpacing}

And you can hover over an event in timeline display to see summary
information; for example:

![Hovering over a timeline event for summary
information](images/SparkUITimelineHover.png){: .indentedTightSpacing}

## Refreshing the View   {#Refreshi}

Currently, the console does not automatically or periodically refresh
the view.

If you're monitoring an active job, you'll need to refresh your browser
window to view the latest activity.

## Zooming the Timeline View   {#Zooming}

When you're viewing an event timeline, you can <span
class="ConsoleLink">Enable zooming</span>, which allows you to use mouse
or touch gestures to zoom in on a portion or a timeline, zoom out, or
scroll through the timeline.

## See Also

* [About the DB Console](tutorials_dbconsole_intro.html)
* [Managing Queries with the DB Console](tutorials_dbconsole_queries.html)

</div>
</section>
