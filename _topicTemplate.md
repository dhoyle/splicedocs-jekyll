---
title: Title that will show in browser
summary: A sentence that is used by search engines crawling the docs site; make this meaningful
toc: false                                      # Don't change this
product: all                                    # Don't change this
sidebar: developers_sidebar                     # See _data/sidebars for the ids of our sidebars
permalink: developers_fundamentals_auth.html    # Use this pattern: folder_subfolder_topic.html
folder: Developers/Fundamentals                 # Use: folder/subfolder;
---
<section>

<div class="TopicContent" data-swiftype-index="true" markdown="1">
# First level heading (Title at top of topic) goes here

The rest of your content goes here

NOTES:

1. You must specify one of our sidebars, AND you must edit that sidebar's configuration file to add the new topic:

   a. Find and open the sidebar .yml file in the project's _data/sidebars folder. Our sidebars are:

       * cmdlineref_sidebar
       * getstarted_sidebar
       * dbconsole_sidebar
       * developers_sidebar
       * home_sidebar
       * getstarted_sidebar
       * getstarted_sidebar
       * sqlref_sidebar
       * tutorials_sidebar

   b. In the sidebar file, find the location where you want the topic displayed

   c. Add these three lines in that location, making sure that you include the correct number of spaces at the beginning of each line, so that each is indented in the same way as for other topics:
     - title: Roles and Authorization                  # this is the title shown in the sidebar
       url: /developers_fundamentals_auth.html         # must match the permalink you specified in the topic file; Always preface with the `/`
       output: web, pdf                                # use this as is

2. The permalink should follow our standard pattern, which is:

   * all lowercase letters, with underbars ( `_` ) separating the components
   * add the `.html` suffix at the end
   * first component is: the top-level folder (e.g. developers or onprem or dbaas, etc)
   * second component is: the name of the subfolder if there is one (e.g. fundamentals or tuning);
   * no second component needed if there is no subfolder
   * the topic name

   Examples:
       * developers_fundamentals_auth.html
       * developers_tuning_queryoptimization.html
       * notes_usingdocs.html
       * onprem_install_cloudera.html
       * sqlref_statements_createrole.html



</div>
</section>
