package main

import (
    "flag"
    "fmt"
    "log"
    "net/http"

    "my-proxy-service/internal/config"
    "my-proxy-service/internal/proxy"
    "my-proxy-service/internal/utils"
)

func main() {
    flag.Parse()

    config.LoadConfig()

    go utils.WatchFile()

    http.HandleFunc(config.ROUTES.INDEX, proxy.HandleProxy)
    http.HandleFunc(config.ROUTES.HEALTH, proxy.HealthCheckHandler)
    log.Fatal(http.ListenAndServe(fmt.Sprintf(":%d", config.Port), nil))
}
