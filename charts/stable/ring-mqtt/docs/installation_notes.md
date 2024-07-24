---
title: Installation Notes
---

- Follow the prerequisite guides below before attempting `Ring-MQTT` installation.

## MQTT setup

- I used the chart called `mosquitto` install it as normal and set `Authentication` to **true**. here's the [auth guide](/charts/stable/mosquitto/setup-guide).

## Ring-MQTT setup

Go to `http://SCALE_IP:55123`.

- Set `MQTT Url` to **mqtt://@mosquitto.ix-mosquitto.svc.cluster.local:1883** if not using mqtt auth or set the user/pass in the url like so: `mqtt://USER:PASS@mosquitto.ix-mosquitto.svc.cluster.local:1883`
- Set `LiveStream User` to **user_name** for the RTSP user.
- Set `LiveStream Password` to **user_pass** for the RTSP user.
- Leave `Disarm Code` blank.
- Set `Enable Cameras` to **true** to enable cameras.
- Set `Enable Modes` to **false** to disable location modes.
- Set `Enable Panic` to **false** to disable panic button.
- Set `Hass Topic` to **homeassistant/status** for the topic to monitor for Home Assistant restarts.
- Leave `Location Ids` blank.

## Home-assistant setup

- Install the chart `home-assistant` if you have not done so.

- In home-assistant go to settings -> devices & integrations -> click add integration -> search for `mqtt`.

- Set `broker` to `mosquitto.ix-mosquitto.svc.cluster.local`.
- Set `port` to `1883`.
- Set `username` and `password` to the MQTT auth user and pass.
- Set the `MQTT options` as needed.

- Shell into home-assistant, use truetool.sh or other means to modify the file `/config/configuration.yaml`.

- Add the following code.

```yaml
shell_command:
  ring_snap: "ffmpeg -y -i {{RTSP_URL}} -vframes 1 {{fileDirName}}"
```

- Create a new dir called `www` in `/config/`.
- Validate home-assistant configuration in `developer tools` and if passes; click on restart to use the service `ring_snap` in automations.

- Here's a sample on how to create a `live snapshot` automation.
- This will override the previous image if saved as `/config/www/snapshot.jpg`

```yaml
service: shell_command.ring_snap
data:
  RTSP_URL: "{{ states.sensor.front_door_info.attributes.stream_Source }}"
  fileDirName: "/config/www/snapshot.jpg"
```

- Note: You **must** save the file in `/config/www/` or set the option to allow other dirs for home-assistant to be used.

- Now you can create a live snapshot automation in `home-assistant`.
