---
title: "Securing Log Information"
summary: How to obfuscate information in log files
keywords: schema, authorization
toc: false
compatible_version: 2.8
product: all
sidebar: home_sidebar
permalink: tutorials_security_loginfo.html
folder: Securing/Security
---

<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Securing Log Information

Splice Machine uses the open source <a href="http://logging.apache.org/log4j/1.2/manual.html" target="_blank">Apache log4j Logging API</a>, which allows you to associate a logger object with any
java class, among other features. See our [Using Splice Machine's Logging](developers_tuning_logging.html) topic for more information.

{% include splice_snippets/logobfuscation.md %}


</div>
</section>
