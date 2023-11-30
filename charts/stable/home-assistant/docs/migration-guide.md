# Home Assistant Migration Guide

## Updating the db_url in configuration.yaml

When migrating home assistant, the new database information must be added to the configuration.yaml file in the home assistant docker. Failing to do this will prevent the “recorder”, “history”, “energy” and other modules from loading.

1. Run the tcdbinfo.sh script and take note of the connection info
- Note down the username, password, address and port for the new database.

```bash
bash tcdbinfo.sh | grep <application_name>
```

For example:
```bash
bash tcdbinfo.sh | grep home-assistant
```
![tcdbinfo-output](./img/tcdbinfo-output.png)

**This command can also be run without `| grep <app_name>` to obtain the information for all postgres databases**

2. Open Application Shell  
Use [Heavyscript](https://github.com/Heavybullets8/heavy_script) with the following command to open up a shell. Select the correct pod from the pod list (ensure to select the pod without `cnpg` in the name).

```bash
heavyscript pod --shell <application_name>
```
For example:

```bash
heavyscript pod --shell home-assistant
```
Use `enter` to enter confirm entry to the shell for the pod

![heavyscript-pod-select](./img/heavyscript-pod-select.png)

3. Edit the configuration.yaml file  
Using `vi` in the `/config` directory, open the `configuration.yaml` file for editing

![vi-configuration](./img/vi-configuration.png)

Use the `i` key on the keyboard to enter insert mode in `vi`

Scroll down to the area of the file labelled `recorder:`. From here, the current line marked `db_url:` can be commented out using a `#` character at the beginning of the line.  
  
The new database connection can now be added directly underneath the old line. Ensure to align the text and indetation exactly as the previous db_url line was. The syntax for the line is as follows:

```
<db_url: "postgresql://<username>:<password>@<address>:<port>/home-assistant?client_encoding=utf8">
```
For example:
```
db_url: "postgresql://home-assistant:SGhkwFwGTOiqyYZcP7ZnstR41fhhew0sVJNYDMAJal4GQZmU7vZJlzGMh9cvlm@home-assistant-cnpg-main-rw.ix-home-assistant.svc.cluster.local:5432/home-assistant?client_encoding
```

![configuration-update](./img/configuration-update.png)


4. Save configuration.yaml
Save and exit the file by first hitting `esc` on the keyboard, then typing 

```
:wq
```  

`exit` can now be used in the shell to exit the pod

5. Reload the application  
The application can now be restarted, either from the webpage or from within TrueNAS Scale

# TODO
- Include a way to open a shell within the home-assistant configuration pod without the use of HeavyScript

