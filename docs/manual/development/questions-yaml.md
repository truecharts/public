# Questions.yaml
Questions.yaml is the file which get rendered by TrueNAS to create the UI. When not creating new charts, most of what this project does is stitching together questions.yaml files to turn existing Helm Charts into Apps.

### Syntax
In this document we give you a short reference guide (ported from IX Official) which lays out the settings available in questions.yaml.

#### Question Variable Reference
| Variable  | Type | Required | Description |
| ------------- | ------------- | --- |------------- |
|     variable                    | string        | true       |  define the variable name specified in the `values.yaml`file. |
|     label                       | string        | true       |  define the UI label. |
|     description                 | string        | false      |  specify the description of the variable. |
|     group                       | string        | false      |  group questions by input value. |
|     schema                      | dictionary    | true       |  specify schema details for the `variable` |
|     schema.type                 | string        | true       |  specify type of value for `variable` (current supported types are string, int, boolean, path, hostpath, list, dict, ipaddr, and cron).|
|     schema.required             | bool          | false      |  define if the variable is required or not (true \ false), defaults to false |
|     schema.default              | object        | false      |  specify the default value. |
|     schema.min_length           | int           | false      |  min character length for string type variable.|
|     schema.max_length           | int           | false      |  max character length for string type variable.|
|     schema.min                  | int           | false      |  min integer length. |
|     schema.max                  | int           | false      |  max integer length. |
|     schema.enum                 | []dictionary  | false      |  specify the options when the variable type is `string`, for example, <br><br>enum:<br> - value: "RollingUpdate" <br>&nbsp;&nbsp;description: "Create new pods and then kill old ones"<br> - value: "Recreate"<br>&nbsp;&nbsp;description: "Kill existing pods before creating new ones"|
|     schema.valid_chars          | string        | false      |  regular expression for input chars validation. |
|     schema.subquestions         | []subquestion | false      |  add an array of subquestions.|
|     schema.show_if              | string        | false      | show current variable if condition specified is true, for example `show_if: [["workloadType", "=", "CronJob"]]` |
|     schema.show_subquestions_if | string        | false      | show subquestions if is true or equal to one of the options. for example `show_subquestion_if: "static"`. system will convert this to the filters format specifid for `shcema.show_if` automatically.|
|     schema.attrs                | []variables   | false      | specified when `schema.type` is dictionary to declare attributes allowed in the dictionary. |
|     schema.items                | []variables   | false      | specified when `schema.type` is list to declare attributes allowed in the list. |
|     schema.private              | bool          | false      | specified for declaring information sensitive fields. |
|     schema.null                 | bool          | false      | specifies if the value for the variable can be null. defaults to false. |

##### Subquestions
`subquestions[]` cannot contain `subquestions` or `show_subquestions_if` keys, but all other keys in the above table are supported. Also variables having `schema.type` list do not support `subquestions`.
##### Special Questions
There are some novel cases where we would like to provide ability to configure / manage resources for workloads with getting some data from system dynamically.
So a chart can specify certain actions to be performed by the system for a variable by defining a reference. An example better illustrates this concept:
```
- variable: volume
  label: "Volume"
  schema:
    type: dict
    $ref:
      - "normalize/ixVolume"
attrs:
      - variable: mountPath
        label: "Mount Path"
        description: "Path where the volume will be mounted inside the pod"
        schema:
          type: path
          required: true
      - variable: datasetName
label: "Dataset Name"
        schema:
          type: string
          required: true
```
In the above variable we define a `$ref` in schema which specifies that the system should take some action for normalising the value specified for the variable.
In this specific case, `ix_volume` is a concept introduced where we recommend using a volume which we are able to rollback automatically on chart release rollback. In essence,
it is just a `hostPath` volume for which the system automatically creates the dataset specified.
We have following types of actions supported in `$ref` right now:
1) definitions
2) normalize
For (1), system will automatically update schema for a particular definition. For example,
```
- variable: hostInterface
  description: "Please specify host interface"
label: "Host Interface"
  schema:
    type: string
    required: true
    $ref:
      - "definitions/interface"
```
System will automatically populate available interfaces for the user based on what interfaces are available on the system.
For (2), system will normalize values or perform some actions as discussed above.

