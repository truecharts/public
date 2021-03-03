# Unit tests

We unit test our common library, while it isn't near complete coverage but it does offer some basic checks.

## Running the tests

Running these tests can be done any way you like. In this document we describe a number of approaches:

* [Directly on your development machine](#directly-on-your-development-machine)
* [Through a development container in Visual Studio Code](#using-visual-studio-code)
* [Using a local Docker container](#using-a-local-docker-container)

### Directly on your development machine

First set up the environment:

```console
$ export RUBYJQ_USE_SYSTEM_LIBRARIES=1
$ bundle install
```

Run the tests:

```console
$ bundle exec m -r test/charts
```

### Using Visual Studio Code

Our repo comes with a Visual Studio Code [development container](https://code.visualstudio.com/docs/remote/containers) definition and `launch.json` that allow you to quickly set up an environment in which you can run the tests.

##### Prerequisites

- Visual Studio Code is installed.
- Docker is installed and running.
- The "Remote - Containers" extension is installed and enabled in Visual Studio Code.

For more details, please refer to the [official documentation](https://code.visualstudio.com/docs/remote/containers#_system-requirements).

##### Running tests

Once Visual Studio Code is set up, and you open the `charts` workspace, you will see a popup asking if you wish to re-open the workspace in a development container:

![Visual Studio Code development container popup](https://raw.githubusercontent.com/k8s-at-home/charts/master/docs/images/vscode_devcontainer_popup.png)

Select the option that you prefer. The workspace will be reopened and a Dockerized workspace will be built. You can now use Visual Studio Code as normal.

To run or debug the unit tests, click the "Run" button on the left sidebar and select the desired configuration:

![Visual Studio Code run configurations](https://raw.githubusercontent.com/k8s-at-home/charts/master/docs/images/vscode_run_unittests.png)

* _UnitTest - active spec file only_: This configuration will try to run the currently opened test file.

  **Note:** Make sure that you have opened a valid test file (`.rb` files in the `test/charts` folder), or this will not work.

* _UnitTest - all spec files_: This configuration will run the all test files in the `test/charts` folder.

Next, press the green "Play" icon. This will start the tests show the outcome in a terminal window.

### Using a local Docker container

The [Visual Studio Code development container](#using-visual-studio-code) can also be leveraged without using Visual Studio Code.

##### Prerequisites

- Docker is installed and running.
- You have the charts repo root folder opened in your shell of choice. The commands in this article assume you are running a Bash-compatible shell.

##### Running tests

The first step is to build the development container image containing the required tools. This step only needs to be done once.
To build the container, run this command in your shell:

```console
$ docker build -t k8s-at-home/charts-unit-test -f .devcontainer/Dockerfile .
```

When you wish to run the tests, run this command in your shell:

```console
$ docker run --rm -it -v $(pwd):/charts --entrypoint "/bin/bash" -w /charts k8s-at-home/charts-unit-test -l -c "bundle exec m -r ./test/charts"
```

This will create a container with the charts repo root folder mounted to `/charts` and execute all the test files in the `test/charts` folder.

## Output

A successful test will output something like the following...

```text
Started with run options --seed 52955

common-test::statefulset volumeClaimTemplates
  can set values for volumeClaimTemplates                         PASS (0.16s)
  volumeClaimTemplates should be empty by default                 PASS (0.06s)

common-test::ports settings
  targetPort can be overridden                                    PASS (0.17s)
  port name can be overridden                                     PASS (0.17s)
  defaults to name "http" on port 8080                            PASS (0.16s)
  targetPort cannot be a named port                               PASS (0.05s)

common-test::pod replicas
  defaults to 1                                                   PASS (0.08s)
  accepts integer as value                                        PASS (0.08s)

common-test::Environment settings
  Check no environment variables                                  PASS (0.05s)
  set "valueFrom" environment variables                           PASS (0.11s)
  set "static" and "Dynamic/Tpl" environment variables            PASS (0.15s)
  set "Dynamic/Tpl" environment variables                         PASS (0.11s)
  set "static" environment variables                              PASS (0.10s)

common-test::ingress
  ingress with hosts                                              PASS (0.10s)
  should be disabled when ingress.enabled: false                  PASS (0.06s)
  ingress with hosts template is evaluated                        PASS (0.11s)
  ingress with hosts and tls                                      PASS (0.15s)
  ingress with hosts and tls templates is evaluated               PASS (0.16s)
  should be enabled when ingress.enabled: true                    PASS (0.06s)

common-test::controller type
  accepts "daemonset"                                             PASS (0.06s)
  accepts "statefulset"                                           PASS (0.06s)
  defaults to "Deployment"                                        PASS (0.06s)

Finished in 2.26077s
22 tests, 59 assertions, 0 failures, 0 errors, 0 skips
```
