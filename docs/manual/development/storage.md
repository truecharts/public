# Storage

This article serves as a development extention to the storage article available [here](https://wiki.truecharts.org/general/storage/)

##### Storage and Common-Chart

For all these storage solutions we require the commonchart to be added to the App.
The Common-Chart handles both the connection/addition of storage to the container and spinning up special k8s jobs to fix the permissions if requested for the Custom storage.

### Integrated Persistent Storage

When adding an App, there are almost always certain folders that are required for solid Apps performance. For example config files that should be persistent across restarts.

For these storages we can easily add fixes values in the UI, these settings can not be disabled or removed and would, by default and preferably, be limited to the "internal" storage class
Preventing the user to disable them, ensures that users don't (by mistake) remove the storage.

#####

```
  - variable: persistence
    label: "Integrated Persistent Storage"
    description: "Websocket Service"
    group: "Storage"
    schema:
      type: dict
      attrs:
        - variable: data
          label: "App Config Storage"
          description: "Stores the Application Configuration."
          schema:
            type: dict
            attrs:
              - variable: enabled
                label: "Enable the storage"
                schema:
                  type: boolean
                  default: true
                  hidden: false
              - variable: storageClass
                label: "Type of Storage"
                description: " Warning: Anything other than SCALE-ZFS will break rollback!"
                schema:
                  type: string
                  default: "SCALE-ZFS"
              - variable: mountPath
                label: "mountPath"
                description: "Path inside the container the storage is mounted"
                schema:
                  type: string
                  default: "/config"
                  hidden: true
              - variable: emptyDir
                label: "EmptyDir Volume"
                schema:
                  type: dict
                  hidden: false
                  attrs:
                    - variable: enabled
                      label: "Use emptyDir volume"
                      schema:
                        type: boolean
                        default: false
                        hidden: false
                        show_subquestions_if: true
                        subquestions:
                          - variable: medium
                            label: "EmptyDir Medium"
                            schema:
                              type: string
                              default: ""
                              enum:
                                - value: ""
                                  description: "Default"
                                - value: "Memory"
                                  description: "Memory"
              - variable: accessMode
                label: "Access Mode (Advanced)"
                description: "Allow or disallow multiple PVC's writhing to the same PVC"
                schema:
                  type: string
                  default: "ReadWriteOnce"
                  enum:
                    - value: "ReadWriteOnce"
                      description: "ReadWriteOnce"
                    - value: "ReadOnlyMany"
                      description: "ReadOnlyMany"
                    - value: "ReadWriteMany"
                      description: "ReadWriteMany"
              - variable: size
                label: "Size quotum of storage"
                schema:
                  type: string
                  default: "100Gi"
```

### Unlimited Custom Storage Mounts

We support presenting the user with a "Do it yourself" style list, in which the user can add unlimited paths on the host system to mount.
It should always be included in any App, to give users the option to customise things however they like.

##### Example

```

```
