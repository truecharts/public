# Container Images

Images are hosted on Quay [here](https://quay.io/organization/truecharts).

Some older images can be found on [GitHub Container Registry](https://github.com/orgs/truecharts/packages?ecosystem=container&visibility=public).


## Mirror

We host a dedicated mirror repostiory, these containers are directly fetched from official and/or trusted sources.

### Purpose

We host our own mirror for a multitude of reasons, which includes:

- Getting around Docker Hub rate-limiting
- Preventing upstream maintainers removing tags from breaking our Apps
- Generating usage metrics
- Applying patches
- Improving code uniformity
- Allowing multi-registry failover

### Adding New Containers
Before a chart can be added to the [truecharts/charts](https://github.com/truecharts/charts) repository, you first need to add a container here to the mirror. If you need help with this process please see the **#development** channel in the [TrueCharts Discord Server](https://discord.gg/tVsPTHWTtr).

#### Step 1: Create a Dockerfile
Copy the contents below and substitute the upstream application owner's name with `<Upstream Owner Name>`, `<Upstream App Name>` with the application name, and `<Upstream Tag>` with the upstream tag's name. Also get the digest value of the app and substitute that in for `<Upstream Digest>`.


``` Update Highlighted Row #1
FROM <Upstream Owner Name>/<Upstream App Name>:<Upstream Tag>@sha256:<Upstream Digest>
LABEL org.opencontainers.image.source=https://github.com/truecharts/containers

ARG CONTAINER_NAME
ARG CONTAINER_VER
LABEL org.opencontainers.image.title="${CONTAINER_NAME}"
LABEL org.opencontainers.image.url="https://truecharts.org/docs/charts/${CONTAINER_NAME}"
LABEL org.opencontainers.image.version="${CONTAINER_VER}"
LABEL org.opencontainers.image.description="Container for ${CONTAINER_NAME} by TrueCharts"
LABEL org.opencontainers.image.authors="TrueCharts"
LABEL org.opencontainers.image.documentation="https://truecharts.org/docs/charts/${CONTAINER_NAME}"
```

### Step 2: Create a PLATFORM file
Based on the upstream platform, create a file with that value. Typically the value is `linux/amd64`.

### Step 3: Submit a Pull Request
Once all these steps are completed and you verified that they are correct, please submit a pull request to this repository! When finished, you can create your chart in the [truecharts/charts](https://github.com/truecharts/charts) repository.
