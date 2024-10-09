package proxy

import (
    "net/http"
)

func HealthCheckHandler(w http.ResponseWriter, r *http.Request) {
    w.WriteHeader(http.StatusOK)
    w.Write([]byte("healthy"))
}
