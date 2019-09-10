---
summary: Enabling Azure Active Directory Integration
title: Cloud Manager Account Management
keywords: dbaas, paas, cloud manager, account
sidebar: home_sidebar
toc: false
product: dbaas
permalink: dbaas_cm_enableactivedir.html
folder: DBaaS/CloudManager
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">

# Enabling Azure Active Directory Integration

To enable Azure Active Directory Integration for your Cloud-Managed Splice Machine service, you must create an Azure Application Registration.

An App Registration allows an application (web page, service, etc) to integrate with Azure Active Directory (AD) with a single sign-on.  Having the application in Azure AD gives you control over the authentication policy for the application.

Follow these steps to create an Azure App Registration:

<div class="opsStepsList" markdown="1">

1.  Log into Azure.
2.  Select _Azure Active Directory_ in the left sidebar.
3.  Click _App Registrations_ in the panel that displays:

    ![](images/AzureAppReg1.png){: .indentedTightSpacing}

4.  Click _New Registration_ in the menu at the top of the panel. This displays the <span class="ConsoleLink">Register an Application screen:

    ![](images/AzureAppReg2.png){: .indentedTightSpacing}

5.  Fill in the following fields:

    a. Enter the name you want to use to identify your application.
    b. Select the supported account types; in most cases, you should select the _Accounts in this organizational directory only_ option.
    c. Enter the URLs that will use this App Registration in the _Redirect URI_ section.  Note that you can use the same APP Registration for multiple applications/environment.  For example, if you are integrating with the Splice Machine Cloud Manager, your URLs would look something like this:

       * http://localhost:3000
       * https://cloud.splicemachine-qa.io/login
       * https://hdev-splicecloud.yourcompany.splicemachine-dev.io/login

    d. Click the _Register_ button at the bottom of the screen to create your App Registration.

6.  The <span class="ConsoleLink">Overview</span> screen for your Application displays. __Make a note__ of the Application (client) ID on this screen; you'll need this ID for integration.

7.  Click the _Managed Application_ link:

    ![](images/AzureAppReg3.png){: .indentedTightSpacing}

8.  Now click _Permissions_ in the left sidebar:

    ![](images/AzureAppReg4.png){: .indentedTightSpacing}

9.  Click _Grant Admin consent for xxx_.
10. Select the directory and grant permissions.
11. Go back to the Application and select _Authentication_ in the left sidebar to display the <span class="ConsoleLink">Authentication</span> screen:

    ![](images/AzureAppReg5.png){: .indentedTightSpacing}

12. Scroll down in the center pane. Select these checkboxes in the _Advanced Settings_ section:

<<<<<<< HEAD
    * _Access Tokens__
    * _ID Tokens__
=======
    * _Access Tokens_
    * _ID Tokens_
>>>>>>> DocsTest3.0

13. Save your settings.
</div>

</div>
</section>
