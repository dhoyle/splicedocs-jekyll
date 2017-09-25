---
title: Debugging Splice Machine
summary: Describes the parameter values you use when using debugging software with Splice Machine.
keywords: debug, debug port, trace
toc: false
product: all
sidebar: developers_sidebar
permalink: developers_tuning_debugging.html
folder: Developers/TuningAndDebugging
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Debugging Splice Machine

This topic describes the parameter values you need to know for debugging
Splice Machine with a software tool:

* Create a configuration in your software to remotely attach to
  Splice Machine
* Connect to port `4000`.
  
  If you're debugging code that is to be run in a Spark worker, connect
  to port `4020` instead.
  {: .noteNote}

### Example

Here's an example of an *IntelliJ IDEA* debugging configuration using
port `4000`:

![Sample configuration for debugging Splice Machine with IntelliJ
IDEA](images/DebugSetupScreen.png "Sample configuration for debugging
Splice Machine with IntelliJ IDEA"){: .indentedTightSpacing}

{% include splice_snippets/githublink.html %}
</div>
</section>

