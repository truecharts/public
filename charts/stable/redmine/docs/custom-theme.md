---
title: Custom theme for Redmine
---

This tutorial explains installing the [PurpleMine2 theme](https://github.com/mrliptontea/PurpleMine2) for the Redmine app installed from the TrueCharts catalog.

## Setup configuration

Default configuration with PVC storage

Add additional app storage as PVC with Mount path `/usr/src/redmine/public/themes`

![image](./img/image1.png)

You might also want to add `/usr/src/redmine/plugins` folder as PVC mount. This is the folder where you need to unzip your plugins if you want to use some.

As of the time of writing the app is not running normally when created with settings RunAsUser 568 RunAsGroup 568

![image](./img/image2.png)

Changing the configuration to RunAsUser 999 RunAsGroup 999 solves the issue.
Check this [issue](https://github.com/truecharts/charts/issues/15079) for details

Click on Save. Wait for the app to deploy.

Open the app. Login with default credentials (see below). You will be prompted to change the password.

- User: `admin`
- Password: `admin`

Go to `Administration->Settings->Display`. See that the only available theme is Default.

## Mount PVC volumes using HeavyScript

Now you can close the Redmine webpage and open the TrueNAS shell.

We will need to mount the PVC volumes using the HeavyScript.
If you don't have [HeavyScript](https://github.com/Heavybullets8/heavy_script) installed simply run this command to install it

```shell
sudo curl -s https://raw.githubusercontent.com/Heavybullets8/heavy_script/main/functions/deploy.sh | bash && source "$HOME/.bashrc" 2>/dev/null && source "$HOME/.zshrc" 2>/dev/null
```

then run

```shell
sudo heavyscript

# Move on the menu to
# Application Options -> Mount Unmount PVC storage -> Mount -> Redmine

Would you like to mount anything else? (y/N): n
```

## Use Moonlight Commander to copy the themes into the mounted volume

Now the redmine themes folder is available as the system path and we need to copy the theme files there.

I have already SMB Share setup so I copy the files into the SMB share. You can use Filebrowser app to upload the theme as well.

So I'm downloading the theme from the [upstream repository](https://github.com/mrliptontea/PurpleMine2)

And Unzip it to my SMB share folder.

Now in TrueNas shell I use

```shell
sudo mc

```

To launch the moonlight commander app. I navigate to my SMB share and to the mounted PVC path and copy the files over

![image](./img/image3.png)

## Change permissions of the themes files

Now we need to exit moonlight commander and navigate to the mounted themes folder in console using

```shell
cd /mnt/mounted_pvc/redmine/redmine-persist-list-0
ls - la
```

![image](./img/image4.png)

I also copied the standard Redmine themes alternate and classic to this folder

But you can see that all of the copied files are owned by my user and the group root. This means the Redmine will not be able to access the files.

Change the owner of the files with the following command

```shell
sudo chown -R root:apps PurpleMine2-master
sudo chmod -R 775 PurpleMine2-master
```

Repeat this commands for every theme folder you copied. And double check that owner have been changed and the permissions applied

![image](./img/image5.png)

## Unmount volumes and launch the app

Now you can unmount the volume using HeavyScript command

```shell
sudo heavyscript pvc --unmount redmine
```

Now run the application using `sudo heavyscript` Application Options -> Start Application -> Redmine

## Apply the theme

Open the Redmine web page. Sign in with your new password for Admin.

Go to `Administration` -> `Settings` -> `Display`. Pick the newly added theme

![image](./img/image6.png)