### Standardised questions.yaml sections
To minimise the maintenance load of our App collection, we always aim to standardise as much as possible. The same goes for questions.yaml. Included here are some code standardised code-snippets that are expected to be included in every App.
Be aware that sometimes specific functions might or might not completely function. Leaving them out would, however, everely increase the maintenance load and often said functionality will be added in the common-chart later on anyway.
##### Groups
To make sure all apps stay somewhat the same, we use a list of standardised groups for the groups section. Please make sure to use these groups in your Apps:
```
groups:
  - name: "Container Image"
    description: "Image to be used for container"
  - name: "Workload Configuration"
    description: "Configure workload deployment"
  - name: "Configuration"
    description: "additional container configuration"
  - name: "Networking"
    description: "Configure Network and Services for container"
  - name: "Storage"
    description: "Persist and share data that is separate from the lifecycle of the container"
  - name: "Resources and Devices"
    description: "Specify resources/devices to be allocated to workload"
  - name: "Ingress Configuration"
    description: "Ingress Configuration"
  - name: "Security"
    description: "Configure security context"
  - name: "Advanced"
    description: "Advanced Configuration"
  - name: "WARNING"
    description: "WARNING"
```

##### General Configuration options
These options are always* included because almost every chart (eventually) has a use for them and/or other parts of the common chart depend on them.
They are called general options, because they affect the basic functionalities of a chart. For example: Custom User environment variables, permissions and timezones.

*`PUID`, `PGID`, `UMASK` are only included when they are needed.

```
  - variable: env
    group: "Configuration"
    label: "Image Environment"
    schema:
      type: dict
      attrs:
        - variable: TZ
          label: "Timezone"
          schema:
            type: string
            default: "Etc/UTC"
            $ref:
        - "definitions/timezone"
        - variable: PUID
          label: "PUID"
          description: "Sets the PUID env var for LinuxServer.io (compatible) containers"
          schema:
            type: int
            default: 568
        - variable: PGID
          label: "PGID"
          description: "Sets the PGID env var for LinuxServer.io (compatible) containers"
          schema:
            type: int
            default: 568
        - variable: UMASK
          label: "UMASK"
          description: "Sets the UMASK env var for LinuxServer.io (compatible) containers"
          schema:
            type: string
            default: "002"

  # Configure Custom Enviroment Variables
  - variable: environmentVariables
    label: "Image environment"
    group: "Configuration"
    schema:
      type: list
      default: []
      items:
        - variable: environmentVariable
          label: "Environment Variable"
          schema:
            type: dict
            attrs:
              - variable: name
                label: "Name"
                schema:
                  type: string
              - variable: value
                label: "Value"
                schema:
                  type: string
```

##### Security Context Configuration options

```
  # Enable privileged
  - variable: securityContext
    group: "Security"
    label: "Security Context"
    schema:
      type: dict
      attrs:
        - variable: privileged
          label: "Enable privileged mode for Common-Chart based charts"
          schema:
            type: boolean
            default: false
  # Set Pod Security Policy
  - variable: podSecurityContext
    group: "Security"
    label: "Pod Security Context"
    schema:
      type: dict
      attrs:
        - variable: runAsNonRoot
          label: "runAsNonRoot"
          schema:
            type: boolean
            default: true
        - variable: runAsUser
          label: "runAsUser"
          description: "The UserID of the user running the application"
          schema:
            type: int
            default: 568
        - variable: runAsGroup
          label: "runAsGroup"
          description: The groupID this App of the user running the application"
          schema:
            type: int
            default: 568
        - variable: fsGroup
          label: "fsGroup"
          description: "The group that should own ALL storage."
          schema:
            type: int
            default: 568
        - variable: fsGroupChangePolicy
          label: "When should we take ownership?"
          schema:
            type: string
            default: "OnRootMismatch"
            enum:
              - value: "OnRootMismatch"
                description: "OnRootMismatch"
              - value: "Always"
                description: "Always"
```
