---
title: Splice Machine Impersonation
summary: Describes how to open a JDBC connection to Splice Machine using impersonation
toc: false
compatible_version: 2.7
product: all
sidebar: home_sidebar
permalink: tutorials_security_impersonation.html
folder: DeveloperTutorials/Security
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Splice Machine Impersonation

This topic describes Splice Machine *impersonation*, which is how
Splice Machine can authenticate one user (the *impersonator*), who is then authorized as if s/he has authenticated as another user (the *spliceUser*). Impersonation is useful when you're connecting to Splice Machine from a third party tool.

<p class="noteIcon" markdown="1">At this time, impersonation only works with Hue 4.3 or later.</p>

## How it Works

Assuming that all has been configured as described later in this topic, here's an example of how you might use impersonation.

If:
* Your company has *Hue* running on a server in its cluster.
* Hue is able to authenticate with Splice Machine as `HueUser`.
* You can connect to Hue on your cluster as `spliceUser`.
* `spliceUser` is authorized with permissions in Splice Machine.

Then, assuming that all is properly configured, impersonation would works as follows:
* You connect to Hue as `spliceUser` on your cluster.
* Hue connects to Splice Machine as `HueUser`, impersonating `spliceUser`.
* Queries from Hue are authorized as if originating from `spliceUser`.

In this case, Hue is responsible for authenticating `spliceUser`; Splice Machine validates `HueUser` and assumes that the user passed along by Hue, `spliceUser` is valid.

## Configuring Impersonation in Splice Machine

For impersonation to work, you must add two entries to your `hbase-site.xml` configuration file:

1.  Enable impersonation with this property:
    `splice.authentication.impersonation.enabled = true`

2.  Specify which authenticated users can connect as which Splice users:
    `splice.authentication.impersonation.users = <personationsList>`

    Where `<personationsList>` is a list of `auth=user(s)` specifications, separated by semicolons. For example:

    <table>
        <col width="55%" />
        <col width="45%" />
        <thead>
            <tr>
                <th>Personations List</th>
                <th>Description</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td class="CodeFont">hueUser1=john,jane</td>
                <td>
                    <ul class="bulletCell">
                        <li><code>hueUser1</code> can impersonate <code>john</code> or <code>jane</code></li>
                    </ul>
                </td>
            </tr>
            <tr>
                <td class="CodeFont">hueUser1=john,jane;hueUser2=dennis,denise;hueUser3=mark,mary</td>
                <td>
                    <ul class="bulletCell">
                        <li><code>hueUser1</code> can impersonate <code>john</code> or <code>jane</code></li>
                        <li><code>hueUser2</code> can impersonate <code>dennis</code> or <code>denise</code></li>
                        <li><code>hueUser3</code> can impersonate <code>mark</code> or <code>mary</code></li>
                    </ul>
                </td>
            </tr>
            <tr>
                <td class="CodeFont">hueUser1=barry,barbara;hueUser2=barry,denise;hueUser3=*</td>
                <td>
                    <ul class="bulletCell">
                        <li><code>hueUser1</code> can impersonate <code>barry</code> or <code>barbara</code></li>
                        <li><code>hueUser2</code> can impersonate <code>barry</code> or <code>denise</code></li>
                        <li><code>hueUser3</code> can impersonate any user</li>
                    </ul>
                </td>
            </tr>
        </tbody>
    </table>

## Configuring the Hue Connection

Here's an example of configuring a connection in Hue:

```
[[[Splice]]]
  name=Splice
  interface=jdbc
  options='{"url": "jdbc:splice://<spliceHost>:1527/splicedb", "driver": "com.splicemachine.db.jdbc.ClientDriver", "user": "<HueUser>", "password": "<HuePassword>", "impersonation_property": "impersonate"}'
```
{: .Example}

<p class="noteNote">When you connect, Hue will automatically add the <span class="HighlightedCode">;impersonate=<></span> part to your connection URL if the Hue configuration includes the <code>impersonation_property</code> setting. Other third party tools might require different configurations.</p>

## Specifying Impersonation in Your JDBC URL

When connecting with impersonation, you need to include the name of the user you're impersonating in the JDBC connection URL. Here's the format:

<div class="preWrapper" markdown="1"><pre class="Plain">
jdbc:splice://<span class="HighlightedCode">spliceHost</span>:1527/splicedb;user=<span class="HighlightedCode">HueUser</span>;password=<span class="HighlightedCode">HuePassword</span>;impersonate=<span class="HighlightedCode">ImpersonatedUser</span>
</pre></div>

For example:
<div class="preWrapper" markdown="1"><pre class="Example">
jdbc:splice:://mytrial.splicemachine.io:1527/splicedb;user=HueUser1;password=myPswd;impersonate=barry
</pre></div>

</div>
</section>
