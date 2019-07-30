---
title: How many write threads should I have?
summary: Configuring the number of write threads for Splice Machine
keywords:
toc: false
compatible_version: 2.7
product: all
category: Database Configuration
sidebar: home_sidebar
permalink: spliceanswers_q12.html
folder: SpliceAnswers/DatabaseConfiguration
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

# How many write threads should I have?

## Applies When?
Always.

## Answer: It depends on your handler count

Increase the values of these two properties to be equal to 40% of the handler count:

* `splice.independent.write.threads`
* `splice.dependent.write.threads`

## Related Questions:

## Questions That Link to This Topic:



</div>
</section>
