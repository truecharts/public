# Unlimited Storage Mounts

We support presenting the user with a "Do it yourself" style list, in which the user can add unlimited paths on the host system to mount.
It should always be included in any App, to give users the option to customise things however they like.

### Example

```
  - variable: appExtraVolumeMounts
    label: "Custom app storage"
    group: "Storage"
    schema:
      type: list
      default: []
      items:
        - variable: volumeMount
          label: "Custom Storage"
          schema:
            type: dict
            attrs:
              - variable: enabled
                label: "Enabled"
                schema:
                  type: boolean
                  default: true
                  required: true
                  hidden: true
                  editable: false
              - variable: setPermissions
                label: "Automatic Permissions"
                description: "Automatically set permissions on install"
                schema:
                  type: boolean
                  default: true
                  hidden: false
              - variable: name
                label: "Mountpoint Name"
                schema:
                  type: string
                  default: ""
                  required: true
                  editable: true
              - variable: emptyDir
                label: "emptyDir"
                schema:
                  type: boolean
                  default: false
                  hidden: true
                  editable: false
              - variable: mountPath
                label: "Mount Path"
                description: "Path to mount inside the pod"
                schema:
                  type: path
                  required: true
                  default: ""
                  editable: true
              - variable: hostPathEnabled
                label: "host Path Enabled"
                schema:
                  type: boolean
                  default: true
                  hidden: true
              - variable: hostPath
                label: "Host Path"
                schema:
                  type: hostpath
                  required: true
```
