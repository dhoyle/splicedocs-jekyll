---
title: "This is the title that will display in the browser"
summary: This is the description displayed in search results. Limit to about 150 characters.
keywords: add tags here
toc: false
product: all
sidebar: Exact name of sidebar goes here; see below
permalink: Permalink goes here; see below
folder: The source folder of this topic file
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# YOUR HEADING ONE GOES HERE

This paragraphs provides a summary of what this topic describes. We often use bullets
to link to the subsections in this topic. For example:

* [First section link](#FirstSection)
* [Second section link](#SecondSection)
* [Third section link](#ThirdSection)

## Here':

This section describes the YAML template that you must include at the top of each topic page. Each topic page must begin with a YAML section that includes a number of keywords that Jekyll uses when building the web.

The YAML section starts and ends with "---" on a line by itself and contains a number of mandatory YAML key/value pairs:

```html
---
title:      This is the title that will display in the browser; do not exceed 50 characters
summary:    This is the description displayed in search results. Limit to about 150 characters
keywords:   These are the Tags associated with the page. Currently unused.
toc:        Always set to false
product:    Always set to all
sidebar:    Which navigation sidebar this topic belongs to. See the sidebars discussion below for more info.
folder:     The source file folder in which this topic file is located.
permalink:  The permalink URL that will assigned to this page. See the permalinks discussion below for more info.
---
```

### Example

Here's an example of a YAML section at the top of a topic page:

```html
---
title: Analyze command
summary: Collects statistics for a table or schema.
keywords: analyze, analyze command, statistics, stats
toc: false
product: all
sidebar: cmdlineref_sidebar
permalink: cmdlineref_analyze.html
folder: CmdLineReference
---
```

## The Heading 1 Part

Immediately below the YAML template on each page are these entities:

* The main <section> tag, which we use to delimit the content of each page
* The TopicContent <div> tag that specifies this as a searchable page for SwifType
* The H1 topic heading

For example:

```html
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Splice Machine Documentation Topic Page Template
```

## The End of Each Page

At the bottom of each topic page are the closing tags for the main div and section:

```html
</div>
</section>
```


## Sidebars

Each major section (*book*) in the documentation has a navigation sidebar that is a YAML file. Each sidebar contains a link to each page in the section. For simplicity, our sidebars are limited to only 2 levels deep. Our sidebars as of this writing (early 2018) are:

* cmdlineref_sidebar.yml
* dbaas_sidebar.yml
* dbconsole_sidebar.yml
* developers_sidebar.yml
* home_sidebar.yml
* notes_sidebar.yml
* onprem_sidebar.yml
* sqlref_sidebar.yml
* tutorials_sidebar.yml

The sidebar specifications are found in `splicedocs-jekyll/_data/sidebars`.  DO NOT modify these unless you're certain that you know what you're doing!

Each sidebar is a list of folders. Each folder links to an introductory page and contains a list of topic page links. Each link entry specifies the title shown in the sidebar, the permalink for the page, and and indication of whether the page is included in the web build, the pdf build, or both. [as of this writing, all pages are both]

Like other YAML files, the sidebar specifications use indentation to define hierarchy.

## Permalinks

Jekyll associates a permalink with each page that it generates. For simplicity, we build our web such that all pages are found at the root of the docs directory, so all permalinks are root-based.

We use strict naming conventions for these permalinks:

* Each links starts with the name of the "book" to which it belongs, followed by an underbar, e.g.
  * cmdlineref_
  * sqlref_
  * developers_
  * tutorials_
  * onprem_

* Each link optionally (if appropriate) contains the section of the books to which it belongs followed by an underbar, e.g.
  * sysprocs_
  * datatypes_
  * errorcodes_
  * install_

* Each link includes the name of the topic, e.g.
  * analyze
  * importdata
  * select
  * hortonworks

* Each link ends with the '.html' suffix.


### Permalink Examples

Here are some examples of permalinks in the docs web:
* cmdlineref_analyze.html
* sqlref_sysprocs_importdata.html
* sqlref_datatypes_boolean.html
* developers_fundamentals_foreignkeys.html
* onprem_install_hortonworks.html

You'll notice that you can easily derive the permalink for a page by examining where it is located in the navigate hierarchy.

</div>
</section>
