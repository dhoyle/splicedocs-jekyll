---
title: RlWrap Commands Synopsis
summary: Summarizes RLWrap commands.
keywords: rlWrap
toc: false
product: all
sidebar: cmdlineref_sidebar
permalink: cmdlineref_using_rlwrap.html
folder: CmdLineReference/Using
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# rlWrap Commands Synopsis

The <span class="CodeItalicFont">rlWrap</span> program is a *readline
wrapper*, a small utility that uses the GNU <span
class="CodeItalicFont">readline</span> library to allow the editing of
keyboard input for any command; it also provides a history mechanism
that is very handy for fixing or reusing commands. Splice Machine
strongly recommends that you use <span
class="CodeItalicFont">rlWrap</span> when interacting with your database
via our command line interface, which is also known as the <span
class="AppCommand">splice&gt;</span> prompt.

You can customize many aspects of <span
class="CodeItalicFont">rlWrap</span> and <span
class="CodeItalicFont">readline</span>, including the keyboard bindings
for the available commands. For more information, see the Unix man page
for <span class="CodeItalicFont">readline</span>.
{: .noteNote}

The following table summarizes some of the common keyboard options you
can use with <span class="CodeItalicFont">rlWrap</span>; this table uses
the default bindings that are in place when you install <span
class="CodeItalicFont">rlWrap</span> on MacOS; keyboard bindings may be
different in your environment.

<table summary="Commonly used keyboard shortcuts in rlWrap.">
                <col />
                <col />
                <thead>
                    <tr>
                        <th>Command</th>
                        <th>Description</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="AppFont">CTRL-@</td>
                        <td>Set mark</td>
                    </tr>
                    <tr>
                        <td class="AppFont">CTRL-A</td>
                        <td>Move to the beginning of the line</td>
                    </tr>
                    <tr>
                        <td class="AppFont">CTRL-B</td>
                        <td>Move back one character</td>
                    </tr>
                    <tr>
                        <td class="AppFont">CTRL-D</td>
                        <td>Delete the highlighted character</td>
                    </tr>
                    <tr>
                        <td class="AppFont">CTRL-E</td>
                        <td>Move to the end of the line</td>
                    </tr>
                    <tr>
                        <td class="AppFont">CTRL-F</td>
                        <td>Move forward one character</td>
                    </tr>
                    <tr>
                        <td class="AppFont">CTRL-H</td>
                        <td>Backward delete character</td>
                    </tr>
                    <tr>
                        <td class="AppFont">CTRL-J</td>
                        <td>Accept (submit) the line</td>
                    </tr>
                    <tr>
                        <td class="AppFont">CTRL-L</td>
                        <td>Clear the screen</td>
                    </tr>
                    <tr>
                        <td class="AppFont">CTRL-M</td>
                        <td>Accept the line</td>
                    </tr>
                    <tr>
                        <td class="AppFont">CTRL-N</td>
                        <td>Move to the next line in history</td>
                    </tr>
                    <tr>
                        <td class="AppFont">CTRL-P</td>
                        <td>Move to the previous line in history</td>
                    </tr>
                    <tr>
                        <td class="AppFont">CTRL-R</td>
                        <td>Reverse search through your command line history</td>
                    </tr>
                    <tr>
                        <td class="AppFont">CTRL-S</td>
                        <td>Forward search through your command line history</td>
                    </tr>
                    <tr>
                        <td class="AppFont">CTRL-T</td>
                        <td>Transpose characters: switch the highlighted character with the one preceding it</td>
                    </tr>
                    <tr>
                        <td class="AppFont">CTRL-U</td>
                        <td>Discard from the cursor position to the beginning of the line</td>
                    </tr>
                    <tr>
                        <td class="AppFont">CTRL-]</td>
                        <td>Search for a character on the line</td>
                    </tr>
                    <tr>
                        <td class="AppFont">CTRL-_</td>
                        <td>Undo</td>
                    </tr>
                    <tr>
                        <td colspan="2"> </td>
                    </tr>
                    <tr>
                        <td class="AppFont">ALT-&lt;</td>
                        <td>Go to the beginning of the history</td>
                    </tr>
                    <tr>
                        <td class="AppFont">ALT-&gt;</td>
                        <td>Go to the end of the history</td>
                    </tr>
                    <tr>
                        <td class="AppFont">ALT-B</td>
                        <td>Backward word</td>
                    </tr>
                    <tr>
                        <td class="AppFont">ALT-C</td>
                        <td>Capitalize the current word</td>
                    </tr>
                    <tr>
                        <td class="AppFont">ALT-F</td>
                        <td>Forward word</td>
                    </tr>
                    <tr>
                        <td class="AppFont">ALT-L</td>
                        <td>Downcase word</td>
                    </tr>
                    <tr>
                        <td class="AppFont">ALT-R</td>
                        <td>Revert line</td>
                    </tr>
                    <tr>
                        <td class="AppFont">ALT-T</td>
                        <td>Transpose words</td>
                    </tr>
                    <tr>
                        <td class="AppFont">ALT-U</td>
                        <td>Uppercase word</td>
                    </tr>
                </tbody>
            </table>
Note that the <span class="AppCommand">ALT</span> key is labeled as the
<span class="AppCommand">option</span> key on Macintosh keyboards.

If you're using the `splice>` prompt in the Terminal.app on MacOS, the
`ALT-` commands listed above only work if you select the `Use Option as
Meta key` setting in the keyboard preferences for your terminal window
{: .noteNote}

</div>
</section>
