# Unit tests

We unit test our common library, while it isn't near complete coverage but
it does offer some basic checks.

Running these tests can be done any way you like. In this document we describe
a number of approaches.

## Directly on your development machine

First set up the environment:

```sh
go mod download
```

Run the tests:

```sh
go test ./charts/.../tests
```

## Using Visual Studio Code

Our repo comes with a Visual Studio Code
[development container](https://code.visualstudio.com/docs/remote/containers)
definition and `launch.json` that allow you to quickly set up an environment
in which you can run the tests.

### Prerequisites

- Visual Studio Code is installed.
- Docker is installed and running.
- The "Remote - Containers" extension is installed and enabled in Visual Studio
Code.

For more details, please refer to the
[official documentation](https://code.visualstudio.com/docs/remote/containers#_system-requirements).

### Running tests

Once Visual Studio Code is set up, and you open the `charts` workspace, you
will see a popup asking if you wish to re-open the workspace in a development
container:

![Visual Studio Code development container popup](../../assets/screenshots/vscode_devcontainer_popup.png)

Select the option that you prefer. The workspace will be reopened and a
Dockerized workspace will be built. You can now use Visual Studio Code as
normal.

To run or debug the unit tests, click the "Run" button on the left sidebar
and select the desired configuration:

![Visual Studio Code run configurations](../../assets/screenshots/vscode_run_unittests.png)

- _stable/common tests_: This configuration will run the all test
files for the `common` library chart.

Next, press the green "Play" icon. This will start the tests show the
outcome in a terminal window.

## Using a local Docker container

The [Visual Studio Code development container](#using-visual-studio-code)
can also be leveraged without using Visual Studio Code.

### Prerequisites

- Docker is installed and running.
- You have the charts repo root folder opened in your shell of choice. The
  commands in this article assume you are running a Bash-compatible shell.

### Running tests

The first step is to build the development container image containing the
required tools. This step only needs to be done once. To build the container,
run this command in your shell:

```sh
docker build -t k8s-at-home/charts-unit-test -f .devcontainer/Dockerfile .
```

When you wish to run the tests, run this command in your shell:

```sh
docker run --rm -it -l \
  -v $(pwd):/charts --entrypoint "/bin/bash" \
  -w /charts k8s-at-home/charts-unit-test \
  -c "go mod download && go test ./charts/.../tests"
```

This will create a container with the charts repo root folder mounted to
`/charts` and execute all the test files belonging to the different charts.

!!! note
    Depending on the performance of your environment, this can take a long time
    where it seems as if your machine is not doing anything!

## Output

A successful test will output something like the following...

```text
ok    github.com/k8s-at-home/library-charts/charts/stable/common/tests  54.087s
```
