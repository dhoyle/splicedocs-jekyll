---
title: Splice Machine Error Codes - Class 58&#58; DRDA Network Protocol | Protocol Error
summary: Summary of Splice Machine Class 58 Errors
keywords: 58 errors, error 58
toc: false
product: all
sidebar:  sqlref_sidebar
permalink: sqlref_errcodes_class58.html
folder: SQLReference/ErrorCodes
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Error Class 58: DRDA Network Protocol: Protocol Error

<table>
                <caption>Error Class 58: DRDA Network Protocol: Protocol Error</caption>
                <thead>
                    <tr>
                        <th>SQLSTATE</th>
                        <th>Message Text</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><code>58009.C.10</code></td>
                        <td>Network protocol exception: only one of the VCM, VCS length can be greater than 0.  The connection has been terminated.</td>
                    </tr>
                    <tr>
                        <td><code>58009.C.11</code></td>
                        <td>The connection was terminated because the encoding is not supported.</td>
                    </tr>
                    <tr>
                        <td><code>58009.C.12</code></td>
                        <td>Network protocol exception: actual code point, <span class="VarName">&lt;value&gt;</span>, does not match expected code point, <span class="VarName">&lt;value&gt;</span>.  The connection has been terminated.</td>
                    </tr>
                    <tr>
                        <td><code>58009.C.13</code></td>
                        <td>Network protocol exception: DDM collection contains less than 4 bytes of data.  The connection has been terminated.</td>
                    </tr>
                    <tr>
                        <td><code>58009.C.14</code></td>
                        <td>Network protocol exception: collection stack not empty at end of same id chain parse.  The connection has been terminated.</td>
                    </tr>
                    <tr>
                        <td><code>58009.C.15</code></td>
                        <td>Network protocol exception: DSS length not 0 at end of same id chain parse.  The connection has been terminated.</td>
                    </tr>
                    <tr>
                        <td><code>58009.C.16</code></td>
                        <td>Network protocol exception: DSS chained with same id at end of same id chain parse.  The connection has been terminated.</td>
                    </tr>
                    <tr>
                        <td><code>58009.C.17</code></td>
                        <td>Network protocol exception: end of stream prematurely reached while reading InputStream, parameter #<span class="VarName">&lt;value&gt;</span>.  The connection has been terminated.</td>
                    </tr>
                    <tr>
                        <td><code>58009.C.18</code></td>
                        <td>Network protocol exception: invalid FDOCA LID.  The connection has been terminated.</td>
                    </tr>
                    <tr>
                        <td><code>58009.C.19</code></td>
                        <td>Network protocol exception: SECTKN was not returned.  The connection has been terminated.</td>
                    </tr>
                    <tr>
                        <td><code>58009.C.20</code></td>
                        <td>Network protocol exception: only one of NVCM, NVCS can be non-null.  The connection has been terminated.</td>
                    </tr>
                    <tr>
                        <td><code>58009.C.21</code></td>
                        <td>Network protocol exception: SCLDTA length, <span class="VarName">&lt;length&gt;</span>, is invalid for RDBNAM.  The connection has been terminated.</td>
                    </tr>
                    <tr>
                        <td><code>58009.C.7</code></td>
                        <td>Network protocol exception: SCLDTA length, <span class="VarName">&lt;length&gt;</span>, is invalid for RDBCOLID.  The connection has been terminated.</td>
                    </tr>
                    <tr>
                        <td><code>58009.C.8</code></td>
                        <td>Network protocol exception: SCLDTA length, <span class="VarName">&lt;length&gt;</span>, is invalid for PKGID.  The connection has been terminated.</td>
                    </tr>
                    <tr>
                        <td><code>58009.C.9</code></td>
                        <td>Network protocol exception: PKGNAMCSN length, <span class="VarName">&lt;length&gt;</span>, is invalid at SQLAM <span class="VarName">&lt;value&gt;</span>.  The connection has been terminated.</td>
                    </tr>
                    <tr>
                        <td><code>58010.C</code></td>
                        <td>A network protocol error was encountered.  A connection could not be established because the manager <span class="VarName">&lt;value&gt;</span> at level <span class="VarName">&lt;value&gt;</span> is not supported by the server. </td>
                    </tr>
                    <tr>
                        <td><code>58014.C</code></td>
                        <td>The DDM command 0x<span class="VarName">&lt;value&gt;</span> is not supported.  The connection has been terminated.</td>
                    </tr>
                    <tr>
                        <td><code>58015.C</code></td>
                        <td>The DDM object 0x<span class="VarName">&lt;value&gt;</span> is not supported.  The connection has been terminated.</td>
                    </tr>
                    <tr>
                        <td><code>58016.C</code></td>
                        <td>The DDM parameter 0x<span class="VarName">&lt;value&gt;</span> is not supported.  The connection has been terminated.</td>
                    </tr>
                    <tr>
                        <td><code>58017.C</code></td>
                        <td>The DDM parameter value 0x<span class="VarName">&lt;value&gt;</span> is not supported.  An input host variable may not be within the range the server supports.  The connection has been terminated.</td>
                    </tr>
                </tbody>
            </table>
</div>
</section>

