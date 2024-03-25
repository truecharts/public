---
title: Upload existing world notes
---

Quick guide using on using Codeserver to upload your existing Valheim world files without having to start / stop the app or mount the apps PVC storage.

1.	Setup Codeserver either during installation or after installation, by editing the app. 
  a.	Go to the Add-on section
  b.	Enable Coderserver
  c.	Set service Type to LoadBalancer
  d.	Set default port of 36107
  e.	Save the changes

2.	Open Valheim Supervisor page – this can be accessed by using {Scale/App IP}:9011 e.g. 192.168.0.2:9011

3.	Stop all services – but don’t refresh the page as this may restart all the services again.

4.	Locate the world files on your computer, in Windows this can be found here: "C:\Users\{profileName}\AppData\LocalLow\IronGate\Valheim\worlds_local"

5.	Open Codeserver using the same Scale / App IP as used above this time with port 3610, {Scale/Apps IP}:36107 e.g. 192.168.0.2:36107

6.	Inside Codeserver, go to "config > worlds_local" in the explorer section and drag the files located above into this folder. The files here can be deleted and replaced or overwritten.
NOTE: The names of the files uploaded must match the name of the world that was supplied installing the app.

7.	Go back to Supervisor page and restart all services again.

8.	Give the server a couple of minutes to restart all services, but after your world files should be picked up, ready next time you load your server.

With above, you can also upload more than world providing they have unique names and switch between them just by changing the name of the world when you edit the app, this saves having to repeat the above process everytime you want to change worlds.

