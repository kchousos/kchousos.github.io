---
title: BIOS update for Lenovo laptop on Linux
date: 2024-12-25 16:36:00+03:00
lastmod: 2024-12-25
categories:
  - software
  - hardware
  - BIOS
draft: false
aliases:
  - 20250327163227-25ae
---
Updating your BIOS is often perceived as a straightforward task. You run an `.exe` file, you wait a minute or two, your screen flashes and poof, you're done. This at least is the Lenovo Experience™ with their BIOS update wizards.

But what if your laptop is running Linux? Then the only way to use these `.exe` files would be to dual boot with a Windows partition. Unfortunately, this is not acceptable for most.

The easiest solution I came to find was instead of using a normal Windows installation, I could run the update from a live CD Windows image, specifically [**Hiren's BootCD PE**](https://www.hirensbootcd.org/). From their homepage:

> Hiren’s BootCD PE (Preinstallation Environment) is a restored edition of Hiren’s BootCD based on Windows 11 PE x64. Given the absence of official updates after November 2012, the PE version is currently under development by the fans of Hiren’s BootCD. It includes a carefully chosen set of the best free tools, designed for modern computers that support UEFI booting and need at least 4 GB of RAM.

It is a very interesting project and one that in my case came in very handy. The only problem I faced was that the laptop wouldn't connect to Wi-Fi and thus I wasn't able to download the `.exe` file. My solution was copying the update executable to another USB from which I transferred it to the live image. Simply executing the file worked correctly and the update was successful!

Hope this short post will be helpful to anyone facing a similar problem :).

<center>
<div class="tinylytics-kudos"></div>
</center>