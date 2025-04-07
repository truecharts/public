# Stage 1 - Build the Go application
FROM golang:1.24.2-alpine@sha256:7772cb5322baa875edd74705556d08f0eeca7b9c4b5367754ce3f2f00041ccee AS builder

# Install necessary build dependencies
RUN apk --no-cache add --update gcc musl-dev

# Create the necessary directories
RUN mkdir -p /build /output

# Set the working directory
WORKDIR /build

# Copy go mod and sum files
COPY ./containers/apps/kube-sa-proxy/go.mod ./containers/apps/kube-sa-proxy/go.sum ./

# Download dependencies
RUN go mod download

# Copy the rest of the Go application source code
COPY ./containers/apps/kube-sa-proxy/cmd/main.go .
COPY ./containers/apps/kube-sa-proxy/internal/config ./internal/config
COPY ./containers/apps/kube-sa-proxy/internal/proxy ./internal/proxy
COPY ./containers/apps/kube-sa-proxy/internal/utils ./internal/utils

# Build the Go application
RUN go build -ldflags "-w -s" -o /output/my-proxy-service .

# Stage 2 - Create the final image
FROM alpine@sha256:a8560b36e8b8210634f77d9f7f9efd7ffa463e380b75e2e74aff4511df3ef88c AS runner

# Install necessary runtime dependencies
RUN apk --no-cache add ca-certificates

# Set the working directory
WORKDIR /app

# Copy the binary from the builder stage
COPY --from=builder /output/my-proxy-service .

# Set environment variables
ENV PORT=3000

# Expose the port
EXPOSE $PORT

# Set the default command to run the binary
CMD sh -c "./my-proxy-service"
