# 04 - Editing Apps

Editing Apps is possible since 21.08, although it has a slightly different GUI it exposes the same setting as installing an App.

##### Requirements

- Make sure your storage-pool is created and working
- Make Make sure you selected your storage-pool when you first opened the "Apps" interface, if not please refer to quick-start guide `01 - First time Apps setup`
- Make sure you have a working internet connection and can reach github and truecharts.org from the host system.
- Make sure you already added the TrueCharts catalog from guide 02
- Make sure your App is installed and, preferably, working

##### Editing the App

- Go to `Installed Applications`
- click the menu button on the right side of the App card
- Select `Edit`
- Change any settings you want to change
- Submit your changes

The App will then go through a process of submitting your changes. If the proces fails, your changes will not be submitted and the edit will be reverted.
The process popup disapears, it might take a few minutes to actually deploy your new changes, due to some things that happen in the background.

#### Video Guide

![type:video](https://www.youtube.com/embed/3ki2AlBYwsc)

##### Notes

- It's NOT advisable to switch between Nodeport and Loadbalancer, using the same ports. This WILL cause problems. If you edit an app and switch between NodePort and Loadbalancer, please be sure to use different ports.
