---
summary: Overview of the Cloud Manager Account Operations
title: Cloud Manager Account Management
keywords: dbaas, paas, cloud manager, account
sidebar: home_sidebar
toc: false
product: dbaas
permalink: dbaas_cm_acctmanage.html
folder: DBaaS/CloudManager
---
<section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# Managing Your Splice Machine Account

This topic describes the actions you can perform from the Account tab
and Account drop-down in your Dashboard, which include:

* [Logging Out of Your Account](#Logging)
* [Reviewing and Updating Your Billing Information](#Reviewin)
* [Viewing and Updating Your User Profile and Password](#Updating2)
* [Managing Users](#Inviting)
* [Reviewing and Updating Your Company Information](#Updating3)

{% include splice_snippets/dbaasonlytopic.md %}

## Logging Out of Your Account   {#Logging}

To log out of your Cloud Manager account, click the Account Drop-down
arrow in the upper-right of your dashboard screen, and select <span
class="ConsoleLink">Logout</span>:

![](images/SelectLogout.png){: .indentedTiny}

You'll be logged out and will land back on the Splice Machine Cloud
Manager <span class="ConsoleLink">Login</span> page.

## Reviewing and Updating Your Billing Information   {#Reviewin}

If you subscribed to Splice Machine via the AWS Marketplace, your
billing is handled by AWS, not Splice Machine. Your *Account Management*
screen will not contain a <span class="ConsoleLink">Billing
Activity</span> tab; this section does not apply to you.
{: .noteIcon}

To display billing information for your account, select the <span
class="ConsoleLink">Billing Activity</span> tab in a Cloud Manager
screen. You can see billing details for each month of each year that
your account has been alive. You can also hover over one of the bars
representing a cluster to see exactly how much that cluster cost in a
month (as shown for July in the image below).

If you have provisioned more than one cluster in your account, each
cluster is shown in a different color in the billing detail graphic, as
shown below.

![](images/BillingActivity.png){: .indentedTightSpacing}
{: .spaceAbove}


To update your payment source, click the <span
class="CalloutFont">Update</span> button.

### Prorated Monthly Billing

Splice Machine bills for our database service on a prorated monthly
basis; any adjustments for deleting or downsizing your cluster(s) are
applied to future bills or cluster purchases.

## Viewing and Updating Your User Profile and Password   {#Updating2}

You can review or edit your profile information by selecting <span
class="ConsoleLink">Profile</span> from the click the Account Drop-down:

![](images/SelectProfile.png){: .indentedTiny}
{: .spaceAbove}

The <span class="ConsoleLink">Profile</span> screen displays:

![](images/AccountProfile.png){: .indentedSmall}
{: .spaceAbove}

You can edit your profile information by clicking the <span
class="CalloutFont">EDIT</span> button in the Profile Info panel.

## Managing Users   {#Inviting}

To display the names and log-in information for the users of your
database service, select the <span class="ConsoleLink">Users</span> tab
in your Cloud Manager screen. The *Users* screen displays (we have redacted names and email addresses):

![](images/CloudAddRemoveUsers.png){: .indentedTightSpacing}
{: .spaceAbove}

### Adding a User via Invitation

To add another user, click the <span class="ConsoleLink">Invite User
+</span> button in the *Users* screen. Then enter the new user's email
address in the *Invite User* screen and click the <span
class="ConsoleLink">Send</span> button. We'll send an email inviting
that person to set up a password to access your database.

![](images/AccountUserInvite.png){: .indentedSmall}
{: .spaceAbove}

### Removing a User

To remove yourself as a user, or to remove a user whom you invited to join, you can click the small trash can icon that displays on the right side of the listing for that user. The trash can icon only displays for users who you are eligible to remove. You'll be asked to confirm the removal:

![](images/AccountRemoveConfirm.png){: .indentedSmall}

See the rules below for details about who can remove whom.

### Rules for Adding, Modifying, and Removing Users

Splice Machine enforces the following rules regarding users in your account:

* Each Cloud Account must have at least 1 *Primary* user at all time.
* A *non-primary* user can only delete him/herself.
* A *Primary* user can delete *non-primary* users at any time.
* You must be a *Primary* user to designate someone else as a *Primary* user.
* You must be a *Primary* user to remove another user's *Primary* status.
* Only a *Primary* user can delete another *Primary* user
* A *Primary* user can only delete him/herself if there is another *Primary* user.

## Reviewing and Updating Your Company Information   {#Updating3}

To display the company information associated with your account, select
the <span class="ConsoleLink">Users</span> tab in your Cloud Manager
screen. The *Company Information* screen displays:

![](images/AccountCompanyInfo.png){: .indentedTightSpacing}
{: .spaceAbove}

To edit the company information associated click the <span
class="CalloutFont">Edit</span> button.

</div>
</section>
