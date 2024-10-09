# File Auth Proxy Service

File Auth Proxy Service is a lightweight Go application designed to act as a proxy server, forwarding HTTP requests to a specified target URL while handling authentication using an API key stored in a file. This service dynamically monitors changes to the API key file, ensuring seamless updates without service interruption. With File Auth Proxy Service, you can securely proxy requests while easily managing authentication credentials.

## Features

- Proxy server for HTTP requests
- Authentication with API key stored in a file
- Dynamic monitoring of the API key file for updates
- Lightweight and easy to deploy

## Getting Started

To get started with File Auth Proxy Service, follow these steps:

1. Clone this repository.
2. Build the project using `go build`.
3. Run the executable, specifying the desired port, API file path, proxy target URL, and authentication token header.

```bash
./my-proxy-service -port <port> -api-file <api-file-path> -proxy-target <proxy-target-url> -auth-token-header <auth-token-header-name>
```

## Docker Usage and Environment Variables

To run the File Auth Proxy Service using Docker, use the provided Docker image:

### docker run

The volume can be _ANY_ path like the port can be set to whatever you want; if you change the PORT env, you need to change the internal port too...

```bash
docker run -d -p 3000:3000 \
  -v /path/to/local/config:/config \
  -e PORT=3000 \
  -e API_FILE=/config/api-key \
  -e PROXY_TARGET=http://example.com \
  -e AUTH_TOKEN_HEADER=authorization \
  ghcr.io/xstar97/my-proxy-service:latest
```

### docker-compose

The volume can be _ANY_ path like the port can be set to whatever you want; if you change the PORT env, you need to change the internal port too...

```yaml
version: '3.8'

services:
  my-proxy-service:
    image: ghcr.io/xstar97/my-proxy-service:latest
    ports:
      - "3000:3000"
    environment:
      - PORT=3000
      - API_FILE=/config/api-key
      - PROXY_TARGET=http://example.com
      - AUTH_TOKEN_HEADER=authorization
    volumes:
      - /path/to/local/config:/config
```
