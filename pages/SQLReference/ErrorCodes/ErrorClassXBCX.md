---
title: Splice Machine Error Codes - Class XBCX&#58; Cryptography
summary: Summary of Splice Machine Class XBCX Errors
keywords: XBCX errors, error XBCX
toc: false
product: all
sidebar: home_sidebar
permalink: sqlref_errcodes_classxbcx.html
folder: SQLReference/ErrorCodes
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Error Class XBCX: Cryptography

<table>
                <caption>Error Class XBCX: Cryptography</caption>
                <thead>
                    <tr>
                        <th>SQLSTATE</th>
                        <th>Message Text</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><code>XBCX0.S</code></td>
                        <td>Exception from Cryptography provider. See next exception for details.</td>
                    </tr>
                    <tr>
                        <td><code>XBCX1.S</code></td>
                        <td>Initializing cipher with illegal mode, must be either ENCRYPT or DECRYPT.</td>
                    </tr>
                    <tr>
                        <td><code>XBCX2.S</code></td>
                        <td>Initializing cipher with a boot password that is too short. The password must be at least <span class="VarName">&lt;number&gt;</span> characters long.    </td>
                    </tr>
                    <tr>
                        <td><code>XBCX5.S</code></td>
                        <td>Cannot change boot password to null.</td>
                    </tr>
                    <tr>
                        <td><code>XBCX6.S</code></td>
                        <td>Cannot change boot password to a non-string serializable type.</td>
                    </tr>
                    <tr>
                        <td><code>XBCX7.S</code></td>
                        <td>Wrong format for changing boot password.  Format must be : old_boot_password, new_boot_password.</td>
                    </tr>
                    <tr>
                        <td><code>XBCX8.S</code></td>
                        <td>Cannot change boot password for a non-encrypted database.</td>
                    </tr>
                    <tr>
                        <td><code>XBCX9.S</code></td>
                        <td>Cannot change boot password for a read-only database.  </td>
                    </tr>
                    <tr>
                        <td><code>XBCXA.S</code></td>
                        <td>Wrong boot password.</td>
                    </tr>
                    <tr>
                        <td><code>XBCXB.S</code></td>
                        <td>Bad encryption padding '<span class="VarName">&lt;value&gt;</span>' or padding not specified. 'NoPadding' must be used.</td>
                    </tr>
                    <tr>
                        <td><code>XBCXC.S</code></td>
                        <td>Encryption algorithm '<span class="VarName">&lt;algorithmName&gt;</span>' does not exist. Please check that the chosen provider '<span class="VarName">&lt;providerName&gt;</span>' supports this algorithm.</td>
                    </tr>
                    <tr>
                        <td><code>XBCXD.S</code></td>
                        <td>The encryption algorithm cannot be changed after the database is created.</td>
                    </tr>
                    <tr>
                        <td><code>XBCXE.S</code></td>
                        <td>The encryption provider cannot be changed after the database is created.</td>
                    </tr>
                    <tr>
                        <td><code>XBCXF.S</code></td>
                        <td>The class '<span class="VarName">&lt;className&gt;</span>' representing the encryption provider cannot be found.</td>
                    </tr>
                    <tr>
                        <td><code>XBCXG.S</code></td>
                        <td>The encryption provider '<span class="VarName">&lt;providerName&gt;</span>' does not exist.</td>
                    </tr>
                    <tr>
                        <td><code>XBCXH.S</code></td>
                        <td>The encryptionAlgorithm '<span class="VarName">&lt;algorithmName&gt;</span>' is not in the correct format. The correct format is algorithm/feedbackMode/NoPadding.</td>
                    </tr>
                    <tr>
                        <td><code>XBCXI.S</code></td>
                        <td>The feedback mode '<span class="VarName">&lt;mode&gt;</span>' is not supported. Supported feedback modes are CBC, CFB, OFB and ECB.</td>
                    </tr>
                    <tr>
                        <td><code>XBCXJ.S</code></td>
                        <td>The application is using a version of the Java Cryptography Extension (JCE) earlier than 1.2.1.  Please upgrade to JCE 1.2.1 and try the operation again.    </td>
                    </tr>
                    <tr>
                        <td><code>XBCXK.S</code></td>
                        <td>The given encryption key does not match the encryption key used when creating the database. Please ensure that you are using the correct encryption key and try again. </td>
                    </tr>
                    <tr>
                        <td><code>XBCXL.S</code></td>
                        <td>The verification process for the encryption key was not successful. This could have been caused by an error when accessing the appropriate file to do the verification process.  See next exception for details.  </td>
                    </tr>
                    <tr>
                        <td><code>XBCXM.S</code></td>
                        <td>The length of the external encryption key must be an even number.</td>
                    </tr>
                    <tr>
                        <td><code>XBCXN.S</code></td>
                        <td>The external encryption key contains one or more illegal characters. Allowed characters for a hexadecimal number are 0-9, a-f and A-F.</td>
                    </tr>
                    <tr>
                        <td><code>XBCXO.S</code></td>
                        <td>Cannot encrypt the database when there is a global transaction in the prepared state.</td>
                    </tr>
                    <tr>
                        <td><code>XBCXP.S</code></td>
                        <td>Cannot re-encrypt the database with a new boot password or an external encryption key when there is a global transaction in the prepared state.</td>
                    </tr>
                    <tr>
                        <td><code>XBCXQ.S</code></td>
                        <td>Cannot configure a read-only database for encryption.</td>
                    </tr>
                    <tr>
                        <td><code>XBCXR.S</code></td>
                        <td>Cannot re-encrypt a read-only database with a new boot password or an external encryption key .</td>
                    </tr>
                    <tr>
                        <td><code>XBCXS.S</code></td>
                        <td>Cannot configure a database for encryption, when database is in the log archive mode.</td>
                    </tr>
                    <tr>
                        <td><code>XBCXT.S</code></td>
                        <td>Cannot re-encrypt a database with a new boot password or an external encryption key, when database is in the log archive mode.</td>
                    </tr>
                    <tr>
                        <td><code>XBCXU.S</code></td>
                        <td>Encryption of an un-encrypted database failed: <span class="VarName">&lt;failureMessage&gt;</span></td>
                    </tr>
                    <tr>
                        <td><code>XBCXV.S</code></td>
                        <td>Encryption of an encrypted database with a new key or a new password failed: <span class="VarName">&lt;failureMessage&gt;</span></td>
                    </tr>
                    <tr>
                        <td><code>XBCXW.S</code></td>
                        <td>The message digest algorithm '<span class="VarName">&lt;algorithmName&gt;</span>' is not supported by any of the available cryptography providers. Please install a cryptography provider that supports that algorithm, or specify another algorithm in the derby.authentication.builtin.algorithm property.</td>
                    </tr>
                </tbody>
            </table>
</div>
</section>

