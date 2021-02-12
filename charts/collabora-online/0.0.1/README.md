# Collabora Online (CODE)

## Introduction

This chart installs a collabora online (code) server
 
## Configuration

| **Description**                                                                                                        | **Parameter**         | **Type** | **Values**          | **Command Example (This is the defaults)** |
|------------------------------------------------------------------------------------------------------------------------|-----------------------|----------|---------------------|--------------------------------------------|
| Controls whether the welcome screen should be shown to the users on new install and updates.                      | welcome.enable        | bool     | true|false          | -o:welcome.enable=true                     |
| Controls whether the welcome screen should have an explanatory button instead of an X button to close the dialog. | welcome.enable_button | bool     | true|false          | -o:welcome.enable_button=false             |
| Controls whether the welcome screen should have an explanatory button instead of an X button to close the dialog. | user_interface.mode   | string   | classic|notebookbar | -o:user_interface.mode=notebookbar         |
| Opacity of on-screen watermark from 0.0 to 1.0                                                                         | watermark.opacity     | double   | 0.0 - 1.0           | -o:watermark.opacity=0.2                   |
| Watermark text to be displayed on the document if entered                                                         | watermark.text        | string   | Any text            | -o:watermark.text=""                       |


For more parameters and options, Bash in your container and `cat /etc/loolwsd/loolwsd.xml`