# Installation Notes

- Follow the prerequisite guides below before attempting `Ring-MQTT` installation.

## MQTT setup

- I used the chart called `mosquitto` install it as normal and set `Authentication` to **true**. here's the [auth guide](https://truecharts.org/docs/charts/stable/mosquitto/setup-guide).

## Ring-MQTT setup

- `RINGTOKEN` can be left blank as you can auth through the temporarily web interface which is just for the authorization of your ring account.
- Go to `http://SCALE_IP:55123`.
- Set `MQTTHOST` to **mosquitto.ix-mosquitto.svc.cluster.local**.
- Set `MQTTPORT` to **1883**.
- Set `MQTTUSER` to **user_name** from the authentication setup.
- Set `MQTTPASSWORD` to **user_pass** from the authentication setup.
- Set `ENABLECAMERAS` to **true** to enable cameras.
- Set `SNAPSHOTMODE` to **Auto** to optimize based on high vs low-power Ring devices.
- Set `ENABLEMODES` to **false**.
- Set `ENABLEPANIC` to **false**.
- Set `BEAMDURATION` to **0**.
- Leave `DISARMCODE` blank.
- Leave `RINGLOCATIONIDS` blank.

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
