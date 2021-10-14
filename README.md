<p align="center">
 <a href="https://discord.gg/Q3St5fPETd"><img alt="Join Discord" src="https://badgen.net/discord/members/Q3St5fPETd/?icon=discord&label=Join%20the%20TrueNAS%20Community" /></a>
 <a href="https://www.truenas.com/community/"><img alt="Join Forums" src="https://badgen.net/badge/Forums/Post%20Now//purple" /></a> 
 <a href="https://jira.ixsystems.com"><img alt="File Issue" src="https://badgen.net/badge/Jira/File%20Issue//red?icon=jira" /></a>
</p>

# iX Official Catalog

A curated collection of TrueNAS SCALE enhanced Helm charts.

## TrueNAS SCALE Chart Structure

A TrueNAS SCALE chart repository differs slightly in directory structure from upstream repos in that it includes an `app version` directory.

A TrueNAS SCALE chart also has three additional files an `app-readme.md` file that provides a high level overview display in the TrueNAS SCALE UI and a `questions.yaml` file defining questions to prompt the user with and an `item.yaml` file outlining item specific details. 

There are 2 directories `charts` and `test`, each representing a train. Chart releases created from catalog items in a specific train cannot be moved to another train. Currently only the `charts` train can be used inside the UI.

```
charts/ix-chart/<chart version>/
  app-readme.md            # TrueNAS SCALE Specific: Readme file for display in TrueNAS SCALE UI
  charts/                  # Directory containing dependency charts
  Chart.yaml               # Required Helm chart information file
  questions.yaml           # TrueNAS SCALE Specific: File containing questions for TrueNAS SCALE UI
  README.md                # Optional: Helm Readme file (will be rendered in TrueNAS SCALE UI as well)
  templates/               # A directory of templates that, when combined with values.yml will generate K8s YAML
  values.yaml              # The default configuration values for this chart
```
*See the upstream Helm chart [developer reference](https://helm.sh/docs/chart_template_guide/) for a complete walk through of developing charts.*

To convert an upstream chart to take advantage of TrueNAS SCALE enhanced UX, first create an `item.yaml` file.
This file among other catalog item information provides a list of categories that this chart fits into. This helps users navigate and filtering when browsing the catalog UI.

```
$ cat charts/ix-chart/item.yaml
categories:
  - generic
icon_url: "http://ix_url"
```

After that create `app-readme.md` file.

```
$ cat charts/ix-chart/<chart version>/app-readme.md

# iX-Chart

iX-chart is a chart designed to let user deploy a docker image in a TrueNAS SCALE kubernetes cluster.
It provides a mechanism to specify workload type, add external host interfaces in the pods, configure volumes and allocate host resources to the workload.
```

Then add a `questions.yaml` file to prompt the user for something.

```
groups:
  - name: "Container Images"
    description: "Image to be used for container"
questions:
  - variable: image
    description: "Docker Image Details"
    group: "Container Images"
    schema:
      type: dict
      required: true
      attrs:
        - variable: repository
          description: "Docker image repository"
          label: "Image repository"
          schema:
            type: string
            required: true
        - variable: tag
          description: "Tag to use for specified image"
          label: "Image Tag"
          schema:
            type: string
            default: "latest"
        - variable: pullPolicy
          description: "Docker Image Pull Policy"
          label: "Image Pull Policy"
          schema:
            type: string
            default: "IfNotPresent"
            enum:
              - value: "IfNotPresent"
                description: "Only pull image if not present on host"
              - value: "Always"
                description: "Always pull image even if present on host"
              - value: "Never"
                description: "Never pull image even if it's not present on host"
```

The above will prompt the user with 2 text fields and a dropdown in the UI getting details for image configuration in a helm chart.

#### Question Variable Reference

| Variable  | Type | Required | Description |
| ------------- | ------------- | --- |------------- |
| 	variable                    | string        | true       |  define the variable name specified in the `values.yaml`file. |
| 	label                       | string        | true       |  define the UI label. |
| 	description                 | string        | false      |  specify the description of the variable. |
| 	group                       | string        | false      |  group questions by input value. |
| 	schema                      | dictionary    | true       |  specify schema details for the `variable` |
| 	schema.type                 | string        | true       |  specify type of value for `variable` (current supported types are string, int, boolean, path, hostpath, list, dict, ipaddr, and cron).|
| 	schema.required             | bool          | false      |  define if the variable is required or not (true \ false), defaults to false |
| 	schema.default              | object        | false      |  specify the default value. |
| 	schema.min_length           | int           | false      |  min character length for string type variable.|
| 	schema.max_length           | int           | false      |  max character length for string type variable.|
| 	schema.min                  | int           | false      |  min integer length. |
| 	schema.max                  | int           | false      |  max integer length. |
| 	schema.enum                 | []dictionary  | false      |  specify the options when the variable type is `string`, for example, <br><br>enum:<br> - value: "RollingUpdate" <br>&nbsp;&nbsp;description: "Create new pods and then kill old ones"<br> - value: "Recreate"<br>&nbsp;&nbsp;description: "Kill existing pods before creating new ones"|
| 	schema.valid_chars          | string        | false      |  regular expression for input chars validation. |
| 	schema.subquestions         | []subquestion | false      |  add an array of subquestions.|
| 	schema.show_if              | string        | false      | show current variable if condition specified is true, for example `show_if: [["workloadType", "=", "CronJob"]]` |
| 	schema.show_subquestions_if | string        | false      | show subquestions if is true or equal to one of the options. for example `show_subquestion_if: "static"`. system will convert this to the filters format specifid for `shcema.show_if` automatically.|
| 	schema.attrs                | []variables   | false      | specified when `schema.type` is dictionary to declare attributes allowed in the dictionary. |
| 	schema.items                | []variables   | false      | specified when `schema.type` is list to declare attributes allowed in the list. |
| 	schema.private              | bool          | false      | specified for declaring information sensitive fields. |
| 	schema.null                 | bool          | false      | specifies if the value for the variable can be null. defaults to false. |

**subquestions**: `subquestions[]` cannot contain `subquestions` or `show_subquestions_if` keys, but all other keys in the above table are supported. Also variables having `schema.type` list do not support `subquestions`.

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
