# How to install the custom theme for TrueCharts Redmine with PVC storage

This tutorial explains installing the https://github.com/mrliptontea/PurpleMine2 theme for the Redmine app installed from the TrueCharts catalog. 

## Setup configuration
Default configuration with PVC storage

Add additional app storage as PVC with Mount path /usr/src/redmine/public/themes


![image](https://github.com/truecharts/website/assets/42300339/8eabd72d-a6b4-46ef-a093-c6977f78daf3)


As of the time of writing the app is not running normally when created with settings RunAsUser 568 RunAsGroup 568


![image](https://github.com/truecharts/website/assets/42300339/87689e67-16c9-4835-8bb5-2d63d4032145)


changing the configuration to RunAsUser 999 RunAsGroup 999 solves the issue. Check this ticket for details


https://github.com/truecharts/charts/issues/15079


Click on Save. Wait for the app to deploy.


Open the app. Login with default credentials `loging: admin Password: admin`. You will be prompted to change the password.


Go to `Administration->Settings->Display`. See that the only available theme is Default.

## Mount PVC volumes using HeavyScript
Now you can close the Redmine webpage and open the TrueNAS shell. 


We will need to mount the PVC volumes using the HevyScript. If you don't have HeavyScript installed simply run this command to install it


```
sudo curl -s https://raw.githubusercontent.com/Heavybullets8/heavy_script/main/functions/deploy.sh | bash && source "$HOME/.bashrc" 2>/dev/null && source "$HOME/.zshrc" 2>/dev/null
```


More details on what it does here: https://github.com/Heavybullets8/heavy_script


then run 

```
sudo heavyscript
```
Application Options -> Mount Unmount PVC storage -> Mount -> Redmine

Would you like to mount anything else? (y/N): n

## Use Moonlight Commander to copy the themes into the mounted volume

Now the redmine themes folder is available as the system path and we need to copy the theme files there.

I have already SMB Share setup so I copy the files into the SMB share. You can use Filebrowser app to upload the theme as well.

So I'm downloading the theme from https://github.com/mrliptontea/PurpleMine2

And Unzip it to my SMB share folder.

Now in TrueNas shell I use 
```
sudo mc
```
To launch the moonlight commander app. I navigate to my SMB share and to the mounted PVC path and copy the files over

![image](https://github.com/truecharts/website/assets/42300339/857f94bb-d3c8-4d29-a933-9404fc31c2b1)


## Change permissions of the themes files
Now we need to exit moonlight commander and navigate to the mounted themes folder in console using

```
cd /mnt/mounted_pvc/redmine/redmine-persist-list-0
ls - la
```
![image](https://github.com/truecharts/website/assets/42300339/009d858c-b3cc-42a9-99bd-d4c5ae196804)


I also copied the standard Redmine themes alternate and classic to this folder

But you can see that all of the copied files are owned by my user and the group root. This means the Redmine will not be able to access the files. 

Chage the owner of the files with the following command

```
sudo chown -R root:apps PurpleMine2-master
sudo chmod -R 775 PurpleMine2-master 
```
Repeat this commands for every theme folder you copied. And double check that owner have been changed and the permissions applied

![image](https://github.com/truecharts/website/assets/42300339/429dfbef-03d8-4934-b031-5531a673ca86)

## Unmount volumes and launch the app
Now you can unmount the volume using HeavyScript command
```
sudo heavyscript pvc --unmount redmine
```
Now run the application using `sudo heavyscript` Application Options -> Start Application -> Redmine

## Apply the theme

Open the Redmine web page. Sign in with your new password for Admin. 

Go to Administration -> Settings -> Display. Pick the newly added theme

![image](https://github.com/truecharts/website/assets/42300339/adc3a743-4bef-4d41-9506-aca45edcdd86)
