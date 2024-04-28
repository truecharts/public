# Setup Guide

DockOvpn is administered using the app shell.

## Generate Config

To generate a OpenVPN configuration file use the following command from the app shell:

```bash title="Generate Configuration"
./genclient.sh
```

After running this command, a temporary web server will be started which can be used to download the configuration file.

## Additional Options

Additionally, you can use the linked shell commands to do more advanced OpenVPN configuration generation and to access or revoke previous configurations.

[Container Commands](https://github.com/dockovpn/dockovpn#container-commands)
