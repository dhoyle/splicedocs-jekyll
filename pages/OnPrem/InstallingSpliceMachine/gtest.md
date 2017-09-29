---
summary: How to download, install, configure and verify your installation of Splice Machine on CDH.
title: Installing and Configuring Splice Machine for Cloudera Manager
keywords: Cloudera, CDH, installation, hadoop, hbase, hdfs, sqlshell.sh, sqlshell, parcel url
toc: false
product: onprem
sidebar:  onprem_sidebar
permalink: onprem_install_gtest.html
folder: OnPrem/InstallingSpliceMachine
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

{% include splicevars.html %}

# Installing and Configuring Splice Machine for Cloudera Manager

A paragraph.

## Install the Splice Machine Parcel   {#Install}

Follow these steps to install CDH, Hadoop, Hadoop services, and Splice
Machine on your cluster:

<div class="opsStepsList" markdown="1">
1.  Copy your parcel URL to the clipboard for use in the next step.
    {: .topLevel}

    Which Splice Machine parcel URL you need depends upon which Splice
    Machine version you're installing and which version of CDH you are
    using. Here are the URLs for Splice Machine Release {{splvar_basic_SpliceReleaseVersion}} and
    {{splvar_basic_SplicePrevReleaseVersion}}:
    {: .indentLevel1}

    <table>
        <col />
        <col />
        <col />
        <col />
        <thead>
            <tr>
                <th>Splice Machine Release</th>
                <th>CDH Version</th>
                <th>Parcel Type</th>
                <th>Installer Package Link(s)</th>
            </tr>
        </thead>
        <tbody>
           <tr>
               <td rowspan="12" class="SpliceRelease">2.6.1</td>
               <td rowspan="6" class="SplicePlatform">{{splvar_install_CDH5120}}</td>
               <td>EL6</td>
               <td><a href="{{splvar_install_v261_CDH5120-EL6}}">{{splvar_install_v261_CDH5120-EL6}}</a></td>
           </tr>
           <tr>
               <td>EL7</td>
               <td><a href="{{splvar_install_v261_CDH5120-EL7}}">{{splvar_install_v261_CDH5120-EL7}}</a></td>
           </tr>
           <tr>
               <td>Precise</td>
               <td><a href="{{splvar_install_v261_CDH5120-PRECISE}}">{{splvar_install_v261_CDH5120-PRECISE}}</a></td>
           </tr>
           <tr>
               <td>SLES11</td>
               <td><a href="{{splvar_install_v261_CDH5120-SLES11}}">{{splvar_install_v261_CDH5120-SLES11}}</a></td>
           </tr>
           <tr>
               <td>Trusty</td>
               <td><a href="{{splvar_install_v261_CDH5120-TRUSTY}}">{{splvar_install_v261_CDH5120-TRUSTY}}</a></td>
           </tr>
           <tr>
               <td>Wheezy</td>
               <td><a href="{{splvar_install_v261_CDH5120-WHEEZY}}">{{splvar_install_v261_CDH5120-WHEEZY}}</a></td>
            </tr>
           <tr>
               <td rowspan="6" class="SplicePlatform">{{splvar_install_CDH583}}</td>
               <td>EL6</td>
               <td><a href="{{splvar_install_v261_CDH583-EL6}}">{{splvar_install_v261_CDH583-EL6}}</a></td>
           </tr>
           <tr>
               <td>EL7</td>
               <td><a href="{{splvar_install_v261_CDH583-EL7}}">{{splvar_install_v261_CDH583-EL7}}</a></td>
           </tr>
           <tr>
               <td>PRECISE</td>
               <td><a href="{{splvar_install_v261_CDH583-PRECISE}}">{{splvar_install_v261_CDH583-PRECISE}}</a></td>
           </tr>
           <tr>
               <td>SLES11</td>
               <td><a href="{{splvar_install_v261_CDH583-SLES11}}">{{splvar_install_v261_CDH583-SLES11}}</a></td>
           </tr>
           <tr>
               <td>Trusty</td>
               <td><a href="{{splvar_install_v261_CDH583-TRUSTY}}">{{splvar_install_v261_CDH583-TRUSTY}}</a></td>
           </tr>
           <tr>
               <td>Wheezy</td>
               <td><a href="{{splvar_install_v261_CDH583-WHEEZY}}">{{splvar_install_v261_CDH583-WHEEZY}}</a></td>
            </tr>
            <tr>
                <td colspan="4" class="Separator"> </td>
            </tr>
           <tr>
               <td rowspan="12" class="SpliceRelease">2.5.0</td>
               <td rowspan="6" class="SplicePlatform">{{splvar_install_CDH583}}</td>
               <td>EL6</td>
               <td><a href="{{splvar_install_v250_CDH583-EL6}}">{{splvar_install_v250_CDH583-EL6}}</a></td>
           </tr>
           <tr>
               <td>EL7</td>
               <td><a href="{{splvar_install_v250_CDH583-EL7}}">{{splvar_install_v250_CDH583-EL7}}</a></td>
           </tr>
           <tr>
               <td>Precise</td>
               <td><a href="{{splvar_install_v250_CDH583-PRECISE}}">{{splvar_install_v250_CDH583-PRECISE}}</a></td>
           </tr>
           <tr>
               <td>SLES11</td>
               <td><a href="{{splvar_install_v250_CDH583-SLES11}}">{{splvar_install_v250_CDH583-SLES11}}</a></td>
           </tr>
           <tr>
               <td>Trusty</td>
               <td><a href="{{splvar_install_v250_CDH583-TRUSTY}}">{{splvar_install_v250_CDH583-TRUSTY}}</a></td>
           </tr>
           <tr>
               <td>Wheezy</td>
               <td><a href="{{splvar_install_v250_CDH583-WHEEZY}}">{{splvar_install_v250_CDH583-WHEEZY}}</a></td>
            </tr>
           <tr>
               <td rowspan="6" class="SplicePlatform">{{splvar_install_CDH580}}</td>
               <td>EL6</td>
               <td><a href="{{splvar_install_v250_CDH580-EL6}}">{{splvar_install_v250_CDH580-EL6}}</a></td>
           </tr>
           <tr>
               <td>EL7</td>
               <td><a href="{{splvar_install_v250_CDH580-EL7}}">{{splvar_install_v250_CDH580-EL7}}</a></td>
           </tr>
           <tr>
               <td>Precise</td>
               <td><a href="{{splvar_install_v250_CDH580-PRECISE}}">{{splvar_install_v250_CDH580-PRECISE}}</a></td>
           </tr>
           <tr>
               <td>SLES11</td>
               <td><a href="{{splvar_install_v250_CDH580-SLES11}}">{{splvar_install_v250_CDH580-SLES11}}</a></td>
           </tr>
           <tr>
               <td>Trusty</td>
               <td><a href="{{splvar_install_v250_CDH580-TRUSTY}}">{{splvar_install_v250_CDH580-TRUSTY}}</a></td>
           </tr>
           <tr>
               <td>Wheezy</td>
               <td><a href="{{splvar_install_v250_CDH580-WHEEZY}}">{{splvar_install_v250_CDH580-WHEEZY}}</a></td>
            </tr>
        </tbody>
    </table>

    To be sure that you have the latest URL, please check [the Splice
    Machine Community site][1]{: target="_blank"} or contact your Splice
    Machine representative.
    {: .noteIcon}

2.  Add the parcel repository
    {: .topLevel}

    1. Make sure the <span class="AppCommand">Use Parcels
    (Recommended)</span> option and the <span
    class="AppCommand">Matched release</span> option are both
    selected.

    2. Click the <span class="AppCommand">Continue</span> button to
    land on the *More Options* screen.

    3. Cick the <span class="AppCommand">+</span> button for the <span
    class="AppCommand">Remote Parcel Repository URLs</span> field.
    Paste your Splice Machine repository URL into this field.
    {: .LowerAlphaPlainFont}

3.  Use Cloudera Manager to install the parcel.
    {: .topLevel}

4.  Verify that the parcel has been distributed and activated.
    {: .topLevel}

    The Splice Machine parcel is identified as `SPLICEMACHINE` in the
    Cloudera Manager user interface. Make sure that this parcel has been
    downloaded, distributed, and activated on your cluster.
    {: .indentLevel1}

5.  Restart and redeploy any client changes when Cloudera Manager
prompts you.
    {: .topLevel}

    </div>
{: .boldFont}

</div>

</div>
</section>
