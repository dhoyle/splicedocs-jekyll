---
summary: How to install the virtual box version of Splice Machine
title: Installing the Virtual Box Version of Splice Machine.
keywords: virtualbox, standalone
toc: false
product: onprem
sidebar:  getstarted_sidebar
permalink: onprem_install_virtualbox.html
folder: OnPrem/InstallingSpliceMachine
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Installing the Virtual Box Standalone Version of Splice Machine

This topic describes installing the VirtualBox virtual machine version of Splice Machine

You can use the virtual machine standalone version of Splice Machine on Windows and other operating systems by following the instructions below. Your computer must meet these requirements; it must:

* support VirtualBox software
* have at least 8GB of RAM
* have at least 30GB of available disk space

Follow these instructions:

<div class="opsStepsList" markdown="1">
1. Download VirtualBox on to your computer from <a href="https://www.virtualbox.org" target="blank">https://www.virtualbox.org</a>.
   {: .topLevel}

2. Get the VM: Get a copy of the Splice Machine Virtual Machine.  This is a large file (4.3GB) so if you don't have a local copy already, you can download it from here: <a href="https://aws.amazon.com/s3://splice-training/splice2.5/Splice2.5.ova" >https://aws.amazon.com/s3://splice-training/splice2.5/Splice2.5.ova</a>.
   {: .topLevel}

   This is a very large (4.3GB) file; as a result, it can take a very long time to download, so we recommend storing the downloaded file to share with other employees.
   {: .noteNote}

3. Import the VM. Start up Virtual Box, and select "File->Import Appliance..." and navigate to the `Splice2.5.ova` file on your machine.  Click Continue then Import.
   {: .topLevel}

4. Start the VM. You will see the Splice2.5 VM in the VirtualBox window.  Double-click to start it.
   {: .topLevel}

   If your computer is blocking virtualization, the VM will fail to open the session, and the detailed message will say something like *VT-x is disabled in the BIOS*. You need to reboot your computer, enter BIOS, and enable Intel Virtualization. The following YouTube video walks you through resolving this problem: <a href="https://www.youtube.com/watch?v=u0AWnCr80Ws" target="blank">https://www.youtube.com/watch?v=u0AWnCr80Ws</a>.
   {: .indentLevel1}

5. Log in using `splice` for both the user ID and the password.
   {: .topLevel}

6. Right-click on the VirtualBox desktop, and click *Open Terminal* to open a terminal window.
   {: .topLevel}

7. Run this command (**required**):
   {: .topLevel}

   ```
   sudo ln -s /usr/bin/java /bin/java
   ```
   {: .ShellCommand}

8. Start Splice Machine from your terminal window by entering these two commands:
   {: .topLevel}

   ```
   cd splicemachine
   ./bin/start-splice.sh
   ```
   {: .ShellCommand}

   It will take a couple minutes until you see `done` and your terminal window prompt displays again. Splice Machine is now running.
   {: .indentLevel1}

9. You can now use the Splice Machine command line interpreter, `splice>` by entering this command in your terminal window:
   {: .topLevel}

   ```
   ./bin/sqlshell.sh
   ```
   {: .ShellCommand}

   When you see the `splice>` prompt, verify that all is well by entering this command (including the required `;` at the end):
   {: .indentLevel1}

   ```
   splice> show tables;
   ```
   {: .AppCommand}

   To exit the command line interpreter, enter:
   {: .indentLevel1}

   ```
   exit;
   ```
   {: .AppCommand}

10. When you're done (after you exit `splice>`), you can stop the Splice Machine processes with this command in your terminal window:
   {: .topLevel}

   ```
   ./bin/stop-splice.sh
   ```
   {: .ShellCommand}

</div>

</div>
</section>
