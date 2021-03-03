# Storage

This article serves as a development extention to the storage article available [here](https://wiki.truecharts.org/general/storage/)

##### Storage and Common-Chart

For all these storage solutions we require the commonchart to be added to the App.
The Common-Chart handles both the connection/addition of storage to the container and spinning up special k8s jobs to fix the permissions if requested.


### Fixed Storage

When adding an App, there are almost always certain folders that are required for solid Apps performance. For example config files that should be persistent across restarts.
For these storages we can easily add fixes values in the UI, these settings can not be disabled or removed and would, by default, bind to an ix_volume if nothing is changed.
Preventing the user to disable them, ensures that users don't (by mistake) remove the storage.

#####

```
  - variable: appVolumeMounts
    label: "app storage"
    group: "Storage"
    schema:
      type: dict
      attrs:
        # Config ------------------------
        - variable: config
          label: "config dataset"
          schema:
            type: dict
            $ref:
              - "normalize/ixVolume"
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
              - variable: emptyDir
                label: "emptyDir"
                schema:
                  type: boolean
                  default: false
                  hidden: true
                  editable: false
              - variable: datasetName
                label: "Dataset Name"
                schema:
                  type: string
                  default: "config"
                  required: true
                  editable: false
              - variable: mountPath
                label: "Mount Path"
                description: "Path to mount inside the pod"
                schema:
                  type: path
                  required: true
                  default: "/config"
                  editable: false
              - variable: hostPathEnabled
                label: "host Path Enabled"
                schema:
                  type: boolean
                  default: false
                  show_subquestions_if: true
                  subquestions:
                    - variable: hostPath
                      label: "Host Path"
                      schema:
                        type: hostpath
                        required: true
```

### Unlimited Custom Storage Mounts

We support presenting the user with a "Do it yourself" style list, in which the user can add unlimited paths on the host system to mount.
It should always be included in any App, to give users the option to customise things however they like.

##### Example

```
  - variable: additionalAppVolumeMounts
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
