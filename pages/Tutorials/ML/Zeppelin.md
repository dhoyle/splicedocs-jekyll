---
title: Using Apache Zeppelin with Splice Machine
summary: A tutorial showing you how to use Apache Zeppelin to analyze data in an on-premise Splice Machine database.
keywords: on-premise notebook, on-premise Zeppelin
toc: false
product: all
sidebar: tutorials_sidebar
permalink: tutorials_ml_zeppelin.html
folder: Tutorials/ML
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Connecting with Apache Zeppelin

{% include splice_snippets/onpremonlytopic.md %}
This tutorial walks you through connecting your on-premise Splice
Machine database with Apache Zeppelin, which is a web-based notebook
project currently in incubation at Apache. In this tutorial, you'll
learn how to use SQL to query your Splice Machine database from
Zeppelin.

<div class="noteNote" markdown="1">
Zeppelin is already integrated into the Splice Machine
Database-as-Service product; please see our [*Using
Zeppelin*](dbaas_zep_intro.html) documentation for more information.

See [https://zeppelin.apache.org/][1]{: target="_blank"} to learn more
about Apache Zeppelin.

</div>
{% if site.incl_notpdf %}
<div markdown="1">
You can complete this tutorial by [watching a short video](#Watch){:
.selected}, or by [following the written directions](#Written){:
.selected} below.

## Watch the Video   {#Watch}

The following video shows you how to connect Splice Machine with Apache
Zeppelin..

<div class="centered" markdown="1">
<iframe class="youtube-player_0"
src="https://www.youtube.com/embed/h0KWRghLziI?" frameborder="0"
allowfullscreen="1" width="560px" height="315px"></iframe>

</div>
</div>
{% endif %}
<div markdown="1">
## Written Walk Through   {#Written}

This section walks you through using SQL to query a Splice Machine
database with Apache Zeppelin..

<div class="opsStepsList" markdown="1">
1.  Install Zeppelin:
    {: .topLevel}
    
    If you're running on AWS, you can install the Zeppelin sandbox
    application; if you're using an on-premise database, we recommend
    following the [instructions in this video.][2]{: target="_blank"}
    {: .indentLevel1}

2.  Create a new interpreter to run with Splice:
    {: .topLevel}
    
    1.  Select the <span class="ConsoleLink">Interpreter</span> tab in
        Zeppelin.
    2.  Click the <span class="ConsoleLink">Create</span> button (in the
        upper right of the Zeppelin window) to create a new interpreter.
        Fill in the property fields as follows:
        
        <table>
                                                <col />
                                                <col />
                                                <tbody>
                                                    <tr>
                                                        <td><em>Name</em></td>
                                                        <td>Whatever name you like; we're using <code>SpliceMachine</code></td>
                                                    </tr>
                                                    <tr>
                                                        <td><em>Interpreter</em></td>
                                                        <td>Select <code>jdbc</code> from the drop-down list of interpreter types.</td>
                                                    </tr>
                                                    <tr>
                                                        <td><em>default.url</em></td>
                                                        <td>
                                                            <p><code>jdbc:splice:/<span class="HighlightedCode">myServer</span>:1527/splicedb</code>
                                                            </p>
                                                            <p>(replace <span class="HighlightedCode">myServer</span> with the name of the server that you're using)</p>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td><em>default password</em></td>
                                                        <td><code>admin</code></td>
                                                    </tr>
                                                    <tr>
                                                        <td><em>default userId</em></td>
                                                        <td><code>splice</code></td>
                                                    </tr>
                                                    <tr>
                                                        <td><em>common.max_count</em></td>
                                                        <td><code>1000</code></td>
                                                    </tr>
                                                    <tr>
                                                        <td><em>default.driver</em></td>
                                                        <td><code>com.splicemachine.db.jdbc.ClientDriver</code></td>
                                                    </tr>
                                                    <tr>
                                                        <td><em>Artifacts</em></td>
                                                        <td>
                                                            <p>Insert the path to the Splice Machine jar file; for example:</p>
                                                            <div class="preWrapperWide"><pre class="Example">/tmp/db-client-2.5.0.1708-SNAPSHOT.jar</pre>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
    
    3.  Click the <span class="ConsoleLink">Save</span> button to save
        your interpreter definition.
    {: .LowerAlphaPlainFont}
    
     
    {: .indentLevel1}

3.  Create a note:
    {: .topLevel}
    
    Select the <span class="ConsoleLink">Notebook</span> tab in
    Zeppelin, and then click <span class="ConsoleLink">+ Create new
    note</span>.
    {: .indentLevel1}
    
    1.  Specify a name and click the <span class="ConsoleLink">Create
        Note</span> button.
    2.  Enable interpreters for the note. In this case, we move the
        Splice Machine interpreter to the top of the list, then click
        the Save button to make it the default interpreter:
        
        ![](images/ZepInterpreter1_412x213.png){: style="width:
        412;height: 213;"}
    
    3.  Create a Zeppelin paragraph (a jdbc action) that calls a stored
        procedure. The procedure we're calling in this tutorial is named
        MOVIELENS; it is used to analyze data in a table. In this case,
        we're using this procedure to report statistics on the Age
        column in our movie watchers database. This Zeppelin paragraph
        looks like this:
        
            %jdbccall MOVIELENS.ContinuousFeatureReport('movielens.user_demographics');
        {: .Example}
        
        The <span class="Example">%jdbc</span> specifies that we're
        creating a paragraph that uses a JDBC interpreter; since we've
        made the SpliceMachine driver our default JDBC connector, it
        will be used.
    
    4.  The results of this call look like this:
        
        ![](images/ZepAge1.png "Initial results of running the movielens
        paragraph"){: .nestedTightSpacing}
    
    5.  We can also create a new paragraph that performs additional
        analysis; you'll see that whenever you run a paragraph in
        Zeppelin, it automatically leaves room at the bottom to create
        another paragraph.
        
            %jdbcselect count(1) num_age, age from MOVIELENS.USER_DEMOGRAPHICS group by age;
        {: .Example}
        
        The results of this paragraph:
        
        ![](images/ZepPgf2.png "Age analysis results"){:
        .nestedTightSpacing}
    {: .LowerAlphaPlainFont}

4.  Change how you view your data
    {: .topLevel}
    
    To get a better sense of what you can do with Zeppelin, we'll modify
    how we visualize this data:
    {: .indentLevel1}
    
    1.  Click the rightmost settings icon, then click <span
        class="ConsoleLink">settings</span>.
        
        ![](images/ZepSettings.png){: .nestedTightSpacing
        style="margin-left: 0px;margin-right: 0px;margin-top:
        0px;margin-bottom: 0px;padding-top: 4px;"}
    
    2.  Move age to the xAxis, and the number of people of that age to
        the yAxis.
    3.  You'll now see the distribution of ages:
        
        ![](images/ZepScatter.png){: .nestedTightSpacing}
    
    4.  Click the graphs button to select other data visualizations:
        
        ![](images/ZepGraphs.png){: .nestedTightSpacing
        style="margin-left: 0px;margin-right: 0px;margin-top:
        0px;margin-bottom: 0px;padding-top: 4px;"}
    {: .LowerAlphaPlainFont}
{: .boldFont}

</div>
</div>
</div>
</section>



[1]: https://zeppelin.apache.org/ "Link to the main Apache Zeppelin web site."
[2]: http://www.mapr.com/blog/building-apache-zeppelin-mapr-using-spark-under-yarn "Link to instructions for installing Zeppelin on MapR"
