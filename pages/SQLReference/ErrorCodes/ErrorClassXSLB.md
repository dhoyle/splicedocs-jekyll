---
title: Splice Machine Error Codes - Class XSLB&#58; RawStore - Log.Generic statement exceptions
summary: Summary of Splice Machine Class XSLB Errors
keywords: XSLB errors, error XSLB
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_errcodes_classxslb.html
folder: SQLReference/ErrorCodes
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Error Class XSLB: RawStore - Log.Generic statement exceptions

<table>
                <caption>Error Class XSLB: RawStore - Log.Generic statement exceptions</caption>
                <thead>
                    <tr>
                        <th>SQLSTATE</th>
                        <th>Message Text</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><code>XSLB1.S</code></td>
                        <td>Log operation <span class="VarName">&lt;logOperation&gt;</span> encounters error writing itself out to the log stream, this could be caused by an errant log operation or internal log buffer full due to excessively large log operation.</td>
                    </tr>
                    <tr>
                        <td><code>XSLB2.S</code></td>
                        <td>Log operation <span class="VarName">&lt;logOperation&gt;</span> logging excessive data, it filled up the internal log buffer.</td>
                    </tr>
                    <tr>
                        <td><code>XSLB4.S</code></td>
                        <td>Cannot find truncationLWM <span class="VarName">&lt;value&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>XSLB5.S</code></td>
                        <td>Illegal truncationLWM instant <span class="VarName">&lt;value&gt;</span> for truncation point <span class="VarName">&lt;value&gt;</span>. Legal range is from <span class="VarName">&lt;value&gt;</span> to <span class="VarName">&lt;value&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>XSLB6.S</code></td>
                        <td>Trying to log a 0 or -ve length log Record.</td>
                    </tr>
                    <tr>
                        <td><code>XSLB8.S</code></td>
                        <td>Trying to reset a scan to <span class="VarName">&lt;value&gt;</span>, beyond its limit of <span class="VarName">&lt;value&gt;</span>.</td>
                    </tr>
                    <tr>
                        <td><code>XSLB9.S</code></td>
                        <td>Cannot issue any more change, log factory has been stopped.</td>
                    </tr>
                </tbody>
            </table>
</div>
</section>

